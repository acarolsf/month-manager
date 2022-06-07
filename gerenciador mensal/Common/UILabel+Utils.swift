//
//  UILabel+Utils.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 18/05/22.
//

import Foundation
import UIKit

extension UILabel {
    
    func setAtributtedTextBoldAndRegular(bold: String, regular: String) {
        let boldAttrib = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16) as Any]
        let regularAttrib = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16) as Any]
        let atributtedString = NSMutableAttributedString(string: bold, attributes: boldAttrib)
        atributtedString.append(NSMutableAttributedString(string: regular, attributes: regularAttrib))
        
        self.attributedText = atributtedString
    }
}
