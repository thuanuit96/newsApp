//
//  NewsApiRequest.swift
//  NewsApp
//
//  Created by VN01-MAC-0006 on 24/09/2021.
//

import Foundation
struct NewsApiRequest: ApiRequest {
    var urlRequest: URLRequest {
        let url: URL! = URL(string: "https://tuoitre.vn/rss/thoi-su.rss")
        var request = URLRequest(url: url)
//
////        request.setValue("application/vnd.fortech.books-list+json", forHTTPHeaderField: "Accept")
//
//        request.httpMethod = "GET"
        
        return request
    }
}
