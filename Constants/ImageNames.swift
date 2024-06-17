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
    enum RepositoryStat: String, CaseIterable {
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
}
