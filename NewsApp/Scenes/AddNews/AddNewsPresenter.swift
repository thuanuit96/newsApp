

import Foundation


protocol AddNewsView: AnyObject {
    func setUp()
    func displayAddBookError(title: String, message: String)
    func dismiss()
}
protocol AddNewsPresenterDelegate: AnyObject {
    func addBookPresenter(_ presenter: AddNewsPresenter, didAdd news: News)
    func addBookPresenterCancel(presenter: AddNewsPresenter)
}

protocol AddNewsPresenter {
    var maximumReleaseDate: Date { get }
    var router: AddNewsViewRouter { get }

    func addButtonPressed(parameters: AddNewsParameter)
    func cancelButtonPressed()
    func setUp()
    func dismiss()
}

class AddNewsPresenterImplementation: AddNewsPresenter {
    
    
    fileprivate weak var view: AddNewsView?
    fileprivate weak var delegate: AddNewsPresenterDelegate?
    var router: AddNewsViewRouter
    
    var maximumReleaseDate: Date {
        return Date()
    }
    
    init(view: AddNewsView,
         delegate: AddNewsPresenterDelegate?,router : AddNewsViewRouter) {
        self.view = view
        self.delegate = delegate
        self.router = router
    }
    
//    
    func setUp() {
        self.view?.setUp()
    }

    
    func addButtonPressed(parameters: AddNewsParameter) {
        let dateFormatter = DateFormatter()
        let pubDateString = dateFormatter.string(from: parameters.publicDate!)
        let news = News(title: parameters.title, description: parameters.content, pubDate: pubDateString , imgURL: parameters.imgURL, link: parameters.link, state: .new, imageData: Data())
        self.handleNewsAdded(news)
        
    }
    
    func cancelButtonPressed() {
        delegate?.addBookPresenterCancel(presenter: self)
    }
    func dismiss() {
        self.view?.dismiss()
    }
    
    // MARK: - Private
    
    fileprivate func handleNewsAdded(_ news: News) {
        delegate?.addBookPresenter(self, didAdd: news)
    }
    
    fileprivate func handleAddNewsError(_ error: Error) {
        // Here we could check the error code and display a localized error message
        view?.displayAddBookError(title: "Error", message: error.localizedDescription)
    }
    
}
