//
//  PostCell.swift
//  Reddit Reader
//
//  Created by JTRACY9 on 2/23/18.
//  Copyright © 2018 JTRACY9. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var subreddit: UILabel!
    
    public func setLabels(post: Post) {
        self.title.text = post.title
        self.subreddit.text = "r/" + post.subReddit
    }
}
