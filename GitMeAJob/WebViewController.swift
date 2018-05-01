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
    var stringUrl: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.allowsBackForwardNavigationGestures = true
        let urlRequest = URLRequest(url: stringUrl)
        webView.load(urlRequest)
    }

}
