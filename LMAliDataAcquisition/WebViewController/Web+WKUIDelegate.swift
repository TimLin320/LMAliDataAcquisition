//
//  Web+WKNavigationDeleg.swift
//  LMAliDataAcquisition
//
//  Created by Tim on 2018/10/19.
//  Copyright © 2018年 Tim Lin. All rights reserved.
//

import UIKit
import WebKit

extension LMWebviewController: WKUIDelegate {
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        let alert = UIAlertController.init(title: "提示", message: message, preferredStyle: .alert)
        let confirm = UIAlertAction.init(title: "确认", style: .default) { (action) in
            completionHandler()
        }
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
        let alert = UIAlertController.init(title: prompt, message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = defaultText
        }
        let confirm = UIAlertAction.init(title: "完成", style: .default) { (action) in
            completionHandler(alert.textFields?.first?.text)
        }
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        } else if !(navigationAction.targetFrame?.isMainFrame)! {
            webView.load(navigationAction.request)
        }
        
        return nil
    }
}
