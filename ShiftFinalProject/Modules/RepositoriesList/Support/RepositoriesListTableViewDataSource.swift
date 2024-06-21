//
//  RepositoriesListTableViewDataSource.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 12.06.2024.
//

import UIKit

protocol IRepositoriesListTableViewDataSource: UITableViewDataSource {
    func setupData(_ data: [RepositoryDescriptionModel])
    var deleteTarget: ((Int) -> Void)? { get set }
}

final class RepositoriesListTableViewDataSource: NSObject {
    private var data: [RepositoryDescriptionModel] = []
    private var identifier: DataRepositoryIdentifier
    var deleteTarget: ((Int) -> Void)?
    
    init(identifier: DataRepositoryIdentifier) {
        self.identifier = identifier
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoriesListTableViewCell.identifier, for: indexPath) as? RepositoriesListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setupData(data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch identifier {
        case .getFromInternet:
            false
        case .getFromLocal:
            true
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTarget?(indexPath.row)
        }
    }
}

extension RepositoriesListTableViewDataSource: IRepositoriesListTableViewDataSource {
    
    func setupData(_ data: [RepositoryDescriptionModel]) {
        self.data = data
    }
}
