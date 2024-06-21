//
//  NetworkService.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 13.06.2024.
//

import Foundation

enum NetworkService {
    case signIn(token: String)
    case getRepositories
    case getRepository(_ requestSettings: ChoseRepositoryModel)
    case getReadmeFile(_ requestSettings: ChoseRepositoryModel)

    private var urlSession: URLSession {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        config.httpAdditionalHeaders = ["Accept": "application/json"]
        guard let token = reEntryService.getAuthToken() else {
            return URLSession(configuration: config)
        }
        config.httpAdditionalHeaders?["Authorization"] = "Bearer \(token)"
        
        return URLSession(configuration: config)
    }
    
    private var reEntryService: IUserDataStorageService {
        let reEntryService = UserDataStorageService()
        return reEntryService
    }
}

extension NetworkService {

    func fetch(completion: @escaping (Result<GeneralModel, Error>) -> Void) {
        guard let request = makeRequest() else {
            fatalError()
        }

        let task = urlSession.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
            } else if let httpResponse = response as? HTTPURLResponse,
                      let data {
                let statusCode = httpResponse.statusCode
                switch statusCode {
                    case 200...299:
                        completion(decodeData(data))
                    case 300...399:
                        completion(.failure(Errors.newDomain))
                    case 400...499:
                        completion(.failure(Errors.clientError))
                    case 500...599:
                        completion(.failure(Errors.serverError))
                    default:
                        break
                }
            }
        }
        task.resume()
    }
    
    func checkSignIn() -> Bool {
        if reEntryService.getReposURL() != nil {
            true
        } else {
            false
        }
    }
    
    private func makeRequest() -> URLRequest? {
        switch self {
        case .signIn(let token):
            let baseComponent = URLComponents(string: "https://api.github.com/user")
            guard let baseComponentURL = baseComponent?.url else {
                fatalError(Errors.Alerts.somethingError.rawValue)
            }

            var request = URLRequest(url: baseComponentURL)

            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            reEntryService.setAuthToken(token: token)
            return request
        case .getRepositories:
            guard let reposURL = reEntryService.getReposURL() else {
                fatalError(Errors.Alerts.somethingError.rawValue)
            }
            let baseComponent = URLComponents(string: "https://api.github.com/users/icerockdev/repos")
            guard let baseComponentURL = baseComponent?.url else {
                fatalError(Errors.Alerts.somethingError.rawValue)
            }
            
            return URLRequest(url: baseComponentURL)
        case .getRepository(let requestSettings):
            let baseComponent = URLComponents(string: "https://api.github.com/repos/\(requestSettings.ownerName)/\(requestSettings.repositoryName)")
            guard let baseComponentURL = baseComponent?.url else {
                fatalError(Errors.Alerts.somethingError.rawValue)
            }
            
            return URLRequest(url: baseComponentURL)
        case .getReadmeFile(let requestSettings):
            let baseComponent = URLComponents(string: "https://api.github.com/repos/\(requestSettings.ownerName)/\(requestSettings.repositoryName)/readme")
            guard let baseComponentURL = baseComponent?.url else {
                fatalError(Errors.Alerts.somethingError.rawValue)
            }
            
            return URLRequest(url: baseComponentURL)
        }
    }
    
    func logOut() {
        reEntryService.removeData()
    }
    
    private func decodeData(_ data: Data) -> Result<GeneralModel, Error> {
        switch self {
        case .signIn(_):
            do {
                let decodedData = try JSONDecoder().decode(AuthDataModel.self, from: data)
                reEntryService.setReposURL(reposURL: decodedData.repos_url)
                return .success(GeneralModel.authModel(decodedData))
            } catch {
                return .failure(error)
            }
        case .getRepositories:
            do {
                let decodedData = try JSONDecoder().decode([RepositoriesListModel].self, from: data)
                return .success(GeneralModel.repositoriesListModel(decodedData))
            } catch {
                return .failure(error)
            }
        case .getRepository:
            do {
                let decodedData = try JSONDecoder().decode(RepositoryDetailModel.self, from: data)
                return .success(GeneralModel.repositoryDetailModel(decodedData))
            } catch {
                return .failure(error)
            }
        case .getReadmeFile:
            do {
                let decodedData = try JSONDecoder().decode(ReadmeDataModel.self, from: data)
                return .success(GeneralModel.repositoryReadme(decodedData))
            } catch {
                return .failure(error)
            }
        }
    }
}
