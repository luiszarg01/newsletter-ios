//
//  ViewController.swift
//  newsletter-ios
//
//  Created by dev on 2022-06-25.
//

import UIKit

class ViewController: UIViewController {

    private var viewModel = PostsViewModel()
    @IBOutlet weak var listFiltersegmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bindViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func bindViewModel() {
        viewModel.getPosts {
            self.tableView.reloadData()
        }
        
        viewModel.onPostsChanged = {
            self.tableView.reloadData()
        }
    
        
    }

    @IBAction func onSegmentControlTapped(_ sender: Any) {
        
        switch listFiltersegmentControl.selectedSegmentIndex  {
            
        case 0:
            viewModel.filteredPosts = viewModel.posts
            tableView.reloadData()
        case 1:
            viewModel.filterByFavorites()
        default:
            break
        }
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.postTableViewCellID, for: indexPath)!
        cell.configure(model: viewModel.filteredPosts[indexPath.row])
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.filteredPosts[indexPath.row]
        let vc = R.storyboard.main.postDetailViewControllerID()!
        vc.title = self.navigationItem.title
        vc.viewModel.selectedPost = model
        vc.viewModel.onPostsChanged = viewModel.onPostsChanged
        vc.onSetFavorite = { [weak self] newFavorite in
            guard let self = self else { return }
            guard let idx = (self.viewModel.posts.firstIndex { $0.id == newFavorite.id }) else { return }
            self.viewModel.posts[idx] = newFavorite
            self.viewModel.posts = self.viewModel.posts.sorted { $0.favorite && !$1.favorite}
            self.viewModel.filteredPosts = self.viewModel.posts
        }
        
        vc.onDelete = { [weak self] post in
            guard let self = self else { return }
            self.viewModel.removePost(post: post)
        }
        vc.headerImage = model.image
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
