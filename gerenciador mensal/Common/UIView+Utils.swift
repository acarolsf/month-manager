//
//  UIView+Utils.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 30/04/22.
//

import UIKit

extension UIView {
    @objc convenience init(constraintResizing: Bool) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = constraintResizing
    }
}

extension UIViewController {
    
    func setupNavigationBar() {
        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        
        UINavigationBar.appearance().barTintColor = UIColor(hex: "#054F77")
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .default
        
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(hex: "#054F77")
            appearance.titleTextAttributes =  [.foregroundColor: UIColor.white]
            
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.isTranslucent = true
            
        }
    }
}
