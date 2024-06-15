//
//  RepositoriesListDataRepository.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 15.06.2024.
//

import Foundation

class RepositoriesListDataRepository {}

extension RepositoriesListDataRepository: IRepositoriesListDataRepository {
    
    func getRepositories(completion: @escaping (Result<[RepositoriesListModel], any Error>) -> Void) {
        
        NetworkService.getRepository.fetch { result in
            switch result {
            case .success(let success):
                switch success {
                case .repositoriesListModel(let model):
                    completion(.success(model))
                default:
                    break
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
