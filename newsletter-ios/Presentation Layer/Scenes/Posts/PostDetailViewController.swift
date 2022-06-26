//
//  PostDetailViewController.swift
//  newsletter-ios
//
//  Created by dev on 2022-06-25.
//

import Foundation
import UIKit


class PostDetailViewController: UIViewController {
    
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var authorUsernameLabel: UILabel!
    @IBOutlet weak var authorEmailLabel: UILabel!
    @IBOutlet weak var authorPhoneLabel: UILabel!
    @IBOutlet weak var authorWebsiteLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerImageView: UIImageView!
    
    
    var post:PostModel!
    var comments:[PostComment] = []
    var author:UserModel!
    var headerImage:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getComments()
        getAuthor()
        setupView()
    }
    
    private func setupView() {
        
        headerImageView.image = headerImage
        tableView.delegate = self
        tableView.dataSource = self
        postTitleLabel.text = post.title ?? ""
        postBodyLabel.text = post.body ?? ""
        
    }
    
    private func setupAuthorView() {
        
        authorImageView.layer.borderColor = UIColor.systemGreen.cgColor
        authorImageView.layer.borderWidth = 3
        authorImageView.layer.cornerRadius = authorImageView.frame.width / 2
        authorNameLabel.text = author.name
        authorUsernameLabel.text = "(\(author.formattedUsername))"
        authorEmailLabel.text = author.email
        authorPhoneLabel.text = author.phone
        authorWebsiteLabel.text = author.website
        
    }
    
    private func getComments() {
        
        guard let id = post.id else { return }
        
        HTTPClient.request(endpoint: "posts/\(id)/comments", onSuccess: { (response:[PostComment]) in
            self.comments = response
            self.tableView.reloadData()
        })
    }
    
    private func getAuthor() {
        
        guard let id = post.userID else { return }
        
        HTTPClient.request(endpoint: "users/\(id)", onSuccess: { (response:UserModel) in
            self.author = response
            self.setupAuthorView()
        })
    }
    
}


extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.commentTableViewCellID, for: indexPath)!
        cell.configure(comment: comments[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}
