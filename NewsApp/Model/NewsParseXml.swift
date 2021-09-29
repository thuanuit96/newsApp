//
//  NewsParse.swift
//  NewsApp
//
//  Created by VN01-MAC-0006 on 24/09/2021.
//

import UIKit
import Foundation
protocol  NewsParse {
    func parseNews(data : Data, completionHandler: @escaping ((Result<[News]>) -> Void))
}

class NewsParseXmlImplement: NSObject, NewsParse,XMLParserDelegate
{
   
    private var parserCompletionHandler: ((Result<[News]>) -> Void)?
    private var rssItems: [News] = []
    
    private var currentElement = ""
    private var currentTitle: String = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentLink: String = "" {
        didSet {
            currentLink = currentLink.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentDescription: String = "" {
        didSet {
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentPubDate: String = "" {
        didSet {
            currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    func parseNews(data: Data, completionHandler: @escaping ((Result<[News]>) -> Void)) {
        parserCompletionHandler  = completionHandler
               let parser = XMLParser(data: data)
               parser.delegate = self
                          parser.parse()
    }
    
    // MARK: - XML Parser Delegate
    
    // 4
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        // we assign the name of the element to currentElement, if the item tag is found, we reset the temporary variables of title, description and pubdate for later use
        currentElement = elementName
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
            currentLink = ""
        }
    }
    
    // 5 - when the value of an element is found, this method gets called with a string representation of part of the characters of the current element
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title": currentTitle += string
        case "link": currentLink += string
        case "description" :
            currentDescription += string
        case "pubDate": currentPubDate += string
        default: break
        }
    }
    
    // 6 - when we reach the closing tag /item is found, this method gets called
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if elementName == "item" {
            let imgURL = matches(for: "(http[^\\s]+(jpg|jpeg|png|tiff)\\b)", in: String(currentDescription))[0]
            

            let rssItem = News(title: currentTitle, description: currentDescription.withoutHtml, pubDate: currentPubDate,imgURL: imgURL,link: currentLink)
            rssItems += [rssItem]
        }
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        
        parserCompletionHandler!(.success(rssItems))
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        
        parserCompletionHandler!(.failure(parseError))

        
    }
    
    func matches(for regex: String!, in text: String!) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSMakeRange(0, nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    
    
}
extension String {
    public var withoutHtml: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }

        return attributedString.string
    }
}
