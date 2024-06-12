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
    
    init(dataSource: IRepositoriesListTableViewDataSource) {
        self.dataSource = dataSource
    }
}

extension RepositoriesListPresenter: IRepositoriesListPresenter {
    
    func viewLoaded(ui: IRepositoriesListViewController) {
        self.ui = ui
        
        ui.setupDataSource(dataSource)
        ui.updateData()
    }
}
