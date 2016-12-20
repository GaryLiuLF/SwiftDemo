//
//  WebsiteListVC.swift
//  网站列表
//
//  Created by Apple on 16/12/20.
//  Copyright © 2016年 LLF. All rights reserved.
//

import UIKit

class WebsiteListVC: UITableViewController {
    
    var websiteList = [WebSiteModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData { (list) in
            self.websiteList += list
            self.tableView.reloadData()
        }
        
    }
    
    // FIXME: @escaping 
    // swift3，闭包参数默认为 non-escaping，也可以使用@escaping属性关键字为标识闭包可“逃逸”
    private func loadData(completion:@escaping (_ list:[WebSiteModel]) -> ()) -> () {
        
        // 加载数据 异步回调
        DispatchQueue.global().async {
            print("正在加载数据...")
            Thread.sleep(forTimeInterval: 2)
            
            var arrayM = [WebSiteModel]()
            
            for i in 0..<20 {
                let s = WebSiteModel()
                s.name = "百度网站 + \(i)"
                s.site = "http://www.baidu.com"
                
                arrayM.append(s)
            }
            
            // 主线程刷新界面
            DispatchQueue.main.async {
                completion(arrayM)
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websiteList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = websiteList[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 执行segue
        performSegue(withIdentifier: "websiteDetail", sender: indexPath)
    }
    
    // MARK: - segue跳转界面都会执行的方法
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "websiteDetail" {
            let vc = segue.destination as! WebsiteDetailVC
            if let indexPath = sender as? IndexPath {
                vc.website = websiteList[indexPath.row]
            }
        }
        else if segue.identifier == "addWebsite" {
            let vc = segue.destination as! AddWebsiteVC
            vc.completionBlock = { (newWebsite) in
                self.websiteList.insert(newWebsite, at: 0)
            }
            tableView.reloadData()
        }
        
    }
    
    /// 添加网站
    ///
    /// - Parameter sender: 添加
    @IBAction func addWebsiteAction(_ sender: Any)
    {
        // 执行segue
        performSegue(withIdentifier: "addWebsite", sender: nil)
    }
}
