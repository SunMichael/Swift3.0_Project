//
//  HomeTableView.swift
//  SwiftProject
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import Alamofire


class HomeTableView: UITableView ,UITableViewDataSource ,UITableViewDelegate{
    
    var allGoods : NSMutableArray?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        
        super.init(frame: frame, style: style)

        self.delegate = self
        self.dataSource = self
        self.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0.01))
        self.requestForGoodsList()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let string = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: string)
        if (cell == nil) {
            cell = GoodsCell.init(style: UITableViewCellStyle.default, reuseIdentifier: string)
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVc = GoodsDetailController()
        let nc: UINavigationController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        nc.pushViewController(detailVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func requestForGoodsList() -> Void {

        let request = SWRequest()
        request.apiPath = "service/homeYuesaoList";
        request.httpMethod = .post
        request.bodyParamters = ["city" : "hangzhou","lng" : "30.278554", "lat" : "120.115817"]
        request.startRequestWithHandle(success: { (json, error) in
            let ary = json?.dictionary
            
        }) { (error) in
            
        }
    }
    
    
    
}

class GoodsCell: UITableViewCell {
    var nameLab : IvyLabel!
    var logIV : UIImageView!
    var line : CALayer!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        logIV = UIImageView.init(frame: CGRect.init(x: 10, y: 10, width: 60, height: 60))
        logIV.image = UIImage.init(named: "zheng")
        addSubview(logIV)
        
        nameLab = IvyLabel.init(frame: CGRect.init(x: logIV.frame.origin.x + logIV.frame.size.width + 10, y: logIV.frame.origin.y, width: 200, height: 16), text: "商品名字", font: UIFont.systemFont(ofSize: 16), textColor: UIColor.gray, textAlignment: NSTextAlignment.left, numberLines: 0)
        addSubview(nameLab)
        
        
        line = CALayer();
        line.backgroundColor = UIColor.gray.cgColor;
        line.frame = CGRect.init(x: 0, y: 119.5, width: screenW, height: 0.5)
        layer.addSublayer(line)
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}












