//
//  String+Utils.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 03/05/22.
//

import Foundation

extension String {
    internal func applyingPattern(_ pattern: String, replacementCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)

        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else {
                return pureNumber
            }

            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]

            guard patternCharacter != replacementCharacter else {
                continue
            }

            pureNumber.insert(patternCharacter, at: stringIndex)
        }

        return String(pureNumber.prefix(pattern.count))
    }
    
    func currencyInputFormatting() -> String {

        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2

        var amountWithPrefix = self
        let regex = try? NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex?.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "") ?? amountWithPrefix
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))

        guard number != 0 as NSNumber else {
            return ""
        }

        return formatter.string(from: number) ?? ""
    }
}
