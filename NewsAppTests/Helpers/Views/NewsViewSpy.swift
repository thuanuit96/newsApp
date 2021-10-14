//
//  NewsViewSpy.swift
//  NewsAppTests
//
//  Created by VN01-MAC-0006 on 06/10/2021.
//

import Foundation
@testable import NewsApp
class  NewsViewSpy : NewsView {
    
    
    
    var refreshNewsViewCalled = false
    var displayRetrievalErrorTitle = ""
    var displayRetrievalErrorMessage = ""
    var passedNews : News!

    
    func refreshNewsView() {
        refreshNewsViewCalled = true
    }
    
    func reloadRow(at indexPath: IndexPath) {
        
    }
    
    func showDetailView(news: News) {
        passedNews = news
    }
    func displayNewsRetrievalError(title: String, message: String) {
        displayRetrievalErrorTitle =  title
        displayRetrievalErrorMessage = message
        
    }
    
    
}
