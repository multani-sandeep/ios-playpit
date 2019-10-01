//
//  ViewController.swift
//  Test
//
//  Created by Sandeep Singh on 01/10/2019.
//  Copyright © 2019 Sandeep Singh. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController , WKNavigationDelegate {

    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // 1
        let url = URL(string: "https://www.google.com")!
        webView.load(URLRequest(url: url))
       
        // 2
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
       
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Test %s", webView)
        title = webView.title
    }

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

}
