//
//  IRepositoryDetailViewController.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 16.06.2024.
//

import Foundation

protocol IRepositoryDetailViewController: AnyObject {
    func setTitle(_ title: String)
    func setFirstInfo(_ firstInfo: RepositoryDetailFirstInformation)
    func setupReadme(_ data: String)
    func logOut()
}
