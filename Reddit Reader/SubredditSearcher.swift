//
//  SubredditSearcher.swift
//  Reddit Reader
//
//  Created by JTRACY9 on 2/22/18.
//  Copyright © 2018 JTRACY9. All rights reserved.
//

import UIKit

protocol SubredditSearcherDelegate {
    func subredditSearch(posts: [Post])
}

struct Post {
    
    init(title: String = "", subReddit: String = "", link: String) {
        self.title = title
        self.subReddit = subReddit
        self.link = link
    }
    
    var title: String
    var subReddit: String
    var link: String
}


class SubredditSearcher: NSObject {
    
    static let BaseURL = "http://www.reddit.com/"
    static let JsonExtension = ".json"
    
    var delegate: SubredditSearcherDelegate?
    var session: URLSession!
    
    required override init() {
        super.init()
        self.session = URLSession(configuration: .default)
    }
    
    convenience init(delegate: SubredditSearcherDelegate?) {
        self.init()
        self.delegate = delegate
    }
    
    func sendRequest(subreddit: String?){
        var url = SubredditSearcher.BaseURL
        if let sub = subreddit {
            url += "r/" + sub + "/"
        }
        url += SubredditSearcher.JsonExtension
        let networkTask = session.dataTask(with: URL(string: url)!, completionHandler : {data, response, error -> Void in
            do {
                var posts = [Post]()
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any], let meta = (json["data"] as? [String: Any]) , let post = meta["children"] as? [NSDictionary] {
                    posts = self.jsonToPosts(json: post)
                }
                self.delegate?.subredditSearch(posts: posts)
            } catch {
                self.delegate?.subredditSearch(posts: [Post]())
            }
        })
        networkTask.resume()
    }
    
    func jsonToPosts(json: [NSDictionary]) -> [Post] {
        var posts = [Post]()
        for post in json {
            let data = post["data"] as? NSDictionary
            if let title = data?["title"] as? String, let link = data?["url"] as? String, let subreddit = data?["subreddit"] as? String {
                posts.append(Post(title: title, subReddit: subreddit, link: link))
            }
        }
        return posts
    }

}
