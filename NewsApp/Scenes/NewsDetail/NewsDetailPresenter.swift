//
//  NewsDetailPresenter.swift
//  NewsApp
//
//  Created by VN01-MAC-0006 on 28/09/2021.
//


protocol NewsDetailView {
    func showNewsDetails(for news: News )
   
}

protocol NewsDetailPresenter {
    
    func showNewsDetails()

}
class NewsDetailsPresenterImplementation: NewsDetailPresenter {
    var news : News
    let view : NewsDetailView
    init(view : NewsDetailView ,news : News) {
        self.view = view
        self.news = news
    }
    
    func showNewsDetails() {
        self.view.showNewsDetails(for: news)
    }
    
}

