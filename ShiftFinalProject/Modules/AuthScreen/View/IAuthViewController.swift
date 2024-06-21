//
//  IAuthViewController.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 11.06.2024.
//

import Foundation

protocol IAuthViewController: AnyObject {
    func setupSelectedTextField()
    func setupNoSelectedTextField()
    func setupErrorTextField()
    func hideKeyboard()
    func toFavorite()
    func successAuth()
}
