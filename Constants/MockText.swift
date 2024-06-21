//
//  MockText.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 11.06.2024.
//

import Foundation

enum MockText {
    enum AuthViewText {
        static let placeholderText: String = "Personal access token"
        static let buttonText: String = "Sign In"
        static let errorText: String = "Invalid token"
    }
    
    enum RepositoriesListText {
        static let titleText: String = "Repositories"
    }
    
    enum RepositoryDetailText {
        static let licenseText: String = "License"
        
        enum RepositoryStatText {
            static let starsText: String = "stars"
            static let forksText: String = "forks"
            static let watchersText: String = "watchers"
            
            static func getStatText(by statName: RepositoryStatName) -> String {
                switch statName {
                case .stars:
                    starsText
                case .forks:
                    forksText
                case .watchers:
                    watchersText
                }
            }
        }
    }
    
    enum AlertButtonText: String {
        case Retry
        case Refresh
        
        static func getText(by error: Errors.Alerts) -> String {
            switch error {
            case .connectionError, .loadError, .somethingError:
                Retry.rawValue
            case .emptyError, .emptyReadme:
                Refresh.rawValue
            }
        }
    }
}
