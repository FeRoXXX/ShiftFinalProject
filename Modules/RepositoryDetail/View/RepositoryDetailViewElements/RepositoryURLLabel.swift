//
//  RepositoryURLLabel.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 17.06.2024.
//

import UIKit

final class RepositoryURLLabel: UIView {
    
    lazy var urlStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [urlImageView, urlLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let urlImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: ImageNames.URLImage.rawValue))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let urlLabel: UILabel = {
        let label = UILabel()
        label.text = "github.com/icerockdev/moko-resources"
        label.font = Fonts.highFont
        label.textColor = Colors.urlFontColor
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
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

private extension RepositoryURLLabel {
    
    func setupUI() {
        backgroundColor = Colors.clearColor
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(urlStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            urlStack.topAnchor.constraint(equalTo: topAnchor),
            urlStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            urlStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            urlStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
