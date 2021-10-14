//
//  NewsParseJsonTest.swift
//  NewsAppTests
//
//  Created by VN01-MAC-0006 on 12/10/2021.
//

import XCTest
@testable import NewsApp

class NewsParseJsonTest: XCTestCase {
    
    let newsParseJson  = NewsParseJson()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }
    
    func test_parse_data_success() {
        
        let listNews = FakeData.createNewsArray()
        
        let reponseData = ResponseData(listNews: listNews)
        let jsonEndcode = JSONEncoder()
        
        let expectedResult  : Result<[News]> = .success(listNews)
        
        let parseDataCompletionHandlerExpectation = expectation(description: "Parse data completion handler expectation")

        do {
            let data = try  jsonEndcode.encode(reponseData)
            newsParseJson.parseNews(data: data) { result in
                XCTAssertTrue(result == expectedResult, "The expected result wasn't returned")
            }
            parseDataCompletionHandlerExpectation.fulfill()
            
        } catch  {
            XCTFail("endcode  data test fail")
        }
        waitForExpectations(timeout: 1, handler: nil)

    }
    
    func test_parse_data_fail() {
        
        let listNews = FakeData.createNewsArray()
        
        let jsonEndcode = JSONEncoder()
        
        let expectedResult  : Result<[News]> = .failure(NSError.createPraseError())
        do {
            let data = try  jsonEndcode.encode(listNews)
            newsParseJson.parseNews(data: data) { result in
                print(result)
                XCTAssertTrue(result == expectedResult, "The expected result wasn't returned")
            }
        } catch  {
            XCTFail("endcode  data test fail")
        }
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
