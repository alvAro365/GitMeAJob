//
//  WebViewController.swift
//  GitMeAJob
//
//  Created by lösen är 0000 on 2018-04-17.
//  Copyright © 2018 Alvar Aronija. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    var stringUrl: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        let urlRequest = URLRequest(url: stringUrl)
        webView.load(urlRequest)
    }
    
    // Navigation delegate methods
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
    }

}
