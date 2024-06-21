//
//  IAuthDataRepository.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 13.06.2024.
//

import Foundation

protocol IAuthDataRepository {
    func signIn(token: String, completion: @escaping(Result<AuthDataModel, Error>) -> Void)
    func checkSignIn() -> Bool
}
