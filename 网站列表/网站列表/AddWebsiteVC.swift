//
//  AddWebsiteVC.swift
//  网站列表
//
//  Created by Apple on 16/12/20.
//  Copyright © 2016年 LLF. All rights reserved.
//

import UIKit

class AddWebsiteVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
