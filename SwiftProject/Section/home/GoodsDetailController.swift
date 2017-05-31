//
//  GoodsDetailController.swift
//  SwiftProject
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class GoodsDetailController: UIViewController {
    var goodsNames: String?
    
    override func viewDidLoad() {
        navigationItem.title = "商品详情"
        self.view.backgroundColor = UIColor.white

        customBackItem()
    }
    
    func customBackItem() -> (){
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 0, y: 0, width: 60, height: 40)
        let img = getImage(obj: "Icon_back")
        button.setImage(img, for: .normal)
        button.setTitle((self.goodsNames?.isEmpty)! ? "返回" : "首页", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(.red, for: .normal)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        button.addTarget(self, action: #selector(GoodsDetailController.back), for: .touchUpInside)
        
        let spaceBar = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spaceBar.width = -10
        
        let leftBtn = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItems = [spaceBar, leftBtn]
        
    }
    
    
    func back() -> () {
        self.navigationController!.popViewController(animated: true)
    }
}
