//
//  CoreDataService.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 20.06.2024.
//

import UIKit
import CoreData

final class CoreDataService {
    static let shared = CoreDataService()
    
    private var appDelegate: AppDelegate {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        return appDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
}

extension CoreDataService {
    
    func createObject(_ data: RepositoriesListModel) {
        defer {
            appDelegate.saveContext()
        }
        
        guard let repositoryEntityDescription = NSEntityDescription.entity(forEntityName: "RepositoryDetail", in: context) else { return }
        let repository = RepositoryDetail(entity: repositoryEntityDescription, insertInto: context)
        repository.id = String(data.id)
        repository.repositoryDescription = data.description
        repository.language = data.language
        repository.name = data.name
        repository.ownerName = data.owner.login
    }
    
    func fetchRepositories(completion: ([RepositoryDetail]) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RepositoryDetail")
        do {
            let data = (try? context.fetch(fetchRequest) as? [RepositoryDetail]) ?? []
            completion(data)
        }
    }
    
    func deleteRepository(by id: String) {
        defer {
            appDelegate.saveContext()
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RepositoryDetail")
        let predicate = NSPredicate(format: "id = %@", id)
        fetchRequest.predicate = predicate
        
        do {
            guard let data = try? context.fetch(fetchRequest) as? [RepositoryDetail],
                let repository = data.first else { return }
            context.delete(repository)
        }
    }
    
    func checkFavorite(by id: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RepositoryDetail")
        let predicate = NSPredicate(format: "id = %@", id)
        fetchRequest.predicate = predicate
        do {
            let data = (try? context.fetch(fetchRequest) as? [RepositoryDetail]) ?? []
            if data.isEmpty {
                return false
            } else {
                return true
            }
        }
    }
}
