//
//  RepositoryDetailView.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 16.06.2024.
//

import UIKit
import MarkdownView

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
    
    private let readMeView: MarkdownView = {
        let webView = MarkdownView()
        webView.isOpaque = false
        webView.backgroundColor = Colors.clearColor
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private var alertView: AlertView = {
        let alertView = AlertView()
        alertView.isHidden = true
        alertView.translatesAutoresizingMaskIntoConstraints = false
        return alertView
    }()
    
    private var readMeAlertView: AlertView = {
        let alertView = AlertView()
        alertView.isHidden = true
        alertView.translatesAutoresizingMaskIntoConstraints = false
        return alertView
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
        addSubview(readMeView)
        addSubview(alertView)
        addSubview(readMeAlertView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            firstInfoStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            firstInfoStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 17),
            firstInfoStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            navigationBarSeparator.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            navigationBarSeparator.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            navigationBarSeparator.centerXAnchor.constraint(equalTo: centerXAnchor),
            navigationBarSeparator.heightAnchor.constraint(equalToConstant: 1),
            alertView.topAnchor.constraint(equalTo: navigationBarSeparator.bottomAnchor),
            alertView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            alertView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            alertView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            readMeView.topAnchor.constraint(equalTo: firstInfoStack.bottomAnchor, constant: 24),
            readMeView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            readMeView.centerXAnchor.constraint(equalTo: centerXAnchor),
            readMeView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            readMeAlertView.topAnchor.constraint(equalTo: firstInfoStack.bottomAnchor, constant: 24),
            readMeAlertView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            readMeAlertView.centerXAnchor.constraint(equalTo: centerXAnchor),
            readMeAlertView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension RepositoryDetailView {
    
    func setupFirstInfo(_ firstInfo: RepositoryDetailFirstInformation) {
        repositoryURLLabel.urlLabel.text = firstInfo.repositoryURL
        licenseLabel.licenseNameLabel.text = firstInfo.repositoryLicense
        starLabel.statCountLabel.text = firstInfo.repositoryStars
        forkLabel.statCountLabel.text = firstInfo.repositoryForks
        watchersLabel.statCountLabel.text = firstInfo.repositoryWatchers
    }
    
    func setupReadme(_ data: String) {
        let css = ["body { color:white; }"].joined(separator: "\n")
        readMeView.load(markdown: data, css: css)
    }
    
    func setupAlert(_ error: Errors.Alerts) {
        firstInfoStack.isHidden = true
        readMeView.isHidden = true
        alertView.isHidden = false
        alertView.setupElements(error)
    }
    
    func setupReadMeAlert(_ error: Errors.Alerts) {
        readMeView.isHidden = true
        readMeAlertView.isHidden = false
        readMeAlertView.setupElements(error)
    }
    
    func hideAlert() {
        firstInfoStack.isHidden = false
        readMeView.isHidden = false
        alertView.isHidden = true
        readMeAlertView.isHidden = true
    }
}
