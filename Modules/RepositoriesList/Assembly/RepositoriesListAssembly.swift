//
//  RepositoriesListAssembly.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 12.06.2024.
//

import UIKit

class RepositoriesListAssembly {
    static func build() -> UIViewController {
        let dataSource = RepositoriesListTableViewDataSource()
        let dataRepository = RepositoriesListDataRepository()
        let presenter = RepositoriesListPresenter(dataSource: dataSource, dataRepository: dataRepository)
        let viewController = RepositoriesListViewController(presenter: presenter)
        return viewController
    }
}
