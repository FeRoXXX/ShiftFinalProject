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
    let forks: Int
    let stargazers: Int
    let watchers: Int
    let default_branch: String
    let license: License?
    let description: String?
    let language: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case forks = "forks_count"
        case stargazers = "stargazers_count"
        case watchers = "watchers_count"
        case default_branch
        case license
        case language
        case description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        url = try container.decode(String.self, forKey: .url)
        forks = try container.decode(Int.self, forKey: .forks)
        stargazers = try container.decode(Int.self, forKey: .stargazers)
        watchers = try container.decode(Int.self, forKey: .watchers)
        default_branch = try container.decode(String.self, forKey: .default_branch)
        license = try container.decodeIfPresent(License.self, forKey: .license)
        language = try container.decodeIfPresent(String.self, forKey: .language)
        description = try container.decodeIfPresent(String.self, forKey: .description)
    }
}

struct License: Decodable {
    let spdx_id: String?
}
