//
//  RepositoriesListDataRepository.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 15.06.2024.
//

import Foundation

class RepositoriesListDataRepository {
    private var storageData: [RepositoriesListModel] = []
}

extension RepositoriesListDataRepository: IRepositoriesListDataRepository {
    
    func getRepositories(completion: @escaping (Result<[RepositoriesListModel], any Error>) -> Void) {
        
        NetworkService.getRepositories.fetch { [weak self] result in
            switch result {
            case .success(let success):
                switch success {
                case .repositoriesListModel(let model):
                    self?.storageData = model
                    completion(.success(model))
                default:
                    break
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func logOut() {
        NetworkService.getRepositories.logOut()
    }
    
    func getRepositories() -> [RepositoriesListModel] {
        return storageData
    }
}
