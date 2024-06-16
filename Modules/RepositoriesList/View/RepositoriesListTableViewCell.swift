//
//  RepositoriesListTableViewCell.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 12.06.2024.
//

import UIKit

final class RepositoriesListTableViewCell: UITableViewCell {
    
    private lazy var horizontalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [repositoryName, repositoryLanguage])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let repositoryName: UILabel = {
        let label = UILabel()
        label.textColor = Colors.repositoryNameLabel
        label.font = Fonts.textFieldsFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let repositoryLanguage: UILabel = {
        let label = UILabel()
        label.textColor = Colors.textColor
        label.font = Fonts.errorAlertFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [horizontalStack, repositoryDescription])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let repositoryDescription: UILabel = {
        let label = UILabel()
        label.textColor = Colors.textColor
        label.font = Fonts.repositoryDescriptionFont
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension RepositoriesListTableViewCell {
    
    func setupUI() {
        backgroundColor = Colors.cellBackground
        selectionStyle = .none
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(verticalStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 14),
            verticalStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            verticalStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            verticalStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -14)
        ])
    }
}

extension RepositoriesListTableViewCell {
    
    func setupData(_ data: RepositoryDescriptionModel) {
        repositoryName.text = data.name
        repositoryLanguage.text = data.language
        if let language = data.language {
            repositoryLanguage.textColor = LanguageColors(rawValue: language)?.color ?? .white
        }
        repositoryDescription.text = data.description
    }
    
    static var identifier: String{
        String(describing: RepositoriesListTableViewCell.self)
    }
}
