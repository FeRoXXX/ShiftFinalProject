//
//  RepositoriesListAssembly.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 12.06.2024.
//

import UIKit

class RepositoriesListAssembly {
    static func build(identifier: DataRepositoryIdentifier) -> UIViewController {
        let dataSource = RepositoriesListTableViewDataSource()
        let dataRepository = RepositoriesListDataRepository(identifier: identifier)
        let presenter = RepositoriesListPresenter(dataSource: dataSource, dataRepository: dataRepository)
        let router = RepositoriesListRouter(dataStore: presenter)
        let viewController = RepositoriesListViewController(presenter: presenter, router: router)
        return viewController
    }
}
