//
//  RepositoryDetailDataRepository.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 16.06.2024.
//

import Foundation

final class RepositoryDetailDataRepository {
    private var requestSettings: ChoseRepositoryModel?
}

extension RepositoryDetailDataRepository: IRepositoryDetailDataRepository {
    
    func getDetail(completion: @escaping (Result<RepositoryDetailModel, Error>) -> Void) {
        guard let requestSettings else {
            return completion(.failure(Errors.clientError))
        }
        NetworkService.getRepository(requestSettings).fetch { result in
            switch result {
            case .success(let success):
                switch success {
                case .repositoryDetailModel(let model):
                    completion(.success(model))
                default:
                    completion(.failure(Errors.serverError))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func getReadme(completion: @escaping (Result<ReadmeDataModel, Error>) -> Void) {
        guard let requestSettings else {
            return completion(.failure(Errors.clientError))
        }
        
        NetworkService.getReadmeFile(requestSettings).fetch { result in
            switch result {
            case .success(let success):
                switch success {
                case .repositoryReadme(let model):
                    completion(.success(model))
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
        requestSettings = settings
    }
}
