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
