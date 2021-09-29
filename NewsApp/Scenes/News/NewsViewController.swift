//
//  NewsViewController.swift
//  NewsApp
//
//  Created by VN01-MAC-0006 on 24/09/2021.
//

import UIKit


class NewsViewController: UIViewController, NewsView {
    func reloadRow(at indexPath: IndexPath) {
        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    func refreshBooksView() {
        tableView.reloadData()
        
    }
    
    func displayBooksRetrievalError(title: String, message: String) {
        
    }
    
    func displayBookDeleteError(title: String, message: String) {
        
    }
    
    func deleteAnimated(row: Int) {
        
    }
    
    func endEditing() {
        
    }
    
    
    var newsPresenter : NewsPresenter?
    
    lazy var tableView : UITableView = {
        print("Create tableview and this code will run only  once time")
        let tbView = UITableView()
        return tbView
    }()
    
    override func viewDidLoad() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo : self.view.bottomAnchor).isActive = true
//        NSLayoutConstraint.activate([leading,trailing,top,bottom])
        
        let apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default,
                                                completionHandlerQueue: OperationQueue.main)
        let newParse = NewsParseXmlImplement()
        let newRequest = NewsApiRequest()

        let newsModel = NewsModelImplementation(apiClient: apiClient, newsParse: newParse, newsRequest: newRequest)
        
        newsPresenter = NewsPresenterImplementation(newsModel: newsModel, newsView: self)
        newsPresenter?.getNews()
        
        
    }

}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsPresenter!.numberOfNews
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        newsPresenter?.configure(cell: cell, forRow: indexPath)
        return cell
                
    }
    

}

extension NewsViewController: UITableViewDelegate {
    

}

