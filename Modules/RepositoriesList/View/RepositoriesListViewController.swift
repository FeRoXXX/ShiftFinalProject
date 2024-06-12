//
//  RepositoriesListViewController.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 12.06.2024.
//

import UIKit

final class RepositoriesListViewController: UIViewController {
    private lazy var componentView = RepositoriesListView(delegate: self)
    private let presenter: IRepositoriesListPresenter
    
    init(presenter: IRepositoriesListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewLoaded(ui: self)
    }
}

private extension RepositoriesListViewController {
    
    func setupUI() {
        view = componentView
    }
}

extension RepositoriesListViewController: IRepositoriesListViewController {
    
    func setupDataSource(_ dataSource: IRepositoriesListTableViewDataSource) {
        componentView.setupDataSource(dataSource)
    }
    
    func updateData() {
        componentView.updateTable()
    }
}

extension RepositoriesListViewController: RepositoriesListTableViewDelegate {}
