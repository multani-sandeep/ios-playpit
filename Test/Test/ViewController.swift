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
        let loginurl = URL(string: "http://contact-centre-test3.project4.com/dashboard/security")!
        
        webView.load(URLRequest(url: loginurl))
        
        
        // 2
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let home = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(self.loadHome(_:)))
        toolbarItems = [refresh, home]
        navigationController?.isToolbarHidden = false
       
    }
    
    @objc func loadHome(_ sender:UIBarButtonItem!){
        print("myLeftSideBarButtonItemTapped")
        let homeurlreq = URLRequest(url: URL(string: "http://contact-centre-test3.project4.com")!)
        webView.load(homeurlreq)
    }

        
    
    
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //print("Test %s", webView)
        title = webView.title
    }

    override func loadView() {
        let contentController = WKUserContentController()
        
        let scriptSource = """
            function lookupBarcode() {
                try {
                        webkit.messageHandlers.lookupBarcode.postMessage(
                            {
                                messageTxt: "Hello"
                            });
                        document.body.style.background = "green";
                    } catch(err) {
                        document.body.style.background = "red";
                    }
                }
            //document.getElementById('mobileSearch').onclick(lookupBarcode);
        """
        let script = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        contentController.addUserScript(script)
        
        contentController.add(self, name: "lookupBarcode")
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        webView = WKWebView(frame: .zero, configuration: config)
        //webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
}

extension ViewController:WKScriptMessageHandler {
    func userContentController(
        _ userContentController:
        WKUserContentController,
        didReceive message: WKScriptMessage) {
        if message.name == "lookupBarcode",
        let dict = message.body as? NSDictionary {
        lookupBarcode(dict: dict)
        }
    }
    
    func lookupBarcode(dict: NSDictionary) {
        print("Message: %s", dict["messageTxt"])
    }
}

