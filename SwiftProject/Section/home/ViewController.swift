//
//  ViewController.swift
//  SwiftProject
//
//  Created by mac on 2017/5/10.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    var table = HomeTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "首页"
        
        
        table = HomeTableView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: screenH - CGFloat(footH) ), style: UITableViewStyle.grouped)
        
        self.perform(#selector(HomeController.requestForList), with: nil, afterDelay: 0.1)
        print("  33333")
        view.addSubview(table)
        
    }
    func requestForList() -> () {
        table.requestForGoodsList()
    }
    override func viewDidAppear(_ animated: Bool) {
        //        table.requestForGoodsList()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

