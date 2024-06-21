//
//  AuthPresenter.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 11.06.2024.
//

import Foundation

class AuthPresenter {
    private weak var ui: IAuthViewController?
    private let dataRepository: IAuthDataRepository
    
    init(dataRepository: IAuthDataRepository) {
        self.dataRepository = dataRepository
    }
}

extension AuthPresenter: IAuthPresenter {
    
    func viewLoaded(ui: IAuthViewController) {
        self.ui = ui
        if dataRepository.checkSignIn() {
            ui.successAuth()
        }
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
        
        dataRepository.signIn(token: text) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.ui?.successAuth()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.ui?.setupErrorTextField()
                }
            }
        }
    }
    
    func favoriteButtonClicked() {
        ui?.toFavorite()
    }
    
    func hideKeyboard() {
        ui?.hideKeyboard()
    }
}
