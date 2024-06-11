//
//  AuthAssembly.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 11.06.2024.
//

import UIKit

class AuthAssembly {
    static func build() -> UIViewController {
        let presenter = AuthPresenter()
        let viewController = AuthViewController(presenter: presenter)
        return viewController
    }
}
