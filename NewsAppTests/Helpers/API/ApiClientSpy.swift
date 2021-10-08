//
//  ApiClientSpy.swift
//  NewsAppTests
//
//  Created by VN01-MAC-0006 on 07/10/2021.
//

import Foundation
@testable import NewsApp


class ApiClientSpy: ApiClient {
    var resultToBeReturned: Result<Data>!
    func execute<T>(request: ApiRequest, completionHandler: @escaping (Result<T>) -> Void) {
        completionHandler(resultToBeReturned as! Result<T>)
    }
    
}
