//
//  ListTableViewController.swift
//  通讯录
//
//  Created by gary.liu on 16/12/19.
//  Copyright © 2016年 gary.liu. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    var personList = [Person]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = 50;
        
        loadData { (list) in
//            print(list)
            // ’拼接‘数组, 闭包中定义好的大妈在需要的时候执行，需要self. 指定语境
            self.personList += list
            // 刷新列表
            self.tableView.reloadData()
        }
    }
    
    // 模拟异步，利用闭包回调
    private func loadData(completion:@escaping (_ list: [Person]) -> ()) -> () {
        DispatchQueue.global().async {
            print("正在努力加载中...")
            Thread.sleep(forTimeInterval: 1)
            
            var arrayM = [Person]()
            for i in 0..<20 {
                let p = Person()
                p.name = "你飞哥 + \(i)"
                p.phone = "1860" + String(format: "%06d", arc4random_uniform(1000000))
                p.title = "Boss"
                
                arrayM.append(p)
            }
            
            
            // 主线程回调
            DispatchQueue.main.async {
                // 回调，执行闭包
                completion(arrayM)
            }
        }
    }
    
    // MARK: - 数据源
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        cell.textLabel?.text = personList[indexPath.row].name
        cell.detailTextLabel?.text = personList[indexPath.row].phone
        
        return cell
    }
    
    // MARK: - 代理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        // 执行segue
        performSegue(withIdentifier: "list2detail", sender: indexPath)
    }
    
    
    /// 添加联系人
    ///
    /// - Parameter sender: 添加
    @IBAction func addPersonAction(_ sender: Any) {
        // 执行segue跳转界面
        performSegue(withIdentifier: "list2detail", sender: nil)
    
    }
    // MARK: - 控制器跳转的方法
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 强制类型转换 as
        // 在swift中，除了String以外，as后面都需要加 ？ ！
        // as? as!直接根据前面的返回值选择，如果没有，as！ 如果有？，as?
        // 以往遇到if let 或guard let ，判断参数一律用as?
        let vc = segue.destination as! DetailViewController
        
        // 设置person,sender是可选的，所以需要判断一下
        guard let indexPath = sender as? IndexPath else {
            
            // 创建个人记录
            vc.completionCallBlock = {
                // 1. 获取明细控制器的person
                guard let p = vc.person else {
                    return
                }
                
                // 插入到数组顶部
                self.personList.insert(p, at: 0)
                
                // 刷新列表
                self.tableView.reloadData()
            }
            
            return
        }
        
        vc.person = personList[indexPath.row]
        // 设置编译完成的闭包
        vc.completionCallBlock = {
            // 刷新指定行
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        
        // FIXME: block特点
        // 1. 定义block可以个当前上下文一起
        // 2. 便于阅读和维护
        // 3. 可以根据不同的需求传递不同的代码
    }
}
