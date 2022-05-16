//
//  TextField.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 29/04/22.
//

import Foundation
import UIKit
import CloudKit

enum TextFieldType {
    case currency
    case date
    case none
}

class TextField: UITextField {
    
    var type: TextFieldType = .none
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        layer.borderColor = UIColor(hex: "#999999").cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 4
        delegate = self
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

extension TextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let isAddingCharacter = range.length <= 0
        var currentText = textField.text ?? ""
        currentText = isAddingCharacter ? currentText + string : String(currentText.dropLast(1))

        switch self.type {
            
        case .currency:
            var textFieldText = textField.text ?? ""
            
            guard string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil,
                  let range = Range(range, in: textFieldText) else { return false }
            
            textFieldText = textFieldText.replacingCharacters(in: range, with: string)
            textField.text = textFieldText.currencyInputFormatting()
            return false
        case .date:
            guard string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil else {
                return false
            }

            textField.text = currentText.applyingPattern("##/####", replacementCharacter: "#")

            return false
        case .none:
            return true
            
        }
    }
}

extension TextField {
    internal var validationMessage: String? {
        
        guard let value = self.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty else {
            return nil
        }
        
        let fieldIsInvalidMessage = "Campo inválido"
        
        switch self.type {
        case .currency:
            if value.first != "R"{
                return fieldIsInvalidMessage
            }
            
            let formartter = NumberFormatter()
            formartter.locale = Locale(identifier: "pt_BR")
            formartter.numberStyle = .currency
        case .date:
            if value.applyingPattern("##/####", replacementCharacter: "#").count != 7 {
                return fieldIsInvalidMessage
            }

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateFormatter.locale = Locale(identifier: "pt_BR")

            if dateFormatter.date(from: "01/" + value) == nil {
                return fieldIsInvalidMessage
            }
        case .none:
            if value.isEmpty {
                return fieldIsInvalidMessage
            }
        }
        return nil
    }
}
