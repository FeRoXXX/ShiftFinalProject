//
//  RepositoriesListModel.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 15.06.2024.
//

import Foundation

struct RepositoriesListModel: Decodable {
    let id: Int
    let name: String
    let description: String?
    let language: String?
    let owner: Owner
}

struct Owner: Decodable {
    let login: String
}
