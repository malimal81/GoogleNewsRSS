//
//  XMLParser.swift
//  GoogleRSS
//
//  Created by Jamal Jones on 2/6/16.
//  Copyright © 2016 Jamal Jones. All rights reserved.
//

import UIKit

class XMLParser: NSObject, NSXMLParserDelegate {

    var arrParsedData = [Dictionary<String, String>]()
    
    var currentDataDictionary = Dictionary<String, String>()
    
    var currentElement = ""
    
    var foundCharacters = ""
    
    var delegate : NSXMLParserDelegate?
    
    func startParsingWithContentsOfURL(rssURL: NSURL) {
        if let parser = NSXMLParser(contentsOfURL: rssURL) {
            parser.delegate = self
            parser.parse()
        }
    }
    
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentElement = elementName
        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if !foundCharacters.isEmpty {
            
            if elementName == "link"{
                foundCharacters = (foundCharacters as NSString).substringFromIndex(3)
            }
            
            currentDataDictionary[currentElement] = foundCharacters
            
            foundCharacters = ""
            
            if currentElement == "description" {
                arrParsedData.append(currentDataDictionary)
            }
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        foundCharacters += string
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print(parseError.description)
    }
    
    func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
        print(validationError.description)
    }

}
