
//
//  NewsPresenter.swift
//  NewsApp
//
//  Created by VN01-MAC-0006 on 24/09/2021.
//
import Foundation
import UIKit

class PendingOperations {
  lazy var downloadsInProgress: [IndexPath: Operation] = [:]
  lazy var downloadQueue: OperationQueue = {
    var queue = OperationQueue()
    queue.name = "Download queue"
    queue.maxConcurrentOperationCount = 1
    return queue
  }()
}

class ImageDownloader: Operation {
  //1
  var newsRecord: News
  
  //2
  init(_ newsRecord: News) {
    self.newsRecord = newsRecord
  }
  
  //3
  override func main() {
    //4
    if isCancelled {
      return
    }
    
    //5
    
    guard  let urlImagePath = URL(string: newsRecord.imgURL) else {
        print("URL path wrong")
        newsRecord.state = .failed
        return
    }
    
    guard let imageData = try? Data(contentsOf: urlImagePath ) else {
        
        print("Cannot get Image : \(newsRecord.imgURL)")
        
        newsRecord.state = .failed
        return
    }
    
    //6
    if isCancelled {
      return
    }
    
    //7
    if !imageData.isEmpty {
        newsRecord.imageData = imageData
        newsRecord.state = .downloaded
    } else {
        newsRecord.state = .failed
    }
  }


}
