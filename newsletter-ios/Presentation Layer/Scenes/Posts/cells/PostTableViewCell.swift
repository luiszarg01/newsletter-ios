//
//  PostTableViewCell.swift
//  newsletter-ios
//
//  Created by dev on 2022-06-26.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var PostTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    var postImage:UIImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let random = Int.random(in: 1..<10)
        postImage = UIImage(named: "resource\(random)")

    }

    func configure(model:PostModel) {
        postImageView.image = model.image
        PostTitleLabel.text = model.title
        favoriteImageView.isHidden = !model.favorite
    }
    
}
