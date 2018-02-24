//
//  WebViewController.swift
//  Reddit Reader
//
//  Created by JTRACY9 on 2/24/18.
//  Copyright © 2018 JTRACY9. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var post: Post?

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let p = post {
            webView.load(URLRequest(url: URL(string: p.link)!))
        }
    }

}
