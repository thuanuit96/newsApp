//
//  NewsCellViewSpy.swift
//  NewsAppTests
//
//  Created by VN01-MAC-0006 on 06/10/2021.
//

import Foundation
@testable import NewsApp


class NewsCellViewSpy : NewsCellView {
    var displayedTitle = ""
    var displayedContent = ""
    var displayedPublicDate = ""
    var displayedImage = Data()

    
    func display(title: String) {
        displayedTitle = title

    }
    
    func display(content: String) {
        displayedContent = content
    }
    
    func display(publicDate: String) {
        displayedPublicDate = publicDate
    }
    
    func display(image: Data) {
        displayedImage = image
    }
    
    
}
