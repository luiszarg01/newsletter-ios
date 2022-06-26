//
//  ViewController.swift
//  newsletter-ios
//
//  Created by dev on 2022-06-25.
//

import UIKit

class ViewController: UIViewController {

    private var viewModel = PostsViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        

        
    }
    
    private func bindViewModel() {
        viewModel.getPosts {
            self.tableView.reloadData()
        }
        
        viewModel.onPostsChanged = {
            self.tableView.reloadData()
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.postTableViewCellID, for: indexPath)!
        cell.configure(model: viewModel.posts[indexPath.row])
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = R.storyboard.main.postDetailViewControllerID()!
        vc.viewModel.selectedPost = viewModel.posts[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! PostTableViewCell
        vc.headerImage = cell.postImage
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
