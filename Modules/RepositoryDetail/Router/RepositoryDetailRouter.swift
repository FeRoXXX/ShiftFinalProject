//
//  RepositoryDetailRouter.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 18.06.2024.
//

import Foundation

class RepositoryDetailRouter {
    private var sourceVC: RepositoryDetailViewController?
}

extension RepositoryDetailRouter: IRepositoryDetailRouter {
    
    func routToFirstViewController() {
        sourceVC?.navigationController?.popToRootViewController(animated: true)
    }
    
    func setupRouter(_ sourceVC: RepositoryDetailViewController) {
        self.sourceVC = sourceVC
    }
}
