//
//  ViewController.swift
//  LMAliDataAcquisition
//
//  Created by Tim on 2018/10/19.
//  Copyright © 2018年 Tim Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func gotoAliCartWeb(_ sender: UIButton) {
        // 淘宝授权后，可免登录
        let web = LMAliFetchCartDataVC.init(url: "https://cart.taobao.com/cart.htm")
        navigationController?.pushViewController(web, animated: true)
    }
    
    @IBAction func gotoAliOrdersWeb(_ sender: UIButton) {
        // 淘宝授权后，可免登录
        let web = LMAliFetchOrdersDataVC.init(url: "https://h5.m.taobao.com/mlapp/olist.html")
        navigationController?.pushViewController(web, animated: true)
    }
    
    @IBAction func gotoAliCollectionWeb(_ sender: UIButton) {
        // 淘宝授权后，可免登录
        let web = LMAliFetchCollectionDataVC.init(url: "https://h5.m.taobao.com/fav/index.htm")
        navigationController?.pushViewController(web, animated: true)
    }
}

