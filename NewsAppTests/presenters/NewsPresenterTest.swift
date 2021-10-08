//
//  NewsPresenterTest.swift
//  NewsAppTests
//
//  Created by VN01-MAC-0006 on 06/10/2021.
//

import XCTest
@testable import NewsApp


class NewsPresenterTest: XCTestCase {
    
    let newsModelStub = NewsModelStub()
    let newsViewSpy = NewsViewSpy()
    var newsPresenter: NewsPresenter!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        newsPresenter = NewsPresenterImplementation(newsModel: newsModelStub, newsView: newsViewSpy)
        
    }
    
    // MARK: - Tests
    
    func test_getNews_success_refreshNewsView_called() {
        // Given
        let newsToBeReturned = FakeData.createNewsArray()
        newsModelStub.resultToBeReturned = .success(newsToBeReturned)
        
        // When
        newsPresenter.getNews()
        
        // Then
        XCTAssertTrue(newsViewSpy.refreshNewsViewCalled, "refreshNewsView was not called")
    }
    
    func test_getNews_success_numberOfNews() {
        // Given
        let expectedNumberOfNews = 5
        let newsToBeReturned = FakeData.createNewsArray(numberOfElements: expectedNumberOfNews)
        newsModelStub.resultToBeReturned = .success(newsToBeReturned)
        // When
        newsPresenter.getNews()
        // Then
        XCTAssertEqual(expectedNumberOfNews, newsPresenter.numberOfNews, "Number of news mismatch")
    }
    
    
    func test_getNews_failure_displayRetrievalError() {
        // Given
        let expectedErrorTitle = "Error"
        let expectedErrorMessage = "Some error message"
        let errorToBeReturned = NSError.createError(withMessage: expectedErrorMessage)
        newsModelStub.resultToBeReturned = .failure(errorToBeReturned)
        
        // When
        newsPresenter.getNews()
        
        // Then
        XCTAssertEqual(expectedErrorTitle, newsViewSpy.displayRetrievalErrorTitle, "Error title doesn't match")
        XCTAssertEqual(expectedErrorMessage, newsViewSpy.displayRetrievalErrorMessage, "Error message doesn't match")
    }
    
    
    func test_configCell() {
        // Given
        let rowToConfigure = 1
        newsPresenter.news = FakeData.createNewsArray()
        let expectedTitle = "title 1"
        let expectedDescription = "description 1"
        let expectedPubDate = ""
        
        let newsCellViewSpy = NewsCellViewSpy()
        
        // When
        newsPresenter.configure(cell: newsCellViewSpy, forRow: IndexPath(row: rowToConfigure, section: 0))
        
        // Then
        XCTAssertEqual(expectedTitle, newsCellViewSpy.displayedTitle, "The title we expected was not displayed")
        XCTAssertEqual(expectedDescription, newsCellViewSpy.displayedContent, "The des we expected was not displayed")
        XCTAssertEqual(expectedPubDate, newsCellViewSpy.displayedPublicDate, "The date we expected was not displayed")
    }
    
    func test_didSelect_navigates_to_details_view() {
        // Given
        let listNews =  FakeData.createNewsArray()
        let rowToSelect = 1
        newsPresenter.news = listNews
        
        // When
        newsPresenter.didSelect(row: rowToSelect)
        
        // Then
        XCTAssertEqual(newsPresenter.news[rowToSelect], newsViewSpy.passedNews, "Expected navigate to details view to be called with news at index 1")
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
