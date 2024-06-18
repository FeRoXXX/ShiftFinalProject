//
//  IRepositoryDetailRouter.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 18.06.2024.
//

import Foundation

protocol IRepositoryDetailRouter {
    func routToFirstViewController()
    func setupRouter(_ sourceVC: RepositoryDetailViewController)
}
