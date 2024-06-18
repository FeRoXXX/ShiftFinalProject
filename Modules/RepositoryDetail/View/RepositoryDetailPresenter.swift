//
//  RepositoryDetailPresenter.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 16.06.2024.
//

import Foundation
import Ink

final class RepositoryDetailPresenter: RepositoryDetailDataStore {
    
    private weak var ui: IRepositoryDetailViewController?
    private let dataRepository: IRepositoryDetailDataRepository
    private var repositoryFirstInfoDataModel: RepositoryDetailModel?
    var dataStore: ChoseRepositoryModel?
    
    init(dataRepository: IRepositoryDetailDataRepository) {
        self.dataRepository = dataRepository
    }
}

extension RepositoryDetailPresenter: IRepositoryDetailPresenter {
    
    func viewLoaded(ui: IRepositoryDetailViewController) {
        self.ui = ui
        guard let dataStore else { return }
        ui.setTitle(dataStore.repositoryName)
        dataRepository.setupSettings(dataStore)
        dataRepository.getDetail { result in
            switch result {
            case .success(let success):
                self.repositoryFirstInfoDataModel = success
                DispatchQueue.main.async {
                    ui.setFirstInfo(RepositoryDetailFirstInformation(repositoryURL: success.url,
                                                                     repositoryLicense: success.license.spdx_id,
                                                                     repositoryStars: String(success.stargazers_count),
                                                                     repositoryForks: String(success.forks_count),
                                                                     repositoryWatchers: String(success.watchers_count)))
                    self.dataRepository.getReadme { result in
                        switch result {
                        case .success(let data):
                            guard let dataString = String(data: data, encoding: .utf8) else { return }
                            DispatchQueue.main.async {
                                ui.setupReadme(dataString)
                            }
                        case .failure(let failure):
                            break //TODO: Make alerts
                        }
                    }
                }
            case .failure(let failure):
                break //TODO: Make alerts
            }
        }
    }
    
    func logOut() {
        dataRepository.logOut()
        ui?.logOut()
    }
}
