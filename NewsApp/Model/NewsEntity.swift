//
//  NewsEntity.swift
//  NewsApp
//
//  Created by VN01-MAC-0006 on 24/09/2021.
//

import Foundation
import UIKit

enum PhotoState {
  case new, downloaded, failed
}

struct  News {
    var title = ""
    var description = ""
    var pubDate = ""
    var imgURL = ""
    var link = ""
    var state = PhotoState.new
    var image = UIImage()
}



