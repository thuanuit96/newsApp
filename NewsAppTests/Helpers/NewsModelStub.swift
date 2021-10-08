//
//  NewsModelSpy.swift
//  NewsAppTests
//
//  Created by VN01-MAC-0006 on 06/10/2021.
//

import Foundation
@testable import NewsApp
  
class  NewsModelStub: NewsModel {
    
    var resultToBeReturned: Result<[News]>!
    func fetchNews(completionHandler: @escaping (Result<[News]>) -> Void) {
        completionHandler(resultToBeReturned)
    }
    
    
}
