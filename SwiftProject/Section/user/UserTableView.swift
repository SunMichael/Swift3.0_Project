//
//  UserViews.swift
//  SwiftProject
//
//  Created by mac on 2017/5/23.
//  Copyright © 2017年 mac. All rights reserved.
//

import Foundation


class UserTableView: UITableView ,UITableViewDataSource ,UITableViewDelegate, UserHeaderDelegate{
    
    var allIconAry : Array<Array<Any>>!
    var allTitleAry : Array<Array<Any>>!
    var header: UserHeaderView!
    
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

        header = UserHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 220))
        header.delegate = self
        
        self.tableHeaderView = header
        
        let _ = { () -> String in
            return ""
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(UserTableView.reloadHeader), name: NSNotification.Name(rawValue: LOGINSUCESSNOTIC), object: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //登录之后刷新header
    func reloadHeader() -> () {
        header.updateInfor()
    }
    
    
    func clickedLoginBtn() {
        let vc = LoginController()
        ROOTCONTROLLER.pushViewController(vc, animated: true)
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
        cell?.tag = indexPath.row + 10 * indexPath.section
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView .cellForRow(at: indexPath)
        print(" cell tag = " + String(describing: (cell?.tag)) )
        switch cell!.tag {
        case 0: break
            
        default: break
            
        }
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
        
        moreIv = UIImageView.init(frame: CGRect.init(x: screenW - 25, y: 35.0/2, width: 15, height: 15))
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
    
    var delegate : UserHeaderDelegate?

    var nameLab : IvyLabel?
    var iconIv : UIImageView!
    var headerIv : UIImageView!
    override init(frame: CGRect) {
        delegate = nil
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  setupViews() -> () {
        let bgimg = getImage(obj: "headerbj")
        iconIv = UIImageView.init(image: bgimg)
        iconIv.frame = CGRect.init(x: 0, y: 0, width: screenW, height: bgimg.size.height)
        self.addSubview(iconIv!)
        
        let headimg = getImage(obj: "touxiang")
        headerIv = UIImageView.init(image: headimg)
        headerIv.frame = CGRect.init(x: screenW/2 - headimg.size.width/2, y: height(obj: iconIv)/2 - headimg.size.height/2, width: headimg.size.width, height: headimg.size.height)
        self.addSubview(headerIv)
        
        nameLab = IvyLabel.init(frame: CGRect.init(x: 0, y: getMaxY(obj: headerIv) + 10, width: screenW, height: 15), text: "点击登录", font: UIFont.systemFont(ofSize: 15), textColor: UIColor.black, textAlignment: .center, numberLines: 1)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(UserHeaderView.clickedBtn))
        nameLab?.isUserInteractionEnabled = true
        nameLab?.addGestureRecognizer(tap)
        self.addSubview(nameLab!)
        
        let account = SHUserDefault.shareInstance.accountInfor
        if account.phone?.isEmpty != false {
            self.updateInfor()
        }
    }
    
    func updateInfor() -> () {
        let account = SHUserDefault.shareInstance.accountInfor
        
        nameLab?.text = account.realName
        let img = getImage(obj: "touxiang")
        headerIv.kf.setImage(with: URL.init(string: account.logo!), placeholder: img, options: nil, progressBlock: nil) { (image, nil, type, url) in
            self.headerIv.image = image
        }
    }
    
    func clickedBtn() -> (){
        if (delegate != nil) {
            delegate?.clickedLoginBtn()
        }
    }
}

protocol UserHeaderDelegate {
    func clickedLoginBtn() -> Void
}



//尾随闭包 
/*
func tailBlock(block: () -> Void) ->(){
    print(" 尾随闭包 ")
    block()
}

tailBlock {
    
}
 
*/















