//
//  TextField.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 29/04/22.
//

import Foundation
import UIKit

class TextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        layer.borderColor = UIColor(hex: "#999999").cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDisabled() {
        isUserInteractionEnabled = false
        backgroundColor = .lightGray
    }
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
}
