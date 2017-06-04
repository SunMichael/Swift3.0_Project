//
//  HomeModel.swift
//  SwiftProject
//
//  Created by mac on 2017/5/22.
//  Copyright © 2017年 mac. All rights reserved.
//

import Foundation

class ServiceModel: HandyJSON {
    var id : String?
    var name : String?
    var icon : String?
    var price : String?
    required init() {
        
    }
}

class AccountModel : NSObject, HandyJSON ,NSCoding {
    var id : Int?
    var realName : String?
    var phone : String?
    var logo : String?
    required override init() {
        
    }
   
    
    func encode(with aCoder: NSCoder) {
        self.sh_encode(aCoder: aCoder)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.sh_decode(aDecoder: aDecoder)
    }
    
}


extension AccountModel {       //实现过CustomStringConvertible协议的类 通过override来实现重写
    override var description: String {
        return ""
    }
    
    override var debugDescription: String {
        return ""
    }
}



class YuesaoModel: NSObject, HandyJSON {
    var orderNo : String?
    var reservationId : String?
    var status : String?
    var userServiceId : String?
    
    required override init() {
        
    }
}

struct DynamicKey {
    static let allPtyKey = UnsafePointer<Any>.init(bitPattern: "allPty".hashValue)
}

extension NSObject {
    
    var allPty : [String] {
        get {
            if objc_getAssociatedObject(self, DynamicKey.allPtyKey) == nil {
                return [String]()
            }else{
                return objc_getAssociatedObject(self, DynamicKey.allPtyKey) as! [String]
            }
        }
        set {
            //OBJC_ASSOCIATION_COPY_NONATOMIC  非原子属性运算更快 但线程不安全
            objc_setAssociatedObject(self, DynamicKey.allPtyKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    func getProperties(cls : AnyClass) -> [String]? {
        guard let className = NSString.init(cString: class_getName(cls), encoding: String.Encoding.utf8.rawValue) else {
            return nil
        }
        if className.isEqual(to: "NSObject") {
            return nil
        }
        if self.allPty.count > 0 {
            return self.allPty
        }
        
        var propertyAry = [String]()
        let superCls = cls.superclass() as! NSObject.Type
        let superPropertyAry = getProperties(cls: superCls)
        if superPropertyAry != nil {
            propertyAry += superPropertyAry!
        }
        
        var count: UInt32 = 0
        let allProperty = class_copyPropertyList(cls, &count)

        for i in 0..<Int(count) {
            let propertyname = String.init(utf8String: property_getName(allProperty?[i]))
            propertyAry.append(propertyname!)
        }
        self.allPty = propertyAry
        return propertyAry
        
    }
    
    func sh_encode(aCoder: NSCoder) -> () {
        let allProperty = self.getProperties(cls: self.classForCoder)
        for i in 0..<Int((allProperty?.count)!) {
            let first = allProperty?[i]

            let obj = self.value(forKey: first!) as Any?
            if obj == nil {
                return
            }
            aCoder.encode(obj, forKey: first!)
        }
    }
    
    func sh_decode(aDecoder: NSCoder) -> () {
        let allProperty = self.getProperties(cls: self.classForCoder)
        for i in 0..<Int((allProperty?.count)!) {
            let name = (allProperty?[i])
            let obj = aDecoder.decodeObject(forKey: name!)
            if obj == nil {
                return
            }
            self.setValue(obj, forKey: name!)
        }
    }
    
    func getValueOfProperty(property:String) -> AnyObject?{
        let allPropertys = self.getProperties(cls: self.classForCoder)
        if(allPropertys?.contains(property))!{
            return self.value(forKey: property) as AnyObject?
            
        }else{
            return nil
        }
    }
    
    func replaceKeyFromPropertyName() -> [String : String] {
        return ["" : ""]
    }
}




class openClass: SubClass {
    
}











