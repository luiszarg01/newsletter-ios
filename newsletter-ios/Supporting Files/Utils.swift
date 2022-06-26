//
//  Utils.swift
//  newsletter-ios
//
//  Created by dev on 2022-06-26.
//

import Foundation
import UIKit


final class Utils {
    
    
    
    
}

extension UIImage {
    func tinted_with(color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        color.set()
        withRenderingMode(.alwaysTemplate)
            .draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
