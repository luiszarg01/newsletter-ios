//
//  CommentTableViewCell.swift
//  newsletter-ios
//
//  Created by dev on 2022-06-26.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userCommentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func configure(comment:PostComment) {
        userImageView.layer.cornerRadius = userImageView.frame.width/2
        userNameLabel.text = comment.name
        userCommentLabel.text = comment.body
    }
    
}
