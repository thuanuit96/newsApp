//
//  NewsModelTest.swift
//  NewsAppTests
//
//  Created by VN01-MAC-0006 on 07/10/2021.
//

import XCTest
@testable import NewsApp

class NewsModelTest: XCTestCase {
    
    let apiClientSpy  = ApiClientSpy()
    var newsModel: NewsModel!
    let newsRequest =  NewsApiRequest()
    let newParseDataSpy = NewsParseDataSpy()
    
    var apiClient : ApiClientImplementation!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
        apiClient =  ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default,
                                                completionHandlerQueue: OperationQueue.main)
        newsModel = NewsModelImplementation(apiClient: apiClient, newsRequest: newsRequest, newParse: newParseDataSpy)
        
    }
    
    func test_fetchNews_api_success () {
        // Given
        let newsToReturn = FakeData.createNewsArray()
        let expectedResultToBeReturned: Result<[News]> = .success(newsToReturn)
        apiClientSpy.resultToBeReturned = .success(ApiResponse(data: Data(), httpUrlResponse: HTTPURLResponse(statusCode: 200)))
        newParseDataSpy.resultToBeReturned = expectedResultToBeReturned
        let fetchNewsCompletionHandlerExpectation = expectation(description: "Fetch news completion handler expectation")
        // When
        newsModel.fetchNews { (result) in
            

            // Then
            XCTAssertTrue(expectedResultToBeReturned == result, "The expected result wasn't returned")
            fetchNewsCompletionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_fetchNews_api_fail () {
        // Given
        let expectedResultToBeReturned: Result<[News]> = .failure(NSError.createError(withMessage: "Any message"))
        apiClientSpy.resultToBeReturned = .failure(NSError.createError(withMessage: "Any message"))
            newParseDataSpy.resultToBeReturned = expectedResultToBeReturned
        let fetchNewsCompletionHandlerExpectation = expectation(description: "Fetch news completion handler expectation")
        // When
        newsModel.fetchNews { (result) in
            // Then
            XCTAssertTrue(expectedResultToBeReturned == result, "The expected result wasn't returned")
            fetchNewsCompletionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    
    
    
  
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
