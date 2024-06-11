//
//  AuthPresenter.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 11.06.2024.
//

import Foundation

class AuthPresenter {
    private weak var ui: IAuthViewController?
    
}

extension AuthPresenter: IAuthPresenter {
    
    func viewLoaded(ui: IAuthViewController) {
        self.ui = ui
    }
    
    func textFieldSelected() {
        ui?.setupSelectedTextField()
    }
    
    func textFieldNoSelected(text: String?) {
        guard let text,
              text.isEmpty else {
            return
        }
        ui?.setupNoSelectedTextField()
    }
    
    func signInButtonClicked(text: String?) {
        ui?.hideKeyboard()
        ui?.setupNoSelectedTextField()
        guard let text,
            !text.isEmpty else {
                ui?.setupErrorTextField()
                return
        }
        
    }
    
    func hideKeyboard() {
        ui?.hideKeyboard()
    }
}
