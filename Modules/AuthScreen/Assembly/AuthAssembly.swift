//
//  AuthAssembly.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 11.06.2024.
//

import UIKit

class AuthAssembly {
    static func build() -> UIViewController {
        let dataRepository = AuthDataRepository()
        let presenter = AuthPresenter(dataRepository: dataRepository)
        let viewController = AuthViewController(presenter: presenter)
        return viewController
    }
}
