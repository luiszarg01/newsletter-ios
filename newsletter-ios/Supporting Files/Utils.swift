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

extension UINavigationController {
    
    func viewStyle(with color:UIColor) {
        self.navigationBar.tintColor = .white
        self.navigationBar.shadowImage = UIImage()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationBar.titleTextAttributes = textAttributes
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = color
            appearance.shadowColor = color
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            self.navigationBar.standardAppearance = appearance
            self.navigationBar.scrollEdgeAppearance = appearance
        } else {
            self.navigationBar.barTintColor = color
        }
        
        self.navigationBar.isTranslucent = true
    }
    
}
