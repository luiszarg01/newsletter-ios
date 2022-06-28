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
    
    var viewModel = PostsViewModel()
    var onSetFavorite: ( (PostModel) -> Void )?
    var onDelete:( (PostModel) -> Void )?
    
    var headerImage:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.parentView = self
        viewModel.getComments {
            self.tableView.reloadData()
        }
        
        viewModel.getAuthor {
            self.setupAuthorView()
        }
    }
    
    private func setupView() {
        
        headerImageView.image = headerImage
        tableView.delegate = self
        tableView.dataSource = self
        postTitleLabel.text = viewModel.selectedPost.title ?? ""
        postBodyLabel.text = viewModel.selectedPost.body ?? ""
        setupNavBar()
    }
    
    private func setupNavBar() {
        
        let imageName = viewModel.selectedPost.favorite ? "star.slash.fill" : "star.fill"
        let favoriteImage = UIImage(systemName: imageName)!
        let deleteImage  = UIImage(systemName: "trash.fill")!.withTintColor(.red)

        let favoriteButton = UIBarButtonItem(image: favoriteImage,  style: .plain, target: self, action: #selector(didTapFavoriteButton(sender:)))
        let deleteButton = UIBarButtonItem(image: deleteImage,  style: .plain, target: self, action: #selector(didTapDeleteButton(sender:)))
        let buttons = viewModel.selectedPost.favorite ? [favoriteButton] : [favoriteButton, deleteButton]
        navigationItem.rightBarButtonItems = buttons
        
    }
    
    private func setupAuthorView() {
        
        authorImageView.layer.borderColor = UIColor.systemGreen.cgColor
        authorImageView.layer.borderWidth = 3
        authorImageView.layer.cornerRadius = authorImageView.frame.width / 2
        authorNameLabel.text = viewModel.author.name
        authorUsernameLabel.text = "(\(viewModel.author.formattedUsername))"
        authorEmailLabel.text = viewModel.author.email
        authorPhoneLabel.text = viewModel.author.phone
        authorWebsiteLabel.text = viewModel.author.website
        
    }
    
    
    @objc func didTapFavoriteButton(sender: AnyObject){
        viewModel.setFavorite { newFavorite in
            self.setupNavBar()
            self.onSetFavorite?(newFavorite)
        }
    }

    @objc func didTapDeleteButton(sender: AnyObject) {
        
        CustomAlertViewController.show(title: "Warning", message: "Are you sure you want to delete this post?", image: R.image.delete()!.tinted_with(color: .systemGreen)!, in: self, onCompletion: {
            self.onDelete?(self.viewModel.selectedPost)
            self.navigationController?.popViewController(animated: true)
            
        })
    }
    
}


extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.commentTableViewCellID, for: indexPath)!
        cell.configure(comment: viewModel.comments[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}
