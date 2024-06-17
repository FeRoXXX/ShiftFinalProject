//
//  LicenseLabel.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 17.06.2024.
//

import UIKit

final class LicenseLabel: UIView {
    private lazy var horizontalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mockHorizontalStack, licenseNameLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var mockHorizontalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [licenseImageView, licenseLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let licenseImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: ImageNames.License.rawValue))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let licenseLabel: UILabel = {
        let label = UILabel()
        label.text = MockText.RepositoryDetailText.licenseText
        label.font = Fonts.highFont
        label.textColor = Colors.textColor
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let licenseNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Apache-2.0"
        label.font = Fonts.highFont
        label.textColor = Colors.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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

private extension LicenseLabel {
    
    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(horizontalStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: topAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
