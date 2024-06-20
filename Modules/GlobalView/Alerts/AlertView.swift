//
//  AlertView.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 20.06.2024.
//

import UIKit

final class AlertView: UIView {
    
    private var alertImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var alertText: UILabel = {
        let label = UILabel()
        label.font = Fonts.highFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var alertDescriptionText: UILabel = {
        let label = UILabel()
        label.font = Fonts.middleFont
        label.textColor = Colors.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var retryButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(Colors.textColor, for: .normal)
        button.backgroundColor = Colors.buttonColor
        button.layer.cornerRadius = UIElementSetting.cornerRadius
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AlertView {
    
    func setupUI() {
        backgroundColor = Colors.backgroundColor
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(alertImageView)
        addSubview(alertText)
        addSubview(alertDescriptionText)
        addSubview(retryButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            alertImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -96),
            alertImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            alertText.topAnchor.constraint(equalTo: alertImageView.bottomAnchor, constant: 24),
            alertText.centerXAnchor.constraint(equalTo: centerXAnchor),
            alertDescriptionText.topAnchor.constraint(equalTo: alertText.bottomAnchor),
            alertDescriptionText.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            retryButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

extension AlertView {
    
    func setupElements(_ error: Errors.Alerts) {
        alertImageView.image = UIImage(named: ImageNames.AlertsImage.getImageName(by: error))
        alertText.textColor = Colors.AlertsColor.getAlertsColor(by: error)
        alertText.text = error.rawValue
        alertDescriptionText.text = Errors.Alerts.getDescription(by: error)
        retryButton.setTitle(MockText.AlertButtonText.getText(by: error), for: .normal)
    }
}
