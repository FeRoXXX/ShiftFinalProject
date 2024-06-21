//
//  RepositoriesListRouter.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 16.06.2024.
//

import Foundation

final class RepositoriesListRouter {
    
    private weak var viewController: RepositoriesListViewController?
    private var dataStore: RepositoryListDataStore?
    
    init(dataStore: RepositoryListDataStore) {
        self.dataStore = dataStore
    }
}

extension RepositoriesListRouter: IRepositoriesListRouter {
    
    func routeToRepositoryDetail() {
        guard let viewController,
              let dataStore else { return }
        
        var (destinationVC, destinationDS) = RepositoryDetailAssembly.build()
        
        passDataToDetail(source: dataStore, destination: &destinationDS)
        navigateToDetail(source: viewController, destination: destinationVC)
    }
    
    func routeToFirstViewController() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
    
    func setupUI(_ viewController: RepositoriesListViewController) {
        self.viewController = viewController
    }
}

private extension RepositoriesListRouter {
    
    func navigateToDetail(source: RepositoriesListViewController, destination: RepositoryDetailViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    func passDataToDetail(source: RepositoryListDataStore, destination: inout RepositoryDetailDataStore) {
        destination.dataStore = source.chosenRepository
    }
}
