//
//  UserViews.swift
//  SwiftProject
//
//  Created by mac on 2017/5/23.
//  Copyright © 2017年 mac. All rights reserved.
//

import Foundation

class UserTableView: UITableView ,UITableViewDataSource ,UITableViewDelegate{
    
    var allIconAry : Array<Array<Any>>!
    var allTitleAry : Array<Array<Any>>!
    
    override init(frame: CGRect, style: UITableViewStyle) {
        
        super.init(frame: frame, style: style)
        
        self.allIconAry = [[getImage(obj: "muyinghulishi"),getImage(obj: "foot")],
                           [getImage(obj: "order")],
                           [getImage(obj: "kefu"),getImage(obj: "shezhi")]]
        self.allTitleAry = [["母婴护理师","服务订单"],
                            ["商品订单"],
                            ["客服", "设置"]]
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = UITableViewCellSeparatorStyle.singleLineEtched
        
        self.tableHeaderView = UserHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 220))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allIconAry.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let ary = allIconAry[section]
        return ary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let string = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: string) as? UserTableCell
        if (cell == nil) {
            cell = UserTableCell.init(style: UITableViewCellStyle.default, reuseIdentifier: string)
        }
        
        let ary = allIconAry[indexPath.section]
        let ary2 = allTitleAry[indexPath.section]
        cell?.iconIv.image = ary[indexPath.row] as? UIImage
        cell?.titleLab.text = ary2[indexPath.row] as? String
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}



class UserTableCell: UITableViewCell {
    var iconIv = UIImageView()
    var moreIv = UIImageView()
    var titleLab = IvyLabel()
    var line : CALayer!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconIv = UIImageView.init(frame: CGRect.init(x: 10, y: 15, width: 20, height: 20))
        
        titleLab = IvyLabel.init(frame: CGRect.init(x: getMaxX(obj: iconIv) + 10, y: 0, width: 100, height: 50), text: nil, font: UIFont.systemFont(ofSize: 15), textColor: UIColor.black, textAlignment: .left, numberLines: 1)
        
        moreIv = UIImageView.init(frame: CGRect.init(x: screenW - 30, y: 35.0/2, width: 15, height: 15))
        moreIv.image = getImage(obj: "more")

        line = CALayer();
        line.backgroundColor = lineColor().cgColor;
        line.frame = CGRect.init(x: 0, y: 50 - 0.5, width: screenW, height: 0.5)
        layer.addSublayer(line)
        
        self.addSubview(iconIv)
        self.addSubview(titleLab)
        self.addSubview(moreIv)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class UserHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  setupViews() -> () {
        let bgimg = getImage(obj: "headerbj")
        let iconIv = UIImageView.init(image: bgimg)
        iconIv.frame = CGRect.init(x: 0, y: 0, width: screenW, height: bgimg.size.height)
        self.addSubview(iconIv)
        
        let headimg = getImage(obj: "touxiang")
        let headerIv = UIImageView.init(image: headimg)
        headerIv.frame = CGRect.init(x: screenW/2 - headimg.size.width/2, y: height(obj: iconIv)/2 - headimg.size.height/2, width: headimg.size.width, height: headimg.size.height)
        self.addSubview(headerIv)
        
        let nameLab = IvyLabel.init(frame: CGRect.init(x: 0, y: getMaxY(obj: headerIv) + 10, width: screenW, height: 15), text: "点击登录", font: UIFont.systemFont(ofSize: 15), textColor: UIColor.black, textAlignment: .center, numberLines: 1)
        self.addSubview(nameLab!)
    }
}





















