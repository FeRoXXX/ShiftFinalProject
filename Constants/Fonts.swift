//
//  Fonts.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 11.06.2024.
//

import UIKit

enum Fonts {
    static let highFont: UIFont = .systemFont(ofSize: 16)
    static let middleFont: UIFont = .systemFont(ofSize: 14)
    static let smallFont: UIFont = .systemFont(ofSize: 12)
    static let textFieldsPlaceholderFont: [NSAttributedString.Key: Any] = [.font: Fonts.highFont,
                                                                           .foregroundColor: Colors.placeholderAndNoSelectedColor]
}
