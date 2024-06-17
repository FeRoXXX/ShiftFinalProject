//
//  RepositoryDetailView.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 16.06.2024.
//

import UIKit

final class RepositoryDetailView: UIView {
    
    private let navigationBarSeparator: UIView = {
        let separatorLine = UIView()
        separatorLine.backgroundColor = Colors.separatorColor
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        return separatorLine
    }()
    
    private lazy var firstInfoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [repositoryURLLabel, licenseLabel, repositoryStatsStack])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var repositoryStatsStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [starLabel, forkLabel, watchersLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var repositoryURLLabel: RepositoryURLLabel = RepositoryURLLabel()
    private var licenseLabel: LicenseLabel = LicenseLabel()
    private var starLabel: RepositoryStatLabel = RepositoryStatLabel(statName: .stars)
    private var forkLabel: RepositoryStatLabel = RepositoryStatLabel(statName: .forks)
    private var watchersLabel: RepositoryStatLabel = RepositoryStatLabel(statName: .watchers)
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension RepositoryDetailView {
    
    func setupUI() {
        backgroundColor = Colors.backgroundColor
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(firstInfoStack)
        addSubview(navigationBarSeparator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            firstInfoStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            firstInfoStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 17),
            firstInfoStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            navigationBarSeparator.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            navigationBarSeparator.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            navigationBarSeparator.centerXAnchor.constraint(equalTo: centerXAnchor),
            navigationBarSeparator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
