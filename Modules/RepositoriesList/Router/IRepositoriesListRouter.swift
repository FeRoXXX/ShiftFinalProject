//
//  IRepositoriesListRouter.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 18.06.2024.
//

import Foundation

protocol IRepositoriesListRouter {
    
    func routeToRepositoryDetail()
    func setupUI(_ viewController: RepositoriesListViewController)
    func routeToFirstViewController()
}
