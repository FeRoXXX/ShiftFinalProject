//
//  Errors.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 16.06.2024.
//

import Foundation

enum Errors: Error {
    case serverError
    case clientError
    case newDomain
    
    enum Alerts: String {
        case connectionError = "Connection error"
        case loadError = "Load error"
        case somethingError = "Something Error"
        case emptyError = "Empty"
        case emptyReadme = "Empty Readme file"
        
        static func getDescription(by error: Alerts) -> String {
            switch error {
            case .connectionError, .loadError:
                "Check your Internet connection"
            case .somethingError:
                "Check your something"
            case .emptyError:
                "No repositories at the moment"
            case .emptyReadme:
                "Readme doesn't exist try again later"
            }
        }
    }
}
