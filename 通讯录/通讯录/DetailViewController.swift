//
//  DetailViewController.swift
//  通讯录
//
//  Created by gary.liu on 16/12/19.
//  Copyright © 2016年 gary.liu. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var phoneTf: UITextField!
    @IBOutlet weak var titleTf: UITextField!
    
    
    var person:Person? = nil
    
    // 闭包的返回值是可选的
//    var completionCallBlock:()->()?
    // 闭包是可选的
    var completionCallBlock:(()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 判断person是否有值，如果有，设置UI
        guard (person != nil) else {
            print("person不能为nil")
            return
        }
        
        nameTf.text = person?.name
        phoneTf.text = person?.phone
        titleTf.text = person?.title
        
    }

    
    /// 保存数据
    ///
    /// - Parameter sender: 保存
    @IBAction func saveAction(_ sender: Any) {
        
//        1. 判断person是否为nil，如果是，就是新建
        if person == nil {
            person = Person()
        }
        
        // 2.用UI更新person的内容
        person?.name = nameTf.text;
        person?.phone = phoneTf.text
        person?.title = titleTf.text
        
        // 3.执行闭包回调
        // OC中执行block前都必须判断是否有值，否则容易崩溃
        // ! 强行解包
        // ? 可选解包 -》 如果 闭包为nil， 就什么都不做
        completionCallBlock?()
        
        // 4.返回上一级界面
        // Expression of type 'UIViewController?' is unused
        // 方法的返回值没有使用
        // _ 可以忽略一切不关心的内容
        _ = self.navigationController?.popViewController(animated: true)
    }
}
