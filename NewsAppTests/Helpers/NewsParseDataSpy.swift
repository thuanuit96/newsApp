//
//  NewsParseDataSpy.swift
//  NewsAppTests
//
//  Created by VN01-MAC-0006 on 07/10/2021.
//

import Foundation
@testable import NewsApp


class NewsParseDataSpy: NewsParse {
    var resultToBeReturned: Result<[News]>!

    func parseNews(data: Data, completionHandler: @escaping ((Result<[News]>) -> Void)) {
        completionHandler(resultToBeReturned)
    }
}
