//
//  TextField+Utils.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 30/04/22.
//

import Foundation
import UIKit

extension UITextInput {
    func addToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        
        var defaultAction: (target: Any, action: Selector)?  = nil
        
        if let input = self as? UIResponder {
            defaultAction = (target: input, action: #selector(UIResponder.resignFirstResponder))
        }
        
        let onCancel = onCancel ?? defaultAction
        let onDone = onDone ?? defaultAction
        
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: onCancel?.target, action: onCancel?.action)
        cancelButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.blue], for: .normal)
        
        let doneButton = UIBarButtonItem(title: "OK", style: .done, target: onDone?.target, action: onDone?.action)
        doneButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.blue], for: .normal)
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            cancelButton,
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            doneButton
        ]
        
        toolbar.sizeToFit()
        
        if let textField = self as? UITextField {
            textField.inputAccessoryView = toolbar
        }
        if let textView = self as? UITextView {
            textView.inputAccessoryView = toolbar
        }
    }
}

extension UITextField {
    func setIcon(_ image: UIImage, withRect: CGRect) {
        let iconView = UIImageView(frame: withRect)
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 33, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
    
    func setiConInRightSide (_ image: UIImage) {
        rightViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        imageView.image = image
        rightView = imageView
    }
}
