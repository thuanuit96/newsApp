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
        
        // Normally to mock JSON responses you should use a Dictionary and convert it to JSON using JSONSerialization.data
        // In our example here we don't care about the actual JSON, we care about the data regardless of its format it would have
        let expectedUtf8StringResponse = "{\"SomeProperty\":\"SomeValue\"}"
        let expectedData = expectedUtf8StringResponse.data(using: .utf8)
        let expected2xxReponse = HTTPURLResponse(statusCode: 200)
        
        urlSessionStub.enqueue(response: (data: expectedData, response: expected2xxReponse, error: nil))
        
        let executeCompletionHandlerExpectation = expectation(description: "Add book completion handler expectation")
        
        // When
        apiClient.execute(request: NewsApiRequest()) { (result : Result<URLSessionCompletionHandlerResponse>)  in
            
            // Then
            guard let response = try? result.get() else {
                XCTFail("A successfull response should've been returned")
                return
            }
            
            
            print("response :\(response)")
//
//            XCTAssertEqual(expectedUtf8StringResponse, response.entity.utf8String, "The string is not the expected one")
//            XCTAssertTrue(expected2xxReponse === response.httpUrlResponse, "The http response is not the expected one")
//            XCTAssertEqual(expectedData?.base64EncodedString(), response.data?.base64EncodedString(), "Data doesn't match")
            
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
