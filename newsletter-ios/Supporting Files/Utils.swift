//
//  Utils.swift
//  newsletter-ios
//
//  Created by dev on 2022-06-26.
//

import Foundation
import UIKit
import NVActivityIndicatorView

final class Utils {
    
    class func showAlert(withMessage message: String, title: String = "", in vc: UIViewController, style: UIAlertController.Style = .alert, callback: (() -> Void)? = nil) {
        vc.hideActivityIndicator()
        let popup = UIAlertController(title: title, message: message, preferredStyle: style)
        popup.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            callback?()
        }))
        vc.present(popup, animated: true, completion: nil)
    }
    
    
}

func performForUI(_ callback: @escaping () -> Void) {
    DispatchQueue.main.async {
        callback()
    }
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


extension UIViewController: NVActivityIndicatorViewable {

    // MARK: - Regular Activity Indicator

    func showActivityIndicator() {
        performForUI {

            self.view.endEditing(true)
            self.startAnimating(CGSize(width: 50, height: 50), type: .ballSpinFadeLoader, color: .white, backgroundColor: UIColor.black.withAlphaComponent(0.7))
        }
    }

    func hideActivityIndicator() {
        performForUI {
            self.stopAnimating()
        }
    }

}
