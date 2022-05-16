//
//  Contas.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 03/05/22.
//

import Foundation
import CoreData
import UIKit

@objc(Contas)
class Contas: NSManagedObject {
    
    @NSManaged var id: UUID
    @NSManaged var tipoConta: String
    @NSManaged var descricao: String
    @NSManaged var mes: Date
    @NSManaged var preco: Double
    
    convenience init(tipoConta: String, descricao: String, mes: Date, preco: Double) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        self.init(context: context)
        self.id = UUID()
        self.tipoConta = tipoConta
        self.descricao = descricao
        self.mes = mes
        self.preco = preco
    }
    
}

extension Contas {
    
    class func fetchRequest() -> NSFetchRequest<Contas> {
        return NSFetchRequest(entityName: "Contas")
    }
    
    func save(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    class func fetchContas(_ fectchedResultController: NSFetchedResultsController<Contas>) {
        do {
            try fectchedResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteConta(_ context: NSManagedObjectContext) {
        context.delete(self)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
