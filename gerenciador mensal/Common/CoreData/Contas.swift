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
        return CoreDataManager.shared.fetchRequest(entity: "Contas")
    }
    
    func save(_ context: NSManagedObjectContext) {
        CoreDataManager.shared.saveData(context)
    }
    
    class func fetchContas(_ fetchedResultController: NSFetchedResultsController<Contas>) {
        CoreDataManager.shared.fetchData(fetchedResultController)
    }
    
    func deleteConta(_ context: NSManagedObjectContext) {
        CoreDataManager.shared.deleteData(context, item: self)
    }
}
