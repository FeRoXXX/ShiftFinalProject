//
//  RepositoriesListPresenter.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 12.06.2024.
//

import Foundation

final class RepositoriesListPresenter {
    private weak var ui: IRepositoriesListViewController?
    private let dataSource: IRepositoriesListTableViewDataSource
    private let dataRepository: IRepositoriesListDataRepository
    
    init(dataSource: IRepositoriesListTableViewDataSource, dataRepository: IRepositoriesListDataRepository) {
        self.dataSource = dataSource
        self.dataRepository = dataRepository
    }
}

extension RepositoriesListPresenter: IRepositoriesListPresenter {
    
    func viewLoaded(ui: IRepositoriesListViewController) {
        self.ui = ui
        
        ui.setupDataSource(dataSource)
        dataRepository.getRepositories { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async { [weak self] in
                    self?.dataSource.setupData(success)
                    self?.ui?.updateData()
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    print(failure)
                }
            }
        }
    }
}
