//
//  NewsPresenter.swift
//  NewsApp
//
//  Created by VN01-MAC-0006 on 24/09/2021.
//

import Foundation
import UIKit


protocol NewsView {
    func refreshNewsView()
    func reloadRow(at indexPath: IndexPath)
    func showDetailView(news : News)
    func displayNewsRetrievalError(title: String, message: String)

}
protocol NewsCellView {
    func display(title: String)
    func display(content: String)
    func display(publicDate: String)
    func display(image: Data)
}

protocol NewsPresenter {
    var numberOfNews: Int { get }
    var news : [News] {get set}
    func getNews()
    func configure(cell: NewsCellView, forRow indexPath: IndexPath)
    func didSelect(row: Int)
}

class NewsPresenterImplementation: NewsPresenter {
    let pendingOperations = PendingOperations()
    var newsModel : NewsModel
    let view : NewsView
    var news = [News]()
    var numberOfNews: Int {
        return news.count
    }
    init(newsModel :  NewsModel, newsView : NewsView) {
        self.newsModel  = newsModel
        self.view = newsView
    }
    
    func configure(cell: NewsCellView, forRow indexPath : IndexPath) {
        let news = news[indexPath.row]
        cell.display(title: news.title)
        cell.display(content: news.description)
        cell.display(publicDate: news.pubDate)
        if news.state == .new {
            fetchImage(indexPath: indexPath)
        }else {
            cell.display(image:news.imageData )
        }
    }
    
    
    func getNews() {
        newsModel.fetchNews { result in
            switch result {
            case let .success(listNews):
                self.news = listNews
                self.view.refreshNewsView()
            case let .failure(err):
                self.view.displayNewsRetrievalError(title: "Error", message: err.localizedDescription)
            }
        }
    }
    
    
    func didSelect(row: Int) {
        view.showDetailView(news: self.news[row])

    }
    
    private  func fetchImage(indexPath: IndexPath) {
        startOperations(for: news[indexPath.row], at: indexPath)
    }
    
    private func startOperations(for newsRecord: News, at indexPath: IndexPath) {
        switch (newsRecord.state) {
        case .new:
            startDownload(for: newsRecord, at: indexPath)
        default:
            NSLog("do nothing")
        }
    }
    
    private func startDownload(for newsRecord: News, at indexPath: IndexPath) {
        guard pendingOperations.downloadsInProgress[indexPath] == nil else {
            return
        }
        
        let downloader = ImageDownloader(newsRecord)
        pendingOperations.downloadsInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                print("downloader Operations complete ______: \(indexPath.row)")
                self?.news[indexPath.row] = downloader.newsRecord
                self?.view.reloadRow(at: indexPath)
            }
        }
    }
}
