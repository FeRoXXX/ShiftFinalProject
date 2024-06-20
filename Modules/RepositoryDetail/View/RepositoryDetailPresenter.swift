//
//  RepositoryDetailPresenter.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 16.06.2024.
//

import Foundation

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
        
        NetworkReachabilityService.shared.checkInternetConnection { [weak self] in
            self?.dataRepository.getDetail { result in
                switch result {
                case .success(let success):
                    self?.repositoryFirstInfoDataModel = success
                    DispatchQueue.main.async {
                        ui.setFirstInfo(RepositoryDetailFirstInformation(repositoryURL: success.url,
                                                                         repositoryLicense: success.license?.spdx_id,
                                                                         repositoryStars: String(success.stargazers),
                                                                         repositoryForks: String(success.forks),
                                                                         repositoryWatchers: String(success.watchers)))
                        self?.fetchReadMe()
                    }
                case .failure(_):
                    ui.setupError(.somethingError)
                }
            }
        } failure: {
            ui.setupError(.connectionError)
        }
    }
    
    func logOut() {
        dataRepository.logOut()
        ui?.logOut()
    }
}

private extension RepositoryDetailPresenter {
    
    func fetchReadMe() {
        NetworkReachabilityService.shared.checkInternetConnection { [weak self] in
            self?.dataRepository.getReadme { result in
                switch result {
                case .success(let data):
                    guard let decodedData = Data(base64Encoded: data.content, options: .ignoreUnknownCharacters),
                          let stringData = String(data: decodedData, encoding: .utf8) else { return }
                    DispatchQueue.main.async {
                        self?.ui?.setupReadme(stringData)
                    }
                case .failure(_):
                    self?.ui?.setupReadMeError(.loadError)
                }
            }
        } failure: {
            self.ui?.setupReadMeError(.connectionError)
        }
    }
}
