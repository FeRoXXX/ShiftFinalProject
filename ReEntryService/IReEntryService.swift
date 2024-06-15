//
//  IReEntryService.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 15.06.2024.
//

import Foundation

protocol IReEntryService {
    func getAuthToken() -> String?
    func setAuthToken(token: String)
    func getReposURL() -> String?
    func setReposURL(reposURL: String)
    func removeData()
}
