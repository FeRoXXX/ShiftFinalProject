//
//  RepositoriesListView.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 12.06.2024.
//

import UIKit

final class RepositoriesListView: UIView {
    
    private let navigationBarSeparator: UIView = {
        let separatorLine = UIView()
        separatorLine.backgroundColor = Colors.separatorColor
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        return separatorLine
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Colors.cellBackground
        tableView.separatorColor = Colors.separatorColor
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = .zero
        tableView.register(RepositoriesListTableViewCell.self, forCellReuseIdentifier: RepositoriesListTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var alertView: AlertView = {
        let alertView = AlertView()
        alertView.isHidden = true
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.buttonTarget = { [weak self] in
            self?.setupRetryButtonTarget()
        }
        return alertView
    }()
    
    var buttonTarget: (() -> Void)?
    
    init(delegate: RepositoriesListTableViewDelegate) {
        tableView.delegate = delegate
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension RepositoriesListView {
    
    func setupUI() {
        backgroundColor = Colors.backgroundColor
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(tableView)
        addSubview(alertView)
        addSubview(navigationBarSeparator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            navigationBarSeparator.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            navigationBarSeparator.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            navigationBarSeparator.centerXAnchor.constraint(equalTo: centerXAnchor),
            navigationBarSeparator.heightAnchor.constraint(equalToConstant: 1),
            alertView.topAnchor.constraint(equalTo: navigationBarSeparator.bottomAnchor),
            alertView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            alertView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            alertView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupRetryButtonTarget() {
        buttonTarget?()
    }
}

extension RepositoriesListView {
    
    func setupDataSource(_ dataSource: IRepositoriesListTableViewDataSource) {
        tableView.dataSource = dataSource
    }
    
    func updateTable() {
        tableView.reloadData()
    }
    
    func setupAlert(_ error: Errors.Alerts) {
        tableView.isHidden = true
        alertView.isHidden = false
        alertView.setupElements(error)
    }
    
    func startLoading() {
        tableView.isHidden = true
        alertView.isHidden = false
        alertView.startLoading()
    }
    
    func stopLoading() {
        alertView.stopLoading()
        tableView.isHidden = true
        alertView.isHidden = false
    }
    
    func hideAlert() {
        tableView.isHidden = false
        alertView.isHidden = true
    }
}
