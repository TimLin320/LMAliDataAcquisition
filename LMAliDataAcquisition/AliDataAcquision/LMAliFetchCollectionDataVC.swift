//
//  LMAliFetchCollectionDataVC.swift
//  LMAliDataAcquisition
//
//  Created by Tim on 2018/10/19.
//  Copyright © 2018年 Tim Lin. All rights reserved.
//
//  淘宝收藏夹页面
//

import UIKit
import WebKit

class LMAliFetchCollectionDataVC: LMAliFetchDataVC {
    
    override func callbackMessageName() -> String { return "fetchAliCollectionData" }
    override func fetchDataJSFileName() -> String { return "fetchAliCollectionData" }
    
    override func didReceive(message: WKScriptMessage) {
        if message.name == callbackMessageName() {
            guard let infoDict = message.body as? [String: Any] else {
                return
            }
            
            // 考虑到阿里网页的数据结构可能会发生调整，所以数据解析交由服务处理
            requestPushDataToServer(infoDict, LMAliDataType.myCollection.rawValue)
        }
    }
}
