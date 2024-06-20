//
//  AuthView.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 11.06.2024.
//

import UIKit

final class AuthView: UIView {
    
    var buttonDidTapped: (() -> Void)?
    
    private let appIcon: UIImageView = {
        let image = UIImageView(image: UIImage(named: ImageNames.AppLogo.rawValue))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let accessTokenTextField: UITextField = {
        let textField = UITextField()
        textField.font = Fonts.highFont
        textField.textColor = Colors.textColor
        textField.attributedPlaceholder = NSAttributedString(string: MockText.AuthViewText.placeholderText,
                                                             attributes: Fonts.textFieldsPlaceholderFont)
        textField.layer.borderColor = Colors.placeholderAndNoSelectedColor.cgColor
        textField.layer.cornerRadius = UIElementSetting.cornerRadius
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = UIElementSetting.borderWidth
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let errorAlertLabel: UILabel = {
        let label = UILabel()
        label.text = MockText.AuthViewText.errorText
        label.textColor = Colors.errorColor
        label.font = Fonts.smallFont
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle(MockText.AuthViewText.buttonText, for: .normal)
        button.layer.cornerRadius = UIElementSetting.cornerRadius
        button.layer.masksToBounds = true
        button.layer.borderWidth = UIElementSetting.borderWidth
        button.backgroundColor = Colors.buttonColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: ImageNames.star.rawValue), for: .normal)
        return button
    }()
    
    init(delegate: IAuthViewTextFieldDelegate) {
        accessTokenTextField.delegate = delegate
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AuthView {
    
    func setupUI() {
        backgroundColor = Colors.backgroundColor
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(appIcon)
        addSubview(accessTokenTextField)
        addSubview(signInButton)
        addSubview(errorAlertLabel)
        addSubview(favoriteButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            appIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            appIcon.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 56),
            appIcon.heightAnchor.constraint(equalTo: appIcon.widthAnchor, multiplier: 1),
            accessTokenTextField.topAnchor.constraint(equalTo: appIcon.bottomAnchor, constant: 56),
            accessTokenTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            accessTokenTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            accessTokenTextField.heightAnchor.constraint(equalToConstant: 48),
            errorAlertLabel.topAnchor.constraint(equalTo: accessTokenTextField.bottomAnchor, constant: 6),
            errorAlertLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            signInButton.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor, constant: -16),
            signInButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signInButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            signInButton.heightAnchor.constraint(equalToConstant: 48),
            favoriteButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            favoriteButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension AuthView {
    
    func textFieldIsSelected() {
        accessTokenTextField.layer.borderColor = Colors.textFieldBorderSelected.cgColor
        errorAlertLabel.isHidden = true
    }
    
    func textFieldNoSelected() {
        accessTokenTextField.layer.borderColor = Colors.placeholderAndNoSelectedColor.cgColor
    }
    
    func setupError() {
        errorAlertLabel.isHidden = false
        accessTokenTextField.layer.borderColor = Colors.errorColor.cgColor
    }
    
    @objc func buttonTap() {
        buttonDidTapped?()
    }
}
