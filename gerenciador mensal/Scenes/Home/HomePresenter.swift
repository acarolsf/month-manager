//
//  HomePresenter.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 30/04/22.
//

import Foundation
import CoreData

protocol HomeViewProtocol: AnyObject {
    func reloadData()
    func removeItem(at index: IndexPath)
}

class HomePresenter {
    
    weak var view: HomeViewProtocol?
    var coreDataManager: CoreDataManager
    
    lazy var fetcher: NSFetchedResultsController<Contas> = {
        let fetchRequest: NSFetchRequest<Contas> = Contas.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "mes", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetcher = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataManager.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetcher
    }()
    
    required init(view: HomeViewProtocol, coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.view = view
        self.coreDataManager = coreDataManager
    }
    
    func logout() {
        UserDefaults.standard.eraseUsersDefaultData()
    }
    
    func fetchItems() {
        Contas.fetchContas(fetcher)
    }
    
    func deleteConta(_ index: IndexPath) {
        guard let conta = fetcher.fetchedObjects?[index.row] else { return }
        conta.deleteConta(coreDataManager.persistentContainer.viewContext)
    }
    
    func getTotal() -> String {
        var total = 0.0
        guard let objects = fetcher.fetchedObjects else { return "" }
        
        objects.forEach({ total += $0.preco })
        
        if let totalString = getPrice(total) {
            return totalString
        }
        return ""
    }
    
    func getPrice(_ value: Double) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "pt_BR")
        numberFormatter.numberStyle = .currency
        
        let number = NSNumber(value: value)
        
        return numberFormatter.string(from: number)
    }
}
