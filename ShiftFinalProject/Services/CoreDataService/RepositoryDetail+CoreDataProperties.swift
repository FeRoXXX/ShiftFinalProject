//
//  RepositoryDetail+CoreDataProperties.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 20.06.2024.
//
//

import Foundation
import CoreData


extension RepositoryDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RepositoryDetail> {
        return NSFetchRequest<RepositoryDetail>(entityName: "RepositoryDetail")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var repositoryDescription: String?
    @NSManaged public var language: String?
    @NSManaged public var ownerName: String

}

extension RepositoryDetail : Identifiable {

}
