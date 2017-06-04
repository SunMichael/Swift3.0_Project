//
//  Categary.swift
//  SwiftProject
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 mac. All rights reserved.
//

import Foundation

//extension ImageMaker where Base: UIImage  {
//    
//}


extension UIImage {
    static func getImageWithColor(_ color : UIColor) -> UIImage {
        let rect = CGRect.init(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image!
    }
}



//extension String {
//    func isEmpty() -> Bool{
//        return
//    }
//}

/*
 类 和 结构体 的区别
 1. 类的属性必须要有初始化，结构体不需要（结构体默认系统会生成一个初始化方法）
 2. 类可以继承 结构体不行
 3. class 修饰字只能在类中使用
 4. 类是引用类型  结构体是值类型
*/


struct SPerson {
    var name: String = "name"
    var age: Int
    func sayHello() -> () {
        print(" hello ")
    }
    
    static func staticFunction() -> () {
        
    }
}

class CPerson: NSObject {
    var name: String = "name"
//    var age : Int 
    func sayHello() -> () {
        print(" hello ")
    }
    
    class func classFunction() -> () {
        
    }
    
    static func staticFunction() -> () {
        
    }
}

extension SPerson: CustomStringConvertible {
    public var description: String {
        return self.name + String(self.age)
    }
}

public enum EnumType: Int {
    case nomal = 1
    case select
    case cancel
}

open class BaseClass: NSObject {
    var name: String?
}

public class SubClass: BaseClass {
    var value: String?
    
    func atest() -> () {
       let _ = Stack.init(items: ["a","b"])
    }
}


struct Stack <T>{
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop(item: T) -> T {
        return items.removeLast()
    }
}

