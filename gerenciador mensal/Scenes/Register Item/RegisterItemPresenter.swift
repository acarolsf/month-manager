//
//  RegisterItemPresenter.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 30/04/22.
//

import Foundation

protocol RegisterItemViewProtocol: AnyObject { }

class RegisterItemPresenter {
    
    weak var view: RegisterItemViewProtocol?
    
    required init(view: RegisterItemViewProtocol) {
        self.view = view
    }
}
