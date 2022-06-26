//
//  CustomAlertViewController.swift
//  newsletter-ios
//
//  Created by dev on 2022-06-26.
//

import UIKit
 
class CustomAlertViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var cardContainer: UIView!
    @IBOutlet weak var imageViewAlert: UIImageView!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var titleAlert: UILabel!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var messageAlert: UILabel!
    @IBOutlet weak var positiveButton: UIButton!
    @IBOutlet weak var negativeButton: UIButton!
    
    var onCompletion: (() -> Void)? = nil
    var onDismiss: (() -> Void)? = nil
    
    private var alertTitle: String?
    private var alertMessage: String?
    private var alertTitleAttr: NSMutableAttributedString?
    private var alertImage: UIImage?
    private var positiveBttnTitle: String = "Accept"
    private var negativeBttnTitle: String = "Cancel"
    var mainColor: UIColor = .systemGreen
    var completionAfterDismiss:Bool! = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        
        if let popupTitle = alertTitle, !popupTitle.isEmpty {
            titleAlert.text = popupTitle
            negativeButton.setTitleColor(mainColor, for: .normal)
        }else if let popupTitle = alertTitleAttr, popupTitle.length > 0 {
            titleAlert.attributedText = popupTitle
            titleAlert.numberOfLines = 0
            
            negativeButton.setTitleColor(.systemGreen, for: .normal)
        }else {
            titleAlert.isHidden = true
        }
        
        if let popupMessage = alertMessage, !popupMessage.isEmpty {
            messageAlert.text = popupMessage
        }else {
            messageAlert.isHidden = true
        }
        
        if let popupImage = alertImage {
            imageViewAlert.image = popupImage
        }else {
            imageViewAlert.isHidden = true
            imageContainer.isHidden = true
        }
    }
    
    private func setupView(){
        titleAlert.font = .boldSystemFont(ofSize: 16)
        titleAlert.textColor = mainColor
        separator.backgroundColor = mainColor
        messageAlert.font = UIFont.systemFont(ofSize: 14)
        messageAlert.textColor = .black
        
        positiveButton.setTitle(positiveBttnTitle, for: .normal)
        positiveButton.setTitleColor(.white, for: .normal)
        positiveButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        positiveButton.backgroundColor = mainColor
        
        negativeButton.setTitle(negativeBttnTitle, for: .normal)
        negativeButton.backgroundColor = .white
        negativeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cardContainer.layer.cornerRadius = 10
    }
    
    @IBAction func onTapPositiveButton(_ sender: Any) {

        if completionAfterDismiss {
            dismiss(animated: true, completion: { [weak self] in
                self?.onCompletion?()
            })
        } else {
            self.onCompletion?()
            self.dismiss(animated: true, completion: nil)

        }
        
    }
    
    @IBAction func onTapNegativeButton(_ sender: Any) {
        dismiss(animated: true, completion: { [weak self] in
            self?.onDismiss?()
        })
    }
    
    
    
    class func show(mainColor:UIColor? = .systemGreen,title: String? = nil, message: String? = nil, image: UIImage? = nil, in viewController: UIViewController, onDismiss: (() -> Void)? = nil, onCompletion: @escaping () -> Void, completionAfterDismiss:Bool = false) {
        let vc = R.storyboard.main.customAlertViewControllerID()!
        vc.mainColor = mainColor!
        vc.alertTitle = title
        vc.alertMessage = message
        vc.alertImage = image
        vc.providesPresentationContextTransitionStyle = true
        vc.definesPresentationContext = true
        vc.modalPresentationStyle = .overFullScreen
        vc.onCompletion = onCompletion
        vc.onDismiss = onDismiss
        vc.completionAfterDismiss = completionAfterDismiss
        viewController.present(vc, animated: true, completion: nil)
    }
    
    class func show(mainColor:UIColor? = .systemGreen,title: NSMutableAttributedString? = nil, message: String? = nil, image: UIImage? = nil, positiveButton: String, negativeButton: String, in viewController: UIViewController, onDismiss: (() -> Void)? = nil, onCompletion: @escaping () -> Void, completionAfterDismiss:Bool = false) {
        let vc = R.storyboard.main.customAlertViewControllerID()!
        vc.mainColor = mainColor!
        vc.alertTitleAttr = title
        vc.positiveBttnTitle = positiveButton
        vc.negativeBttnTitle = negativeButton
        vc.alertMessage = message
        vc.alertImage = image?.withTintColor(.systemGreen, renderingMode: .alwaysTemplate)
        vc.providesPresentationContextTransitionStyle = true
        vc.definesPresentationContext = true
        vc.modalPresentationStyle = .overFullScreen
        vc.onCompletion = onCompletion
        vc.onDismiss = onDismiss
        vc.completionAfterDismiss = completionAfterDismiss
        viewController.present(vc, animated: true, completion: nil)
    }
    
    deinit {
        print("👋 bye bye CustomAlertViewController")
    }
    
}
