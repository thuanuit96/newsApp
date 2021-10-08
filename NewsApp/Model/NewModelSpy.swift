//
//  NewModelSpy.swift
//  NewsApp
//
//  Created by VN01-MAC-0006 on 29/09/2021.
//

import Foundation

class NewsModelSpy: NewsModel {
    var apiClient : ApiClient
    var newsParse : NewsParse = NewsParseJson()
    var newsRequest : ApiRequest
    
    init(apiClient : ApiClient, newsRequest : ApiRequest ) {
        self.apiClient = apiClient
        self.newsRequest = newsRequest
    }
    
    func fetchNews(completionHandler :@escaping (Result<[News]>) -> Void) {
        if let url = Bundle.main.url(forResource: "data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                self.newsParse.parseNews(data: data) { resultParse in
                    switch resultParse {
                    case let .success(listNews):
                        print("Data :\(  listNews[0])")
                        completionHandler(.success(listNews))
                        
                    case let .failure(error):
                        print("error when parse data :\(error)")
                        completionHandler(.failure(error))
                        
                    }
                }
            } catch {
                print("error:\(error)")
            }
        }
    }
    
    
}
