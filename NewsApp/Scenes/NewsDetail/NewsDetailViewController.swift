//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by VN01-MAC-0006 on 25/09/2021.
//

import Foundation
import WebKit

class NewsDetailViewController: UIViewController {
    lazy var webView: WKWebView = {
        let wv = WKWebView()
        wv.uiDelegate = self
        wv.navigationDelegate = self
        wv.translatesAutoresizingMaskIntoConstraints = false
        return wv
    }()
    override func viewDidLoad() {
        view.addSubview(webView)
           NSLayoutConstraint.activate([
               webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               webView.topAnchor.constraint(equalTo: view.topAnchor),
               webView.rightAnchor.constraint(equalTo: view.rightAnchor),
               webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        
        let url = URL(string: "https://www.hackingwithswift.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}

extension NewsDetailViewController : WKNavigationDelegate {
    
}

extension NewsDetailViewController : WKUIDelegate {
    
}
