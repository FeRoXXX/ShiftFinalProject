//
//  IRepositoriesListPresenter.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 12.06.2024.
//

import Foundation

protocol IRepositoriesListPresenter {
    func viewLoaded(ui: IRepositoriesListViewController)
    func showRepository(index: Int)
    func logOut()
    func requestData()
}
