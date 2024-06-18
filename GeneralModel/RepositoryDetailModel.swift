//
//  RepositoryDetailModel.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 17.06.2024.
//

import Foundation

struct RepositoryDetailModel: Decodable {
    let id: Int
    let name: String
    let url: String
    let forks_count: Int
    let stargazers_count: Int
    let watchers_count: Int
    let default_branch: String
    let license: License
}

struct License: Decodable {
    let spdx_id: String
}
