//
//  SubredditTableViewManager.swift
//  Reddit Reader
//
//  Created by JTRACY9 on 2/23/18.
//  Copyright © 2018 JTRACY9. All rights reserved.
//

import UIKit

protocol SubredditTableViewManagerDelegate {
    func itemSelected(post: Post)
}

class SubredditTableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    let PostCell = "postCell"
    var posts: [Post] = [Post]()
    var delegate: SubredditTableViewManagerDelegate?
    
    convenience init(delegate: SubredditTableViewManagerDelegate) {
        self.init()
        self.delegate = delegate
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell, for: indexPath)
        if let c = cell as? PostCell {
            let index = indexPath.row
            c.setLabels(post: posts[index])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.itemSelected(post: posts[indexPath.row])
    }
}
