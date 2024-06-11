//
//  IAuthPresenter.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 11.06.2024.
//

import Foundation

protocol IAuthPresenter {
    func viewLoaded(ui: IAuthViewController)
    func textFieldSelected()
    func textFieldNoSelected(text: String?)
    func signInButtonClicked(text: String?)
    func hideKeyboard()
}
