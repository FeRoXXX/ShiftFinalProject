//
//  RepositoryDetailAssembly.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 16.06.2024.
//

import Foundation

final class RepositoryDetailAssembly {
    static func build() -> (RepositoryDetailViewController, RepositoryDetailDataStore) {
        let dataRepository = RepositoryDetailDataRepository()
        let presenter = RepositoryDetailPresenter(dataRepository: dataRepository)
        let router = RepositoryDetailRouter()
        let viewController = RepositoryDetailViewController(presenter: presenter, router: router)
        return (viewController, presenter)
    }
}
