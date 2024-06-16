//
//  IRepositoryDetailDataRepository.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 16.06.2024.
//

import Foundation

protocol IRepositoryDetailDataRepository {
    func getDetail(chosenRepository: ChoseRepositoryModel, completion: @escaping(Result<GeneralModel, Error>) -> Void)
}
