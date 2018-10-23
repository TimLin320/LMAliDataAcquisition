//
//  LMAliFetchDataVC.swift
//  LMAliDataAcquisition
//
//  Created by Tim on 2018/10/19.
//  Copyright © 2018年 Tim Lin. All rights reserved.
//

import UIKit
import WebKit

class LMAliFetchDataVC: LMWebviewController {
    
    override var messageList: [String] {
        return [callbackMessageName()]
    }
    
    override func startLoad() {
        addUserScriptToUserController(webView.configuration.userContentController)
        super.startLoad()
    }
    
    // 注入js代码到网页中，当网页请求到数据后，回传给客户端
    func addUserScriptToUserController(_ controller: WKUserContentController) {
        let jsHandlerUrl: URL = Bundle.main.url(forResource: fetchDataJSFileName(), withExtension: "js")!
        
        var str = ""
        do {
            str = try String.init(contentsOf: jsHandlerUrl, encoding: .utf8)
        } catch {
            
        }
        
        let ajaxHandler: WKUserScript = WKUserScript.init(source: str, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        controller.addUserScript(ajaxHandler)
    }
    
    override func didReceive(message: WKScriptMessage) {
        
    }
    
    func requestPushDataToServer(_ dataJsonStr: [String: Any]?, _ dataTypeStr: String?) {
        guard let jsonStr = dataJsonStr, let typeStr = dataTypeStr, typeStr.count > 0 else { return }
        
        // TODO：1、放抓包处理（判断设备是否设置了代理）
        // TODO：2、将网页上采集到的数据传给服务端
    }
    
    func callbackMessageName() -> String { return "" }
    func fetchDataJSFileName() -> String { return "" }
}

extension LMAliFetchDataVC {
    
    override func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("load aliFetchData url: \(webView.url?.absoluteString ?? "url is nil")")
        setWebTitle()
        if showProgressView {
            progressView.isHidden = true
        }
    }
}
