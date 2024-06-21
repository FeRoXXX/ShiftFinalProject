//
//  IRepositoryDetailDataRepository.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 16.06.2024.
//

import Foundation

protocol IRepositoryDetailDataRepository {
    func getDetail(completion: @escaping(Result<RepositoryDetailModel, Error>) -> Void)
    func getReadme(completion: @escaping (Result<ReadmeDataModel, Error>) -> Void)
    func setupSettings(_ settings: ChoseRepositoryModel)
    func logOut()
    func isFavorite(by id: String) -> Bool
    func saveFavorite(_ data: RepositoriesListModel)
    func deleteFavorite(_ id: String)
}
