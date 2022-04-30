//
//  HomePresenter.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 30/04/22.
//

import Foundation

protocol HomeViewProtocol: AnyObject { }

class HomePresenter {
    
    weak var view: HomeViewProtocol?
    
    required init(view: HomeViewProtocol) {
        self.view = view
    }
    
}
