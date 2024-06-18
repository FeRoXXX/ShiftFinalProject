//
//  GeneralModel.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 15.06.2024.
//

import Foundation

enum GeneralModel {
    case authModel(_ model: AuthDataModel)
    case repositoriesListModel(_ model: [RepositoriesListModel])
    case repositoryDetailModel(_ model: RepositoryDetailModel)
    case repositoryReadme(_ data: Data)
}
