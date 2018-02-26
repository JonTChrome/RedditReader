//
//  RedditViewerViewController.swift
//  Reddit Reader
//
//  Created by JTRACY9 on 2/22/18.
//  Copyright © 2018 JTRACY9. All rights reserved.
//

import UIKit

class RedditViewerViewController: UIViewController, UISearchBarDelegate, SubredditSearcherDelegate, SubredditTableViewManagerDelegate {
    
    let DefaultTitle = "Reddit Reader"
    
    var searcher: SubredditSearcher!
    
    var indexPath: IndexPath?
    
    @IBOutlet weak var titleBar: UINavigationItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var tableViewManager: SubredditTableViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewManager = SubredditTableViewManager(delegate: self)
        tableView.delegate = tableViewManager
        tableView.dataSource = tableViewManager
        searcher = SubredditSearcher(delegate: self)
        searchBar.delegate = self
        searcher.sendRequest(subreddit: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let index = indexPath {
            tableView.deselectRow(at: index, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text, text != "" {
            titleBar.title = text
            searcher.sendRequest(subreddit: text)
        } else {
            titleBar.title = DefaultTitle
            searcher.sendRequest(subreddit: nil)
        }
    }
    
    func subredditSearch(posts: [Post]) {
        tableViewManager.posts = posts
        DispatchQueue.main.sync {
            tableView.reloadData()
        }
    }
    
    func itemSelected(post: Post, indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "webView") as? WebViewController {
            vc.post = post
            self.indexPath = indexPath
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
