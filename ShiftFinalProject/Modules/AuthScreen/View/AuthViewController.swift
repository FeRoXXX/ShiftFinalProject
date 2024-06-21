//
//  AuthViewController.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 11.06.2024.
//

import UIKit

final class AuthViewController: UIViewController {
    
    private lazy var componentView = AuthView(delegate: self)
    private let router: IAuthRouter?
    private let presenter: IAuthPresenter
    
    init(presenter: IAuthPresenter, router: AuthRouter) {
        self.presenter = presenter
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Errors.Init.initError.rawValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupHideKeyboardGesture()
        setupButtonAction()
        router?.setupUI(self)
        presenter.viewLoaded(ui: self)
    }
}

private extension AuthViewController {
    
    func setupUI() {
        view = componentView
    }
    
    func setupHideKeyboardGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(userTappedToEmptyView))
        view.addGestureRecognizer(gesture)
    }
    
    func setupButtonAction() {
        componentView.buttonDidTapped = { [weak self] in
            guard let self else { return }
            presenter.signInButtonClicked(text: componentView.accessTokenTextField.text)
        }
        
        componentView.routeToFavorite = { [weak self] in
            guard let self else { return }
            presenter.favoriteButtonClicked()
        }
    }
    
    @objc func userTappedToEmptyView() {
        presenter.hideKeyboard()
    }
}

extension AuthViewController: IAuthViewController {
    
    func setupSelectedTextField() {
        componentView.textFieldIsSelected()
    }
    
    func setupNoSelectedTextField() {
        componentView.textFieldNoSelected()
    }
    
    func setupErrorTextField() {
        componentView.setupError()
    }
    
    func successAuth() {
        router?.routeToRepositoriesList()
    }
    
    func toFavorite() {
        router?.routeToRepositoriesListFavorite()
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
}

extension AuthViewController: IAuthViewTextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        presenter.textFieldSelected()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter.textFieldNoSelected(text: textField.text)
    }
}
