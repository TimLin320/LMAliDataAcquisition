//
//  Web+NavigationDeleg.swift
//  LMAliDataAcquisition
//
//  Created by Tim on 2018/10/19.
//  Copyright © 2018年 Tim Lin. All rights reserved.
//

import UIKit
import WebKit

extension LMWebviewController {
    
    func removeAllMessage() {
        for method in messageList {
            webView.configuration.userContentController.removeScriptMessageHandler(forName: method)
        }
    }
    
    @objc func didReceive(message: WKScriptMessage) {
        if message.name == goBack {
            navigationController?.popToRootViewController(animated: true)
        } else if message.name == openLogin {
            // 提示登录弹框
            
        }
    }
}
