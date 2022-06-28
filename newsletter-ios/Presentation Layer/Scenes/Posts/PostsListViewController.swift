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
    @IBOutlet weak var deleteViewContainer: UIView!
    @IBOutlet weak var deleteIcon: UIImageView!
    
    private var pullControl = UIRefreshControl()
    
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
        self.navigationController?.viewStyle(with: .systemGreen)

    }
    
    private func setupView() {
        
        pullControl.addTarget(self, action: #selector(refreshListData), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = pullControl
        } else {
            tableView.addSubview(pullControl)
        }
        
        deleteIcon.image = R.image.delete()!.tinted_with(color: .white)
        deleteViewContainer.layer.cornerRadius = deleteViewContainer.frame.width/2
        deleteViewContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector( onDeleteButtonTapped(_:))))
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func bindViewModel() {
        viewModel.getPosts {
            self.tableView.reloadData()
        }
        
        viewModel.onPostsChanged = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    
        
    }

    @objc private func refreshListData() {
        viewModel.getPostsFromAPI()
        self.pullControl.endRefreshing()
    }
    
    
    @IBAction func segmentControlTapped(_ sender: Any) {
        switch listFiltersegmentControl.selectedSegmentIndex  {
            
        case 0:
            viewModel.filteredPosts = viewModel.posts
        case 1:
            viewModel.filterByFavorites()
        default:
            break
        }
        
        
    }
    
    @objc func onDeleteButtonTapped(_ sender:AnyObject) {
        CustomAlertViewController.show(mainColor: .systemPink, title: "Warning", message: "Are you sure you want to remove all entries? this action won't delete favorites.", image: R.image.delete()!.tinted_with(color: .systemPink)!, in: self, onCompletion: {
            self.viewModel.removeAll()
        })

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
            self.viewModel.posts.removeAll { $0.id == post.id! }
            self.viewModel.filteredPosts = self.viewModel.posts
            self.tableView.reloadData()
            self.viewModel.removePost(post: post)
        }
        vc.headerImage = model.image
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
