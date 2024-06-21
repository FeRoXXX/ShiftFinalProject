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
        getFirstData()
    }
    
    func logOut() {
        dataRepository.logOut()
        ui?.logOut()
    }
    
    func favoriteButtonTapped() {
        guard let repositoryFirstInfoDataModel else { return }
        if dataRepository.isFavorite(by: String(repositoryFirstInfoDataModel.id)) {
            dataRepository.deleteFavorite(String(repositoryFirstInfoDataModel.id))
            ui?.setupUnFavorite()
        } else {
            dataRepository.saveFavorite(RepositoriesListModel(id: repositoryFirstInfoDataModel.id,
                                                              name: repositoryFirstInfoDataModel.name,
                                                              description: repositoryFirstInfoDataModel.description,
                                                              language: repositoryFirstInfoDataModel.language,
                                                              owner: Owner(login: dataStore!.ownerName)))
            ui?.setupFavorite()
        }
    }
    
    func refreshReadMeRequest() {
        getReadMeData()
    }
    
    func retryDataRequest() {
        getFirstData()
    }
}

private extension RepositoryDetailPresenter {
    
    func fetchReadMe() {
        self.dataRepository.getReadme { result in
            switch result {
            case .success(let data):
                guard let decodedData = Data(base64Encoded: data.content, options: .ignoreUnknownCharacters),
                        let stringData = String(data: decodedData, encoding: .utf8) else { return }
                DispatchQueue.main.async {
                    self.ui?.setupReadme(stringData)
                    self.ui?.hideAlert()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.ui?.setupReadMeError(.emptyReadme)
                }
            }
        }
    }
    
    func fetchFirstData() {
        dataRepository.getDetail { result in
            switch result {
            case .success(let success):
                self.repositoryFirstInfoDataModel = success
                DispatchQueue.main.async {
                    self.ui?.setFirstInfo(RepositoryDetailFirstInformation(repositoryURL: success.url,
                                                                     repositoryLicense: success.license?.spdx_id,
                                                                     repositoryStars: String(success.stargazers),
                                                                     repositoryForks: String(success.forks),
                                                                     repositoryWatchers: String(success.watchers)))
                    self.ui?.hideAlert()
                    self.getReadMeData()
                    if self.dataRepository.isFavorite(by: String(success.id)) {
                        self.ui?.setupFavorite()
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.ui?.setupError(.somethingError)
                }
            }
        }
    }
    
    func getFirstData() {
        NetworkReachabilityService.shared.checkInternetConnection { [weak self] in
            self?.fetchFirstData()
        } failure: {
            DispatchQueue.main.async {
                self.ui?.setupError(.connectionError)
            }
        }
    }
    
    func getReadMeData() {
        NetworkReachabilityService.shared.checkInternetConnection { [weak self] in
            self?.fetchReadMe()
        } failure: {
            DispatchQueue.main.async {
                self.ui?.setupError(.connectionError)
            }
        }
    }
}
