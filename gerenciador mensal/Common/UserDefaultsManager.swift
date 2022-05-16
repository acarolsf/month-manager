//
//  UserDefaultsManager.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 04/05/22.
//

import Foundation

enum UserDefaultsCustomKeys: String {
    case name
}

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    let userDefaults = UserDefaults.standard
    
    func setUserDefaults<T>(object: T?, key: UserDefaultsCustomKeys) {
        guard let value = object else { return }
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    func getUserDefaults(key: UserDefaultsCustomKeys) -> Any? {
        return userDefaults.object(forKey: key.rawValue)
    }
    
    func updateUserDefaults<T>(object: T?, with key: UserDefaultsCustomKeys) {
        userDefaults.object(forKey: key.rawValue)
        userDefaults.set(object, forKey: key.rawValue)
    }
    
    func removeUserDefaults(with key: UserDefaultsCustomKeys) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
