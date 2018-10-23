//
//  LMScriptMsgHandler.swift
//  LMAliDataAcquisition
//
//  Created by Tim on 2018/10/19.
//  Copyright © 2018年 Tim Lin. All rights reserved.
//

import UIKit
import WebKit

class LMScriptMsgHandler: NSObject, WKScriptMessageHandler {
    
    var handleBlock: (WKScriptMessage) -> Void = {_ in }
    
    init(handle: @escaping (WKScriptMessage) -> Void) {
        super.init()
        handleBlock = handle
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        handleBlock(message)
    }
}
