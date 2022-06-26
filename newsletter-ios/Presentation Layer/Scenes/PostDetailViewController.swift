//
//  PostDetailViewController.swift
//  newsletter-ios
//
//  Created by dev on 2022-06-25.
//

import Foundation
import UIKit


class PostDetailViewController: UIViewController {
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerImageView: UIImageView!
    
    
    var post:PostModel!
    var comments:[PostComment] = []
    var headerImage:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getComments()
        setupView()
    }
    
    private func setupView() {
        
        headerImageView.image = headerImage
        tableView.delegate = self
        tableView.dataSource = self
        postTitleLabel.text = post.title ?? ""
        postBodyLabel.text = post.body ?? ""
        
    }
    
    private func getComments() {
        
        guard let id = post.id else { return }
        
        HTTPClient.request(endpoint: "posts/\(id)/comments", onSuccess: { (response:[PostComment]) in
            self.comments = response
            self.tableView.reloadData()
        })
    }
    
}


extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = comments[indexPath.row].body ?? ""
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12.0)
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
