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
    private let router: IRepositoriesListRouter
    
    init(presenter: IRepositoriesListPresenter, router: IRepositoriesListRouter) {
        self.presenter = presenter
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Errors.Init.initError.rawValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        router.setupUI(self)
        presenter.viewLoaded(ui: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.requestData()
    }
}

private extension RepositoriesListViewController {
    
    func setupUI() {
        view = componentView
        setupNavigationBarItem()
        setupTitle()
        setupRetryButtonTarget()
    }
    
    func setupNavigationBarItem() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Colors.navigationBarItemsColor]
        let button = UIBarButtonItem(image: UIImage(named: ImageNames.Quit.rawValue), style: .done, target: self, action: #selector(quitButtonTapped))
        navigationItem.rightBarButtonItems = [button]
        navigationItem.rightBarButtonItem?.tintColor = Colors.navigationBarItemsColor
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    func setupRetryButtonTarget() {
        componentView.buttonTarget = { [weak self] in
            self?.presenter.requestData()
        }
    }
    
    func setupTitle() {
        title = MockText.RepositoriesListText.titleText
    }
    
    @objc func quitButtonTapped() {
        presenter.logOut()
    }
}

extension RepositoriesListViewController: IRepositoriesListViewController {
    
    func setupDataSource(_ dataSource: IRepositoriesListTableViewDataSource) {
        componentView.setupDataSource(dataSource)
    }
    
    func loadNextViewController() {
        router.routeToRepositoryDetail()
    }
    
    func updateData() {
        componentView.updateTable()
    }
    
    func logOut() {
        router.routeToFirstViewController()
    }
    
    func setupError(_ error: Errors.Alerts) {
        componentView.setupAlert(error)
    }
    
    func startLoading() {
        componentView.startLoading()
    }
    
    func stopLoading() {
        componentView.stopLoading()
    }
    
    func hideAlert() {
        componentView.hideAlert()
    }
}

extension RepositoriesListViewController: RepositoriesListTableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showRepository(index: indexPath.row)
    }
}
