//
//  RegisterItemPresenter.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 30/04/22.
//

import Foundation
import CoreData

protocol RegisterItemViewProtocol: AnyObject {
    func goBack()
}

class RegisterItemPresenter {
    
    weak var view: RegisterItemViewProtocol?
    var coreDataManager: CoreDataManager
    
    required init(view: RegisterItemViewProtocol, coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.view = view
        self.coreDataManager = coreDataManager
    }
    
    func save(conta: Contas) {
        conta.save(coreDataManager.persistentContainer.viewContext)
        self.view?.goBack()
    }
    
    
    func editItem(conta: Contas) {
        conta.save(coreDataManager.persistentContainer.viewContext)
        self.view?.goBack()
    }
}
