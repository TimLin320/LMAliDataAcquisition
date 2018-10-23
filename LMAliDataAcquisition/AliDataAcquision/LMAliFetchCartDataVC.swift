//
//  LMAliFetchCartDataVC.swift
//  LMAliDataAcquisition
//
//  Created by Tim on 2018/10/19.
//  Copyright © 2018年 Tim Lin. All rights reserved.
//
//  淘宝购物车页面
//

import UIKit
import WebKit

class LMAliFetchCartDataVC: LMAliFetchDataVC {
    
    override func callbackMessageName() -> String { return "" }
    override func fetchDataJSFileName() -> String { return "fetchAliCartData" }
    
    override func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        setWebTitle()
        if showProgressView {
            progressView.isHidden = true
        }
        
        weak var weakSelf = self
        webView.evaluateJavaScript("firstData") { (result, error) in
            if error == nil, !(result == nil) {
                if let dic = result as? [String: Any] {
                    // 考虑到阿里网页的数据结构可能会发生调整，所以数据解析交由服务处理
                    weakSelf?.requestPushDataToServer(dic, LMAliDataType.myCart.rawValue)
                }
            }
        }
    }
}
