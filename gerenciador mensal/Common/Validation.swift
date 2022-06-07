//
//  Validation.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 18/05/22.
//

import Foundation

class Validation {
    
    static let shared = Validation()
    
    func convertPriceToDouble(_ value: String?) -> Double {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "pt_BR")
        numberFormatter.numberStyle = .currency
    
        if let value = value, let number = numberFormatter.number(from: value) {
            return number.doubleValue
        }
        return 0.0
    }
    
    func convertDateToDate(date: String?) -> Date? {
        guard let date = date else { return nil }

        let dateString = "01/\(date)"
        
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "dd/MM/yyyy"
        return dateFormate.date(from: dateString)
    }
    
    func convertDateToString(date: Date?) -> String {
        guard let date = date else { return "" }

        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "MM/yyyy"
        
        return dateFormate.string(from: date)
    }
    
    func convertPriceToString(_ value: Double?) -> String {
        guard let value = value else { return "" }

        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "pt_BR")
        numberFormatter.numberStyle = .currency
        
        let number = NSNumber(value: value)
        
        return numberFormatter.string(from: number) ?? ""
    }
}
