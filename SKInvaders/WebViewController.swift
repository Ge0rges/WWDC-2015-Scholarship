//
//  WebViewController.swift
//  GeorgesKanaan
//
//  Created by Dani Arnaout on 4/18/15.
//  Copyright (c) 2015 Georges Kanaan, LLC. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

  @IBOutlet weak var webView: UIWebView!
  var url:String!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
    }
  
  
  @IBAction func didTapCancel(sender: AnyObject) {
    dismissViewControllerAnimated(false, completion: nil)
  }
    
}