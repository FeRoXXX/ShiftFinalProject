//
//  RepositoriesListPresenter.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 12.06.2024.
//

import Foundation
import Reachability

final class RepositoriesListPresenter: RepositoryListDataStore {
    private weak var ui: IRepositoriesListViewController?
    private let dataSource: IRepositoriesListTableViewDataSource
    private let dataRepository: IRepositoriesListDataRepository
    private var storageData: [RepositoryDescriptionModel] = []
    var chosenRepository: ChoseRepositoryModel?
    
    init(dataSource: IRepositoriesListTableViewDataSource, dataRepository: IRepositoriesListDataRepository) {
        self.dataSource = dataSource
        self.dataRepository = dataRepository
    }
}

extension RepositoriesListPresenter: IRepositoriesListPresenter {
    
    func viewLoaded(ui: IRepositoriesListViewController) {
        self.ui = ui
        ui.setupDataSource(dataSource)
        
        NetworkReachabilityService.shared.checkInternetConnection { [weak self] in
            self?.dataRepository.getRepositories { result in
                switch result {
                case .success(let success):
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        storageData = success.map {
                            RepositoryDescriptionModel(name: $0.name, language: $0.language, description: $0.description)
                        }
                        if storageData.isEmpty {
                            ui.setupError(.emptyError)
                        } else {
                            dataSource.setupData(storageData)
                            ui.updateData()
                        }
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        ui.setupError(.somethingError)
                    }
                }
            }
        } failure: {
            ui.setupError(.connectionError)
        }
    }
    
    func showRepository(index: Int) {
        let data = dataRepository.getRepositories()
        guard index < data.count else { return }
        let detailData = data[index]
        chosenRepository = ChoseRepositoryModel(repositoryName: detailData.name, ownerName: detailData.owner.login)
        ui?.loadNextViewController()
    }
    
    func logOut() {
        dataRepository.logOut()
        ui?.logOut()
    }
}
