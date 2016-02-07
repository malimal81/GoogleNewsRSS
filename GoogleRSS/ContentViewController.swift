//
//  ContentViewController.swift
//  GoogleRSS
//
//  Created by Jamal Jones on 2/6/16.
//  Copyright © 2016 Jamal Jones. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    var contentURL : NSURL!
    
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        contentURL = NSURL(string: "https://www.google.com/")
        
        if contentURL != nil {
            let request : NSURLRequest = NSURLRequest(URL: contentURL)
            webView.loadRequest(request)
        }
        
        
    }

    

}
