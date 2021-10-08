//
//  SearchModel.swift
//  NewsApp
//
//  Created by VN01-MAC-0006 on 24/09/2021.
//

import Foundation

typealias Result<T> = Swift.Result<T, Error>
protocol NewsModel: AnyObject {
    func fetchNews(completionHandler :@escaping (Result<[News]>) -> Void)
}

class NewsModelImplementation: NewsModel {
    var apiClient : ApiClient
    var newsParse : NewsParse

    var newsRequest : ApiRequest
    
    init(apiClient : ApiClient, newsRequest : ApiRequest  , newParse : NewsParse) {
        self.apiClient = apiClient
        self.newsRequest = newsRequest
        self.newsParse = newParse
    }
    func fetchNews(completionHandler :@escaping (Result<[News]>) -> Void) {
        apiClient.execute(request:newsRequest) { (result: Result<Data>)  in
            switch result {
            case let .success(data):
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
            case let .failure(error):
                completionHandler(.failure(error))
            }
            
        }
    }
    
    
}


