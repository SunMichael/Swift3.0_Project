//
//  HeaderFile.swift
//  SwiftProject
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 mac. All rights reserved.
//

// swift 宏定义  不是oc的预编译 而是设置全局变量

import Foundation


let ROOTCONTROLLER = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController

func x (obj: UIView) -> CGFloat {
    return obj.frame.origin.x
}

func y (obj: UIView) -> CGFloat {
    return obj.frame.origin.y
}

func width (obj: UIView) -> CGFloat {
    return obj.frame.size.width
}

func height (obj: UIView) -> CGFloat {
    return obj.frame.size.height
}

func getMaxY (obj: UIView) -> CGFloat {
    return obj.frame.size.height + obj.frame.origin.y
}

func getMaxX (obj: UIView) -> CGFloat {
    return obj.frame.size.width + obj.frame.origin.x
}
