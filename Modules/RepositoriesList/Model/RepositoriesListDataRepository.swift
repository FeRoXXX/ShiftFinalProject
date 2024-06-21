//
//  RepositoriesListDataRepository.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 15.06.2024.
//

import Foundation

class RepositoriesListDataRepository {
    private var storageData: [RepositoriesListModel] = []
    private var identifier: DataRepositoryIdentifier
    
    init(identifier: DataRepositoryIdentifier) {
        self.identifier = identifier
    }
}

extension RepositoriesListDataRepository: IRepositoriesListDataRepository {
    
    func getRepositories(completion: @escaping (Result<[RepositoriesListModel], Error>) -> Void) {
        
        switch identifier {
        case .getFromInternet:
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
        case .getFromLocal:
            CoreDataService.shared.fetchRepositories { result in
                storageData = result.map { RepositoriesListModel(id: Int($0.id)!,
                                                                 name: $0.name,
                                                                 description: $0.repositoryDescription,
                                                                 language: $0.language,
                                                                 owner: Owner(login: $0.ownerName)) }
                completion(.success(storageData))
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

enum DataRepositoryIdentifier {
    case getFromInternet
    case getFromLocal
}
