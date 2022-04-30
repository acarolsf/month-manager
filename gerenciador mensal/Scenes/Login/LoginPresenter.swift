//
//  LoginPresenter.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 30/04/22.
//

import Foundation

protocol LoginViewProtocol: AnyObject {}

class LoginPresenter {
    weak var view: LoginViewProtocol?
    
    required init(view: LoginViewProtocol) {
        self.view = view
    }
    
    func checkIfUserIsLogged() {
        // TODO: - Check here
    }
    
    func login() {
        // TODO: - Login here
    }
}
