//
//  ApiReponse.swift
//  NewsApp
//
//  Created by VN01-MAC-0006 on 24/09/2021.
//


import Foundation

// Can be thrown when we can't even reach the API
struct NetworkRequestError: Error {
    let error: Error?
    
    var localizedDescription: String {
        return error?.localizedDescription ?? "Network request error - no other information"
    }
}

// Can be thrown when we reach the API but the it returns a 4xx or a 5xx
struct ApiError: Error {
    let data: Data?
    let httpUrlResponse: HTTPURLResponse
}

// Can be thrown by InitializableWithData.init(data: Data?) implementations when parsing the data
struct ApiParseError: Error {
    static let code = 999
    
    let error: Error
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    var localizedDescription: String {
        return error.localizedDescription
    }
}

struct ApiResponse {
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    init(data: Data?, httpUrlResponse: HTTPURLResponse) {
        self.httpUrlResponse = httpUrlResponse
        self.data = data
    }
}

// Some endpoints might return a 204 No Content
struct VoidResponse: Decodable { }

extension NSError {
    static func createPraseError() -> NSError {
        return NSError(domain: "com.fortech.library",
                       code: ApiParseError.code,
                       userInfo: [NSLocalizedDescriptionKey: "A parsing error occured"])
    }
}
