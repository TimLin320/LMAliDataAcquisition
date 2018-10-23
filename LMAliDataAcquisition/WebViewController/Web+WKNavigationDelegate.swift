//
//  Web+WKNavigationDelegate.swift
//  LMAliDataAcquisition
//
//  Created by Tim on 2018/10/19.
//  Copyright © 2018年 Tim Lin. All rights reserved.
//

import UIKit
import WebKit

extension LMWebviewController : WKNavigationDelegate {
    
    @objc func setWebTitle() {
        title = webStaticTitle ?? webView.title
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        setWebTitle()
        if showProgressView {
            progressView.isHidden = true
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(WKNavigationActionPolicy.allow)
    }
}
