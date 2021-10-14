//
//  NewsParseJson.swift
//  NewsApp
//
//  Created by VN01-MAC-0006 on 29/09/2021.
//

import Foundation

class NewsParseJson: NSObject, NewsParse {
    
    func parseNews(data: Data, completionHandler: @escaping ((Result<[News]>) -> Void)) {
        let decoder = JSONDecoder()
        do {
            let reponseData = try decoder.decode(ResponseData.self, from: data)
            completionHandler(.success(reponseData.listNews))
        } catch {
            completionHandler(.failure(NSError.createPraseError()))
        }
      
    }
}
