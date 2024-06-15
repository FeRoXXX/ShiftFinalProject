//
//  RepositoriesListTableViewDataSource.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 12.06.2024.
//

import UIKit

protocol IRepositoriesListTableViewDataSource: UITableViewDataSource {
    func setupData(_ data: [RepositoriesListModel])
}

final class RepositoriesListTableViewDataSource: NSObject {
    var data: [RepositoriesListModel] = []
    
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
}

extension RepositoriesListTableViewDataSource: IRepositoriesListTableViewDataSource {
    
    func setupData(_ data: [RepositoriesListModel]) {
        self.data = data
    }
}
