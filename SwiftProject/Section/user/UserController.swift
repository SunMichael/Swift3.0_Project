//
//  UserController.swift
//  SwiftProject
//
//  Created by mac on 2017/5/23.
//  Copyright © 2017年 mac. All rights reserved.
//

import Foundation

class UserController: UIViewController {
    
    override func viewDidLoad() {
        
        let userTab = UserTableView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: screenH), style: UITableViewStyle.grouped)
        self.view.addSubview(userTab)
    }
    
    
}
