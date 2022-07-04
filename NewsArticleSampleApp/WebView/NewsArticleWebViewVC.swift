//
//  NewsArticleWebViewVC.swift
//  NewsArticleSampleApp
//
//  Created by Rakesh Medpalli on 01/07/22.
//

import Foundation
import UIKit
import WebKit

class NewsArticleWebViewVC: UIViewController {
    var urlStr: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
    }
    
    func loadWebView() {
        guard let url = URL(string: urlStr ) else {
            return
        }
        let request = URLRequest(url: url)
        let webView = WKWebView(frame: self.view.frame)
        webView.load(request)
        self.view.addSubview(webView)

    }
    
}
