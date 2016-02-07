//
//  FeedViewController.swift
//  GoogleRSS
//
//  Created by Jamal Jones on 2/6/16.
//  Copyright © 2016 Jamal Jones. All rights reserved.
//

import UIKit
import Haneke

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate {
    
    var xmlParser = XMLParser()
//    let cache = NSCache()
    var currentDictionary = [String: String]()
    let cache = Cache<NSDictionary>(name: "cachedDictionary")
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if let url = NSURL(string: "http://news.google.com/news?cf=all&hl=en&pz=1&ned=us&output=rss") {
            xmlParser = XMLParser()
            xmlParser.delegate = self
            xmlParser.startParsingWithContentsOfURL(url)
        }
        
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedCell", forIndexPath: indexPath) as! FeedCell
        
        if !xmlParser.arrParsedData.isEmpty {
        
            currentDictionary = xmlParser.arrParsedData[indexPath.row] as Dictionary<String, String>
            cache.set(value: currentDictionary, key: "cachedDictionary")
            
        } else {
            // create it from scratch then store in the cache
            
            cache.fetch(key: "cachedDictionary").onSuccess { currentDict in
                self.currentDictionary = currentDict as! [String : String]
            }
            
        }
        
        
        
        cell.title.text = currentDictionary["title"]
                
        let descString: NSString = (currentDictionary["description"])! as NSString
        var descArr = descString.componentsSeparatedByString("font size=")
        let index = descArr[3].startIndex.advancedBy(5)
        let description = descArr[3].substringFromIndex(index)
        cell.content.text = description
        
        let imgArr1 = descString.componentsSeparatedByString("img src=\"//")
        let imgArr2 = imgArr1[1].componentsSeparatedByString("\"")
        let imgURL: NSURL = NSURL(string: imgArr2[0])!
        print(imgArr2[0])
        
        if let data = NSData(contentsOfURL: imgURL) {
            cell.thumbnail.image = UIImage(data: data)
        }
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let currentDictionary = xmlParser.arrParsedData[indexPath.row] as Dictionary<String, String>
        
        let urlString: NSString = (currentDictionary["link"])! as NSString
        
        var urlArr = urlString.componentsSeparatedByString("url=")
        
        let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController
        
        contentViewController.contentURL = NSURL(string: urlArr[1] as String)
        
        showDetailViewController(contentViewController, sender: self)
    }

}
