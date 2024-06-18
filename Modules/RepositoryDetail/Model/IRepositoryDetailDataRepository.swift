//
//  IRepositoryDetailDataRepository.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 16.06.2024.
//

import Foundation

protocol IRepositoryDetailDataRepository {
    func getDetail(completion: @escaping(Result<RepositoryDetailModel, Error>) -> Void)
    func getReadme(completion: @escaping (Result<Data, Error>) -> Void)
    func setupSettings(_ settings: ChoseRepositoryModel)
    func logOut()
}
