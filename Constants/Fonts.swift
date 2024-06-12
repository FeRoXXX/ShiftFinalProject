//
//  Fonts.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 11.06.2024.
//

import UIKit

enum Fonts {
    static let textFieldsFont: UIFont = .systemFont(ofSize: 16)
    static let repositoryDescriptionFont: UIFont = .systemFont(ofSize: 14)
    static let errorAlertFont: UIFont = .systemFont(ofSize: 12)
//    static let textFieldsTextFont: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16),
//                                                                    .foregroundColor: Colors.textColor]
    static let textFieldsPlaceholderFont: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16),
                                                                           .foregroundColor: Colors.placeholderAndNoSelectedColor]
}
