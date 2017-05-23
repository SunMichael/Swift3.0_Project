//
//  GoodsDetailController.swift
//  SwiftProject
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class GoodsDetailController: UIViewController {
    
    override func viewDidLoad() {
        navigationItem.title = "商品详情"
        self.view.backgroundColor = UIColor.white
//        let backItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(GoodsDetailController.back))
//        self.navigationItem.leftBarButtonItem = backItem
    }
    
    func back() -> () {
        self.navigationController?.popViewController(animated: true)
    }
}
