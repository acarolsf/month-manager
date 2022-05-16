//
//  LoginPresenter.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 30/04/22.
//

import Foundation

protocol LoginViewProtocol: AnyObject {
    func goToHome(name: String)
}

class LoginPresenter {
    weak var view: LoginViewProtocol?
    
    required init(view: LoginViewProtocol) {
        self.view = view
    }
    
    func checkIfUserIsLogged() {
        // TODO: - Check here
        if let name = UserDefaultsManager.shared.getUserDefaults(key: .name) as? String {
            self.view?.goToHome(name: name)
        }
        
    }
    
    func login(userName: String?) {
        // TODO: - Login here
        guard let name = userName, !name.isEmpty else { return }
        UserDefaultsManager.shared.setUserDefaults(object: name, key: .name)
        self.view?.goToHome(name: name)
    }
}
