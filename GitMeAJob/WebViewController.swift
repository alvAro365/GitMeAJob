//
//  WebViewController.swift
//  GitMeAJob
//
//  Created by lösen är 0000 on 2018-04-17.
//  Copyright © 2018 Alvar Aronija. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    var stringUrl: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stringUrl = "https://github.com"
        webView.allowsBackForwardNavigationGestures = true
        if let url = URL(string: stringUrl){
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
    }

}
