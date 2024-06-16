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
    var dataStore: ChoseRepositoryModel?
    
    init(dataRepository: IRepositoryDetailDataRepository) {
        self.dataRepository = dataRepository
    }
}

extension RepositoryDetailPresenter: IRepositoryDetailPresenter {
    
    func viewLoaded(ui: IRepositoryDetailViewController) {
        self.ui = ui
        guard let dataStore else { return }
        dataRepository.getDetail(chosenRepository: dataStore) { result in
            print(result)
        }
    }
}
