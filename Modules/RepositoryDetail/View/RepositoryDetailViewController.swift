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
    
    init(presenter: IRepositoryDetailPresenter) {
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

private extension RepositoryDetailViewController {
    
    func setupUI() {
        view = componentView
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let button = UIBarButtonItem(image: UIImage(named: ImageNames.Quit.rawValue), style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [button]
        navigationItem.rightBarButtonItem?.tintColor = Colors.navigationBarItemsColor
    }
}

extension RepositoryDetailViewController: IRepositoryDetailViewController {
    
    func setTitle(_ title: String) {
        self.title = title
    }
}
