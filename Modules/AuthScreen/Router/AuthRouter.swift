//
//  AuthRouter.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 14.06.2024.
//

import Foundation

protocol IAuthRouter {
    func routeToRepositoriesList()
    func routeToRepositoriesListFavorite()
    func setupUI(_ viewController: AuthViewController)
}

final class AuthRouter {
    
    private weak var viewController: AuthViewController?
}

extension AuthRouter: IAuthRouter {
    
    func routeToRepositoriesListFavorite() {
        let destinationVC = RepositoriesListAssembly.build(identifier: .getFromLocal)
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeToRepositoriesList() {
        let destinationVC = RepositoriesListAssembly.build(identifier: .getFromInternet)
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func setupUI(_ viewController: AuthViewController) {
        self.viewController = viewController
    }
}
