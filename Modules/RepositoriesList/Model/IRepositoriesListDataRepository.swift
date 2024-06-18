//
//  IRepositoriesListDataRepository.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 15.06.2024.
//

import Foundation

protocol IRepositoriesListDataRepository {
    func getRepositories(completion: @escaping(Result<[RepositoriesListModel], Error>) -> Void)
    func getRepositories() -> [RepositoriesListModel]
    func logOut()
}
