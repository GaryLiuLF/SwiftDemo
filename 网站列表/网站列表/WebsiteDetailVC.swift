//
//  WebsiteDetailVC.swift
//  网站列表
//
//  Created by Apple on 16/12/20.
//  Copyright © 2016年 LLF. All rights reserved.
//

import UIKit

class WebsiteDetailVC: UIViewController {

    var website:WebSiteModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        
        guard (website != nil) else {
            print("网站不能为nil")
            return
        }
        
        let webview = UIWebView(frame: view.bounds)
        view.addSubview(webview)
        webview.backgroundColor = UIColor.yellow
        
        let url = URL.init(string: (website?.site)!)
        let request = URLRequest(url: url!)
        webview.loadRequest(request)
    }

}
