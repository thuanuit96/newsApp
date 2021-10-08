//
//  ApiClient.swift
//  NewsApp
//
//  Created by VN01-MAC-0006 on 24/09/2021.
//


import Foundation

protocol ApiRequest {
    var urlRequest: URLRequest { get }
}

protocol ApiClient {
    func execute<T>(request: ApiRequest, completionHandler: @escaping (_ result: Result<T>) -> Void)
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

class ApiClientImplementation: ApiClient {
    let urlSession: URLSessionProtocol
    init(urlSessionConfiguration: URLSessionConfiguration, completionHandlerQueue: OperationQueue) {
        urlSession = URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: completionHandlerQueue)
    }
    
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    // MARK: - ApiClient
    
    func execute<T>(request: ApiRequest, completionHandler: @escaping (Result<T>) -> Void) {
        
        let dataTask = urlSession.dataTask(with: request.urlRequest) { (data, response, error) in
            guard let httpUrlResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(NetworkRequestError(error: error)))
                return
            }
            let successRange = 200...299
            if successRange.contains(httpUrlResponse.statusCode) {
                completionHandler(.success((data, response) as! T))
            } else {
                completionHandler(.failure(ApiError(data: data, httpUrlResponse: httpUrlResponse)))
            }
        }
        dataTask.resume()
    }
}
