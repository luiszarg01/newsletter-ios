//
//  PostTableViewCell.swift
//  newsletter-ios
//
//  Created by dev on 2022-06-26.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var PostTitleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    var postImage:UIImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let random = Int.random(in: 1..<10)
        postImage = UIImage(named: "resource\(random)")
        postImageView.image = postImage
    }

    func configure(model:PostModel) {
        PostTitleLabel.text = model.title
        
    }
    
}
