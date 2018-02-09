//
//  NewsDetailsViewController.swift
//  GC
//
//  Created by hzg on 2018/2/9.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class NewsDetailsViewController: BaseViewController {

    var news = (title:"", url:"") {
        didSet {
            perform(#selector(delay), with: nil, afterDelay: 0.1)
        }
    }
    
    @IBOutlet weak var webView: UIWebView!
    
    // MARK: - override methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc private func delay() {
        navigationItem.title = news.title
        guard let url = URL(string: news.url) else {
            return
        }
        webView.loadRequest(URLRequest(url: url))
    }
}
