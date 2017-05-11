//
//  ViewController.swift
//  SwiftProject
//
//  Created by mac on 2017/5/10.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "首页"
        
        
       let table = HomeTableView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: screenH - CGFloat(footH) ), style: UITableViewStyle.grouped)
        view.addSubview(table)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

