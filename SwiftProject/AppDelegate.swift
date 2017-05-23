//
//  AppDelegate.swift
//  SwiftProject
//
//  Created by mac on 2017/5/10.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import Alamofire


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let tabbar = SHTabBarController.init()
        let nvgation = UINavigationController.init(rootViewController: tabbar)
        let backItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        tabbar.navigationItem.backBarButtonItem = backItem
        window?.rootViewController = nvgation
        
        addNetworkStatusObserve()
        
        return true
    }
    
    
    func addNetworkStatusObserve() -> Void {
        let manager = NetworkReachabilityManager.init(host: "www.baidu.com")
        manager?.listener = { status in
            
            if (status == NetworkReachabilityManager.NetworkReachabilityStatus.unknown) {
                let tip = UIAlertController.init(title: "温馨提示", message: "当前无网络", preferredStyle: UIAlertControllerStyle.alert)
                tip.addAction(UIAlertAction.init(title: "确定", style: UIAlertActionStyle.cancel, handler: { (sender) in
                    
                }))
                ROOTCONTROLLER .present(tip, animated: true, completion: { 
                    
                })
            }
            
        }
    }
    

    

}

