//
//  ApiClientTest.swift
//  NewsAppTests
//
//  Created by VN01-MAC-0006 on 07/10/2021.
//

import XCTest
@testable import NewsApp

class ApiClientTest: XCTestCase {
    typealias URLSessionCompletionHandlerResponse = (data: Data?, response: URLResponse?, error: Error?)

    let urlSessionStub = URLSessionStub()
    var apiClient: ApiClientImplementation!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        apiClient = ApiClientImplementation(urlSession: urlSessionStub)

    }
    
    func test_execute_successful_http_response_parses_ok() {
        // Given
        let expectedUtf8StringResponse = "{\"SomeProperty\":\"SomeValue\"}"
        let expectedData = expectedUtf8StringResponse.data(using: .utf8)
        let expected2xxReponse = HTTPURLResponse(statusCode: 200)
        
        urlSessionStub.enqueue(response: (data: expectedData, response: expected2xxReponse, error: nil))
        
        let executeCompletionHandlerExpectation = expectation(description: "Add book completion handler expectation")
        
        // When
        apiClient.execute(request: NewsApiRequest()) { (result : Result<ApiResponse>)  in
            
            // Then
            guard let response = try? result.get() else {
                XCTFail("A successfull response should've been returned")
                return
            }
            XCTAssertEqual(expectedData?.base64EncodedString(), response.data?.base64EncodedString(), "Data doesn't match")
            XCTAssertTrue(expected2xxReponse === response.httpUrlResponse, "The http response is not the expected one")
            executeCompletionHandlerExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)

    }
    
    func test_execute_non_2xx_response_code() {
        let expectedUtf8StringResponse = "{ \"SomeProperty\" : \"SomeValue\" }"
        let expectedData = expectedUtf8StringResponse.data(using: .utf8)
        let expected4xxReponse = HTTPURLResponse(statusCode: 400)
        
        urlSessionStub.enqueue(response: (data: expectedData, response: expected4xxReponse, error: nil))
        
        let executeCompletionHandlerExpectation = expectation(description: "completion handler expectation")
        
        // When
        apiClient.execute(request: NewsApiRequest()) { (result: Result<ApiResponse>) in
            // Then
            do {
                let _ = try result.get()
                XCTFail("Expected api error to be thrown")
            } catch let error as ApiError {
                XCTAssertTrue(expected4xxReponse === error.httpUrlResponse, "The http response is not the expected one")
                XCTAssertEqual(expectedData?.base64EncodedString(), error.data?.base64EncodedString(), "Data doesn't match")
            } catch {
                XCTFail("Expected api error to be thrown")
            }
            
            executeCompletionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_execute_error_no_httpurlresponse() {
        // Given
        let expectedErrorMessage = "Some random network error"
        let expectedError = NSError.createError(withMessage: expectedErrorMessage)
        
        urlSessionStub.enqueue(response: (data: nil, response: nil, error: expectedError))
        
        let executeCompletionHandlerExpectation = expectation(description: "Add book completion handler expectation")
        
        
        // When
        apiClient.execute(request: NewsApiRequest()) { (result:Result<ApiResponse>) in
            // Then
            do {
                let _ = try result.get()
                XCTFail("Expected network error to be thrown")
            } catch let error as NetworkRequestError {
                XCTAssertEqual(expectedErrorMessage, error.localizedDescription, "Error message doesn't match")
            } catch {
                XCTFail("Expected network error to be thrown")
            }
            
            executeCompletionHandlerExpectation.fulfill()
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
