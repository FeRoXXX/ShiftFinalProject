//
//  AuthDataRepository.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 13.06.2024.
//

import Foundation

class AuthDataRepository {}

extension AuthDataRepository: IAuthDataRepository {
    
    func signIn(token: String, completion: @escaping (Result<AuthDataModel, any Error>) -> Void) {
        NetworkService.signIn(token: token).fetch { result in
            switch result {
            case .success(let success):
                    switch success {
                    case .authModel(let model):
                        completion(.success(model))
                    default:
                        break
                    }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func checkSignIn() -> Bool {
        NetworkService.getRepositories.checkSignIn()
    }
}
