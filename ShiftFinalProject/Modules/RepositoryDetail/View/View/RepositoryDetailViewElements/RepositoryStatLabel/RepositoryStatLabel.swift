//
//  RepositoryStatLabel.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 17.06.2024.
//

import UIKit

final class RepositoryStatLabel: UIView {
    
    private let statName: RepositoryStatName
    
    private lazy var horizontalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [statImageView, statCountLabel, statLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var statImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: ImageNames.RepositoryStat.getImageName(by: statName)))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var statLabel: UILabel = {
        let label = UILabel()
        label.text = MockText.RepositoryDetailText.RepositoryStatText.getStatText(by: statName)
        label.font = Fonts.highFont
        label.textColor = Colors.textColor
        return label
    }()
    
    lazy var statCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.StatColors.getStatColor(by: statName)
        label.font = Fonts.highFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(statName: RepositoryStatName) {
        self.statName = statName
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Errors.Init.initError.rawValue)
    }
}

private extension RepositoryStatLabel {
    
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
