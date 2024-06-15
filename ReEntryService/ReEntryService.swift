//
//  ReEntryService.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 15.06.2024.
//

import Foundation

final class ReEntryService {
    
    private var authToken: String? {
        get {
            UserDefaults.standard.string(forKey: "AuthToken")
        }
    }
    
    private var reposURL: String? {
        get {
            UserDefaults.standard.string(forKey: "ReposURL")
        }
    }
}

extension ReEntryService: IReEntryService {
    
    func getAuthToken() -> String? {
        authToken
    }
    
    func setAuthToken(token: String) {
        UserDefaults.standard.setValue(token, forKey: "AuthToken")
    }
    
    func getReposURL() -> String? {
        reposURL
    }
    
    func setReposURL(reposURL: String) {
        UserDefaults.standard.setValue(reposURL, forKey: "ReposURL")
    }
    
    func removeData() {
        UserDefaults.standard.removeObject(forKey: "AuthToken")
        UserDefaults.standard.removeObject(forKey: "ReposURL")
    }
}
