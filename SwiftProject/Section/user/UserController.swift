//
//  UserController.swift
//  SwiftProject
//
//  Created by mac on 2017/5/23.
//  Copyright © 2017年 mac. All rights reserved.
//

import Foundation

import Alamofire

class UserController: UIViewController {
    
    override func viewDidLoad() {
        
        let userTab = UserTableView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: screenH), style: UITableViewStyle.grouped)
        self.view.addSubview(userTab)
    }
    
    
}


class LoginController: UIViewController {
    override func viewDidLoad() {
        self.navigationItem.title = "登录"
        self.view.backgroundColor = UIColor.white
        self.allTfAry = NSMutableArray()
        setupViews()
    }
    var count: NSInteger = 60
    var allTfAry: NSMutableArray!
    var codeBtn : UIButton!
    
    func setupViews() -> (){
        let offx = screenW/2 - 200.0/2
        var offy = 160.0
        let titleAry = ["请输入手机号码", "请输入验证码"]
        for i in 0  ..< titleAry.count  {
            let tf = UITextField.init(frame: CGRect.init(x: Double(offx), y: offy, width: 200.0, height: 30.0))
            tf.placeholder = titleAry[i]
            tf.borderStyle = UITextBorderStyle.none
            tf.font = UIFont.systemFont(ofSize: 15)
            offy += 30.0 * Double(i) + 30.0 + 10.0
            self.view.addSubview(tf)
            allTfAry?.add(tf)
        }
        
        
        codeBtn = UIButton.init(frame: CGRect.init(x: screenW - 120.0, y: 160.0, width: 100.0, height: 30.0))
        codeBtn.addTarget(self, action: #selector(LoginController.getPhoneCode), for: .touchUpInside)
        codeBtn.setTitle("获取验证码", for: .normal)
        codeBtn.layer.masksToBounds = true
        codeBtn.layer.cornerRadius = 5.0
        codeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        let img = UIImage.getImageWithColor(kRedColor())
        codeBtn.setBackgroundImage(img, for: .normal)
        let disableImg = UIImage.getImageWithColor(UIColor.lightGray)
        codeBtn.setBackgroundImage(disableImg, for: .disabled)
        
        self.view.addSubview(codeBtn)
        
        let loginBtn = UIButton.init(frame: CGRect.init(x: Double(offx), y: offy + 40.0, width: 200.0, height: 30.0))
        loginBtn.addTarget(self, action: #selector(LoginController.login), for: .touchUpInside)
        loginBtn.setBackgroundImage(img, for: .normal)
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        loginBtn.layer.masksToBounds =  true
        loginBtn.layer.cornerRadius =  5.0
        self.view.addSubview(loginBtn)

        
    }
    
    func getPhoneCode() -> Void {
        let timer = DispatchSource.makeTimerSource()
        self.codeBtn.isEnabled = false
        timer.setEventHandler { 
            self.count -= 1
            DispatchQueue.main.async {
              self.codeBtn.setTitle("已发送" + String(self.count), for: .normal)
            }
            if self.count <= 0 {
                timer.cancel()
                self.count = 60
                self.codeBtn.isEnabled = true
                self.codeBtn.setTitle("获取验证码", for: .normal)
            }
            
        }
        timer.scheduleRepeating(deadline: DispatchTime.now(), interval: .seconds(1), leeway: .milliseconds(1))
        timer.resume()
        
    }
    func login() -> () {
        
        let phoneTf = allTfAry?.object(at: 0) as! UITextField
        let codeTf  = allTfAry?.object(at: 1) as! UITextField
        if (phoneTf.text?.isEmpty) == true {
            return
        }
        if codeTf.text?.isEmpty == true {
            return
        }
        LoadingAnimation.show()
        RequestApi.userLogin(phoneTf.text!, andCode: codeTf.text!) { (account, error) in
            
            LoadingAnimation.dismiss()
            if (account != nil) {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: LOGINSUCESSNOTIC), object: nil)
                self.navigationController!.popViewController(animated: true)
            }else{
                print(" 登录失败 ")
            }
        }
    }
    
}
