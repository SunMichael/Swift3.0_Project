//
//  HomeTableView.swift
//  SwiftProject
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import Kingfisher

let cellH = CGFloat(100.0)

class HomeTableView: UITableView ,UITableViewDataSource ,UITableViewDelegate{
    
    var allGoods : NSMutableArray?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        
        super.init(frame: frame, style: style)

        self.allGoods = NSMutableArray.init()
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0.01))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (allGoods?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let string = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: string) as? GoodsCell
        if (cell == nil) {
            cell = GoodsCell.init(style: UITableViewCellStyle.default, reuseIdentifier: string)
        }
        cell?.loadCellWithModel(model: self.allGoods?.object(at: indexPath.row) as! ServiceModel)
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
        return cellH
    }

    func requestForGoodsList() -> Void {
        LoadingAnimation.show()
        let request = SWRequest()
        request.apiPath = "service/homeYuesaoList";
        request.httpMethod = .post
        request.bodyParamters = ["city" : "hangzhou","lng" : "30.278554", "lat" : "120.115817"]
        request.startRequestWithHandle(success: { (response, error) in
            LoadingAnimation.dismiss()
            let obj = response?.result as! NSArray
            for i in 0 ..< obj.count {
                let dic = obj[i] as! NSDictionary
                let model :ServiceModel = ServiceModel.deserialize(from: dic)!
                self.allGoods?.add(model)
            }
            self .reloadData()
            
        }) { (error) in

        }
    }
    
    
    
}

class GoodsCell: UITableViewCell {
    var nameLab : IvyLabel!
    var priceLab : IvyLabel!
    var logIV : UIImageView!
    var line : CALayer!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        logIV = UIImageView.init(frame: CGRect.init(x: 10, y: 10, width: 80, height: 80))
        logIV.image = UIImage.init(named: "zheng")
        addSubview(logIV)
        
        nameLab = IvyLabel.init(frame: CGRect.init(x: logIV.frame.origin.x + logIV.frame.size.width + 10, y: logIV.frame.origin.y, width: 200, height: 16), text: "", font: UIFont.systemFont(ofSize: 16), textColor: UIColor.gray, textAlignment: NSTextAlignment.left, numberLines: 0)
        addSubview(nameLab)
        
        priceLab = IvyLabel.init(frame: CGRect.init(x: x(obj: nameLab) , y: getMaxY(obj: logIV) - 14, width: nameLab.frame.size.width, height: 14), text: nil, font: UIFont.systemFont(ofSize: 14), textColor: UIColor.red, textAlignment: NSTextAlignment.left, numberLines: 1)
        addSubview(priceLab)
        
        
        line = CALayer();
        line.backgroundColor = lineColor().cgColor;
        line.frame = CGRect.init(x: 0, y: cellH - 0.5, width: screenW, height: 0.5)
        layer.addSublayer(line)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func loadCellWithModel(model : ServiceModel) -> Void {
        nameLab.text = model.name
        priceLab.text = "¥" + model.price!
        let url = URL.init(string: model.icon!)
        logIV.kf.setImage(with: url, placeholder: UIImage.init(named: "zheng"), options: [.transition(.fade(1))], progressBlock: { (a, b) in
            
        }) { (image, error, type, url) in
            self.logIV.image = image
        }
    }
    
}












