//
//  ViewController.swift
//  newsletter-ios
//
//  Created by dev on 2022-06-25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var posts:[PostModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        HTTPClient.request(endpoint: "posts", onSuccess: { (response:[PostModel]) in
            self.posts = response
            self.tableView.reloadData()
        }
        )
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = posts[indexPath.row].title
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12.0)
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = R.storyboard.main.postDetailViewControllerID()!
        vc.post = posts[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
