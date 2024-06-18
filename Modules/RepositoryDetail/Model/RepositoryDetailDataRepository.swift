//
//  RepositoryDetailDataRepository.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 16.06.2024.
//

import Foundation

final class RepositoryDetailDataRepository {
    private var requestSettings: RequestSettings?
}

extension RepositoryDetailDataRepository: IRepositoryDetailDataRepository {
    
    func getDetail(completion: @escaping (Result<RepositoryDetailModel, Error>) -> Void) {
        guard let requestSettings else {
            return completion(.failure(Errors.clientError))
        }
        NetworkService.getRepository(requestSettings).fetch { [weak self] result in
            switch result {
            case .success(let success):
                switch success {
                case .repositoryDetailModel(let model):
                    self?.requestSettings?.branchName = model.default_branch
                    completion(.success(model))
                default:
                    completion(.failure(Errors.serverError))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func getReadme(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let requestSettings,
            requestSettings.branchName != nil else {
            return completion(.failure(Errors.clientError))
        }
        
        NetworkService.getReadmeFile(requestSettings).fetch { result in
            switch result {
            case .success(let success):
                switch success {
                case .repositoryReadme(let data):
                    completion(.success(data))
                default:
                    completion(.failure(Errors.serverError))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func logOut() {
        NetworkService.getRepositories.logOut()
    }
    
    func setupSettings(_ settings: ChoseRepositoryModel) {
        requestSettings = RequestSettings(ownerName: settings.ownerName, repositoryName: settings.repositoryName, branchName: nil)
    }
}
