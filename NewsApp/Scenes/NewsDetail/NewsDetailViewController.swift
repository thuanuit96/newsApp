//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by VN01-MAC-0006 on 25/09/2021.
//

import Foundation
import WebKit

class NewsDetailViewController: UIViewController  ,NewsDetailView{
    
    
    var presenter : NewsDetailPresenter!
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
        
        webView.allowsBackForwardNavigationGestures = true
        presenter.showNewsDetails()
        
    }
    
    func showNewsDetails(for news: News) {
        let urlRequest = URLRequest(url: URL(string: news.link)!)
        webView.load(urlRequest)
    }
    
}

extension NewsDetailViewController : WKNavigationDelegate {
    
}

extension NewsDetailViewController : WKUIDelegate {
    
}
