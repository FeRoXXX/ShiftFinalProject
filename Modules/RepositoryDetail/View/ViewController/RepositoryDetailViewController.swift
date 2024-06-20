//
//  RepositoryDetailViewController.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 16.06.2024.
//

import UIKit

final class RepositoryDetailViewController: UIViewController {
    
    private lazy var componentView = RepositoryDetailView()
    private let presenter: IRepositoryDetailPresenter
    private let router: IRepositoryDetailRouter
    
    init(presenter: IRepositoryDetailPresenter, router: IRepositoryDetailRouter) {
        self.presenter = presenter
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        router.setupRouter(self)
        presenter.viewLoaded(ui: self)
    }
}

private extension RepositoryDetailViewController {
    
    func setupUI() {
        view = componentView
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let button = UIBarButtonItem(image: UIImage(named: ImageNames.Quit.rawValue), style: .done, target: self, action: #selector(quitButtonTapped))
        navigationItem.rightBarButtonItems = [button]
        navigationItem.rightBarButtonItem?.tintColor = Colors.navigationBarItemsColor
    }
    
    @objc func quitButtonTapped() {
        presenter.logOut()
    }
}

extension RepositoryDetailViewController: IRepositoryDetailViewController {
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setFirstInfo(_ firstInfo: RepositoryDetailFirstInformation) {
        componentView.setupFirstInfo(firstInfo)
    }
    
    func setupReadme(_ data: String) {
        componentView.setupReadme(data)
    }
    
    func logOut() {
        router.routToFirstViewController()
    }
    
    func setupError(_ error: Errors.Alerts) {
        componentView.setupAlert(error)
    }
    
    func setupReadMeError(_ error: Errors.Alerts) {
        componentView.setupReadMeAlert(error)
    }
}
