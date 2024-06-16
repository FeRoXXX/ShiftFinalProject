//
//  RepositoryDetailDataRepository.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 16.06.2024.
//

import Foundation

final class RepositoryDetailDataRepository {}

extension RepositoryDetailDataRepository: IRepositoryDetailDataRepository {
    
    func getDetail(chosenRepository: ChoseRepositoryModel, completion: @escaping (Result<GeneralModel, Error>) -> Void) {
        NetworkService.getRepository(chosenRepository: chosenRepository).fetch { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
