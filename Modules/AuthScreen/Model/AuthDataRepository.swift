//
//  AuthDataRepository.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 13.06.2024.
//

import Foundation

class AuthDataRepository {
    
}

extension AuthDataRepository: IAuthDataRepository {
    
    func signIn(token: String, completion: @escaping (Result<AuthDataModel, any Error>) -> Void) {
        NetworkService.signIn(token: token).fetch { result in
            switch result {
            case .success(let success):
                do {
                    let convertedData = try JSONDecoder().decode(AuthDataModel.self, from: success)
                    completion(.success(convertedData))
                } catch {
                    completion(.failure(error)) //TODO: - Make failure alert
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
