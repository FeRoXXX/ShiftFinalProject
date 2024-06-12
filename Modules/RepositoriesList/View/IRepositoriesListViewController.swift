//
//  IRepositoriesListViewController.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 12.06.2024.
//

import Foundation

protocol IRepositoriesListViewController: AnyObject {
    func setupDataSource(_ dataSource: IRepositoriesListTableViewDataSource)
    func updateData()
}
