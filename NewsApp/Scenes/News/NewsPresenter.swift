//
//  NewsPresenter.swift
//  NewsApp
//
//  Created by VN01-MAC-0006 on 24/09/2021.
//

import Foundation
import UIKit


protocol NewsView: AnyObject {
    func refreshBooksView()
    func reloadRow(at indexPath: IndexPath)
    func displayBooksRetrievalError(title: String, message: String)
    func displayBookDeleteError(title: String, message: String)
    func deleteAnimated(row: Int)
    func endEditing()
}


// It would be fine for the cell view to declare a BookCellViewModel property and have it configure itself
// Using this approach makes the view even more passive/dumb - but I can understand if some might consider it an overkill
protocol NewsCellView {
    func display(title: String)
    func display(content: String)
    func display(publicDate: String)
    func display(image: UIImage)
}

protocol NewsPresenter {
    var numberOfNews: Int { get }
    func getNews()
    func configure(cell: NewsCellView, forRow indexPath: IndexPath)
    
    //    func didSelect(row: Int)
    //    func canEdit(row: Int) -> Bool
    //    func titleForDeleteButton(row: Int) -> String
    //    func deleteButtonPressed(row: Int)
    //    func addButtonPressed()
    
    
    
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
            cell.display(image : news.image )
        }
    }
    
    
    
    func getNews() {
        newsModel.fetchNews { result in
            switch result {
            case let .success(listNews):
                self.news = listNews
                self.view.refreshBooksView()
            case let .failure(_):
                print("")
                
            }
        }
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
