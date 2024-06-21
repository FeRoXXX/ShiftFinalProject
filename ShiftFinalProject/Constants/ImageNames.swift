//
//  ImageNames.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 11.06.2024.
//

import Foundation

enum ImageNames: String {
    case AppLogo
    case Quit
    case URLImage
    case License
    case chevronLeft = "chevron.left"
    case star
    case starFill = "star.fill"
    enum RepositoryStat: String {
        case Stars
        case Forks
        case Watchers
        
        static func getImageName(by statName: RepositoryStatName) -> String {
            switch statName {
            case .stars:
                Stars.rawValue
            case .forks:
                Forks.rawValue
            case .watchers:
                Watchers.rawValue
            }
        }
    }
    
    enum AlertsImage: String {
        case InternetConnection
        case Path
        case Something
        
        static func getImageName(by alert: Errors.Alerts) -> String {
            switch alert {
            case .connectionError, .loadError:
                InternetConnection.rawValue
            case .somethingError:
                Something.rawValue
            case .emptyError, .emptyReadme:
                Path.rawValue
            }
        }
    }
}
