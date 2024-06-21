//
//  IRepositoryDetailPresenter.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 16.06.2024.
//

import Foundation

protocol IRepositoryDetailPresenter {
    func viewLoaded(ui: IRepositoryDetailViewController)
    func logOut()
    func favoriteButtonTapped()
    func refreshReadMeRequest()
    func retryDataRequest()
}
