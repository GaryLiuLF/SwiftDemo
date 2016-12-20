//
//  AddWebsiteVC.swift
//  网站列表
//
//  Created by Apple on 16/12/20.
//  Copyright © 2016年 LLF. All rights reserved.
//

import UIKit

class AddWebsiteVC: UITableViewController {

    
    @IBOutlet weak var webNameTf: UITextField!
    @IBOutlet weak var siteTf: UITextField!
    
    var completionBlock:((_ website:WebSiteModel)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - 保存
    @IBAction func saveAction(_ sender: Any) {
        
        guard (webNameTf.text != "") else {
            print("请输入网站名")
            return
        }
        guard (siteTf.text != "") else {
            print("请输入网站IP")
            return
        }
        
        let model = WebSiteModel()
        model.name = webNameTf.text
        model.site = siteTf.text
        
        completionBlock?(model)
        
        let _ = navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
