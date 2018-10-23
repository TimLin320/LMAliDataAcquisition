//
//  LMWebviewController.swift
//  LMAliDataAcquisition
//
//  Created by Tim on 2018/10/19.
//  Copyright © 2018年 Tim Lin. All rights reserved.
//

import UIKit
import WebKit

class LMWebviewController: UIViewController {
    
    let goBack = "goBack"
    let openLogin = "openLogin"
    
    var messageList: [String] {
        return [goBack, openLogin]
    }
    
    lazy var msgHanler: LMScriptMsgHandler = {
        let handler = LMScriptMsgHandler.init(handle: { [weak self] (msg) in
            self?.didReceive(message: msg)
        })
        return handler
    }()
    
    var urlStr: String
    var webStaticTitle: String?
    
    var showProgressView = true
    lazy var progressView: UIProgressView = {
        let progress = UIProgressView.init(frame: .zero)
        progress.trackTintColor = .white
        progress.progressTintColor = UIColor.init(red: 218.0, green: 156.0, blue: 46.0, alpha: 1.0)
        progress.setProgress(Float(0.1), animated: true)
        return progress
    }()
    
    lazy var webView: WKWebView = {
        let contentController = WKUserContentController.init()
        for method in messageList {
            contentController.add(msgHanler, name: method)
        }
        
        let configuration = WKWebViewConfiguration.init()
        configuration.userContentController = contentController
        
        let preferences: WKPreferences = WKPreferences.init()
        preferences.javaScriptCanOpenWindowsAutomatically = true;
        configuration.preferences = preferences;
        
        let view = WKWebView.init(frame: self.view.frame, configuration: configuration)
        view.navigationDelegate = self
        view.uiDelegate = self
        return view
    }()
    
    convenience init(targetUrl: String) {
        self.init(url: targetUrl)
    }
    
    init(url: String) {
        urlStr = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeAllMessage()
        removeWebProgressObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    @objc func dismissAction() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func configInset() {
        if #available(iOS 11.0, *) {
            webView.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAllSubviews()
        startLoad()
    }
    
    func configLeftBackItem() {
        let backImg = "back_black"
        let closeTextColor = UIColor.init(red: 51.0, green: 51.0, blue: 51.0, alpha: 1.0)
        
        let backItem = UIBarButtonItem.init(image: UIImage.init(named: backImg)?.withRenderingMode(.alwaysOriginal),
                                            style: .plain,
                                            target: self,
                                            action: #selector(clickBackItem))
        
        let closeBtn = UIBarButtonItem.init(title: "关闭",
                                            style: .plain,
                                            target: self,
                                            action: #selector(clickCloseBtn))
        
        closeBtn.setTitleTextAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16),
                                         NSAttributedStringKey.foregroundColor : closeTextColor],
                                        for: .normal)
        navigationItem.setLeftBarButtonItems([backItem, closeBtn], animated: false)
    }

    func addAllSubviews(){
        view.addSubview(webView)
        webView.frame = CGRect(x: 0, y: 84.0, width: view.frame.width, height: view.frame.height - 84.0)

        configInset()
        configRefrshButton()
        addProgressView()
    }
    
    func configRefrshButton() {
        let refreshItem = UIBarButtonItem.init(image: UIImage.init(named: "web_refresh")?.withRenderingMode(.alwaysOriginal),
                                               style: .plain,
                                               target: self,
                                               action: #selector(clickRefresh))
        navigationItem.setRightBarButton(refreshItem, animated: false)
    }
    
    @objc func clickRefresh() {
        webView.reload()
    }
    
    func startLoad() {
        guard let reqUrl = URL.init(string: urlStr) else { return }
        
        let req = URLRequest.init(url: reqUrl,
                                  cachePolicy: .useProtocolCachePolicy,
                                  timeoutInterval: 30.0)
        webView.load(req)
    }

    @objc func clickCloseBtn() {
        if presentingViewController != nil {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    @objc func clickBackItem() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            clickCloseBtn()
        }
    }
}

