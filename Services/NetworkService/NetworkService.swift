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
    case getRepository(_ requestSettings: RequestSettings)
    case getReadmeFile(_ requestSettings: RequestSettings)

    private var urlSession: URLSession {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }
    
    private var reEntryService: IReEntryService {
        let reEntryService = ReEntryService()
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
    
    private func makeRequest() -> URLRequest? {
        switch self {
        case .signIn(let token):
            let baseComponent = URLComponents(string: "https://api.github.com/user")
            guard let baseComponentURL = baseComponent?.url else {
                fatalError() //TODO: MAKE ALERT
            }

            var request = URLRequest(url: baseComponentURL)
            request.httpMethod = "GET"

            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Accept")

            return request
        case .getRepositories:
            let baseComponent = URLComponents(string: "https://api.github.com/users/icerockdev/repos")
            guard let baseComponentURL = baseComponent?.url else {
                fatalError() //TODO: Make alert
            }
            
            var request = URLRequest(url: baseComponentURL)
            request.httpMethod = "GET"
            
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            return request
        case .getRepository(let requestSettings):
            let baseComponent = URLComponents(string: "https://api.github.com/repos/\(requestSettings.ownerName)/\(requestSettings.repositoryName)")
            guard let baseComponentURL = baseComponent?.url else {
                fatalError() //TODO: Make alert
            }
            
            var request = URLRequest(url: baseComponentURL)
            request.httpMethod = "GET"
            
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            return request
        case .getReadmeFile(let requestSettings):
            let baseComponent = URLComponents(string: "https://raw.githubusercontent.com/\(requestSettings.ownerName)/\(requestSettings.repositoryName)/\(requestSettings.branchName!)/README.md")
            guard let baseComponentURL = baseComponent?.url else {
                fatalError() //TODO: Make alert
            }
            
            var request = URLRequest(url: baseComponentURL)
            request.httpMethod = "GET"
            
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            return request
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
            return .success(GeneralModel.repositoryReadme(data))
        }
    }
}
