//
//  Colors.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 11.06.2024.
//

import UIKit

enum Colors {
    static let backgroundColor = #colorLiteral(red: 0.05118062347, green: 0.06589940935, blue: 0.08866138011, alpha: 1)
    static let textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let placeholderAndNoSelectedColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
    static let buttonColor = #colorLiteral(red: 0.3535858393, green: 0.5764598846, blue: 0.3412804008, alpha: 1)
    static let errorColor = #colorLiteral(red: 0.7960784314, green: 0.3098039216, blue: 0.3098039216, alpha: 1)
    static let textFieldBorderSelected = #colorLiteral(red: 0.3449212611, green: 0.6503628492, blue: 0.9986084104, alpha: 1)
    static let repositoryNameLabel = #colorLiteral(red: 0.3449212611, green: 0.6503628492, blue: 0.9986084104, alpha: 1)
    static let cellBackground = UIColor.clear
    static let separatorColor = #colorLiteral(red: 0.1294117647, green: 0.1490196078, blue: 0.1764705882, alpha: 1)
    static let navigationBarItemsColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
}

enum LanguageColors: String {
    case swift = "Swift"
    case baseC = "C"
    case cPlusPlus = "C++"
    case cSharp = "C#"
    case kotlin = "Kotlin"
    case java = "Java"
    case python = "Python"
    case html = "HTML"
    case javaScript = "JavaScript"
    
    var color: UIColor {
        switch self {
        case .swift:
            #colorLiteral(red: 1, green: 0.6760933399, blue: 0.2729836106, alpha: 1)
        case .baseC, .cPlusPlus, .cSharp:
            #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        case .kotlin:
            #colorLiteral(red: 0.9430684447, green: 0.5580074191, blue: 0.20017156, alpha: 1)
        case .java:
            #colorLiteral(red: 0.6896252036, green: 0.4480988979, blue: 0.09757787734, alpha: 1)
        case .python:
            #colorLiteral(red: 0.2082723677, green: 0.4486870766, blue: 0.6478357315, alpha: 1)
        case .html:
            #colorLiteral(red: 0.89014256, green: 0.2978732288, blue: 0.1471491754, alpha: 1)
        case .javaScript:
            #colorLiteral(red: 0.9443149567, green: 0.8801144958, blue: 0.3525030613, alpha: 1)
        }
    }
}
