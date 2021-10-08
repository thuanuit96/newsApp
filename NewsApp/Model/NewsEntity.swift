//
//  NewsEntity.swift
//  NewsApp
//
//  Created by VN01-MAC-0006 on 24/09/2021.
//

import Foundation

enum PhotoState : String ,Codable  {
    case new, downloaded, failed
}


struct ResponseData: Codable {
    var listNews: [News]
    enum CodingKeys:String,CodingKey {
        case listNews = "item"
    }
}

struct  News : Codable{
    var title = ""
    var description = ""
    var pubDate = ""
    var imgURL = ""
    var link = ""
    var state = PhotoState.new
    var imageData = Data()
    
    enum CodingKeys:String,CodingKey {
        case title
        case description
        case pubDate
        case imgURL
        case link
        case state
        case imageData
    }
    
    init(title : String ,
         description : String,
         pubDate : String ,
         imgURL : String  ,
         link : String ,
         state : PhotoState,
         imageData : Data) {
        self.title = title
        self.description = description
        self.pubDate = pubDate
        self.imgURL = imgURL
        self.link = link
        self.state = state
        self.imageData = imageData
    }
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.pubDate = try container.decodeIfPresent(String.self, forKey: .pubDate) ?? ""
        self.imgURL = try container.decodeIfPresent(String.self, forKey: .imgURL) ?? ""
        self.link = try container.decodeIfPresent(String.self, forKey: .link) ?? ""
        self.state = try container.decodeIfPresent(PhotoState.self, forKey: .state) ?? .new
        self.imageData = try container.decodeIfPresent(Data.self, forKey: .imageData) ?? Data()
    }
}

extension News: Equatable { }

//func == (lhs: News, rhs: News) -> Bool {
//    return lhs.id == rhs.id
//}
