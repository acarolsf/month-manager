//
//  UIImage+Utils.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 29/04/22.
//

import Foundation
import UIKit

private class ImageManager {}

extension UIImage {
    public class var logo: UIImage {
        guard let image = UIImage(named: "month-manager", in: Bundle(for: ImageManager.self), compatibleWith: nil) else { return UIImage() }
        return image
    }
    
    public class var add: UIImage {
        guard let image = UIImage(named: "add", in: Bundle(for: ImageManager.self), compatibleWith: nil) else { return UIImage() }
        return image
    }
    
    public class var expandMore: UIImage {
        guard let image = UIImage(named: "expand-more", in: Bundle(for: ImageManager.self), compatibleWith: nil) else { return UIImage() }
        return image
    }
    
    public func getImage(named: String) -> UIImage {
        guard let image = UIImage(named: named, in: Bundle(for: ImageManager.self), compatibleWith: nil) else { return UIImage() }
        return image
    }
}
