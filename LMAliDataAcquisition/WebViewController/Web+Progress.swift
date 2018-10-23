//
//  Web+Progress.swift
//  LMAliDataAcquisition
//
//  Created by Tim on 2018/10/19.
//  Copyright © 2018年 Tim Lin. All rights reserved.
//

import UIKit

extension LMWebviewController {
    
    func addProgressView() {
        if showProgressView {
            addWebProgressObserver()
            view.addSubview(progressView)
            progressView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 2)
        }
    }
    
    func addWebProgressObserver() {
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    func removeWebProgressObserver() {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        if showProgressView {
            progressView.reloadInputViews()
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            progressView.isHidden = webView.estimatedProgress == 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
}
