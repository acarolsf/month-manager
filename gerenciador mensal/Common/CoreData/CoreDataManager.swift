//
//  CoreDataManager.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 03/05/22.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "gerenciador_mensal")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    
    func saveContext() {
        let context = persistentContainer.viewContext
        saveData(context)
    }
    
    func fetchRequest<T>(entity: String) -> NSFetchRequest<T> {
        return NSFetchRequest(entityName: entity)
    }

    func saveData (_ context: NSManagedObjectContext) {
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchData<T>(_ fectchedResultController: NSFetchedResultsController<T>) {
        do {
            try fectchedResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteData(_ context: NSManagedObjectContext, item: NSManagedObject) {
        context.delete(item)
        saveData(context)
    }
}
