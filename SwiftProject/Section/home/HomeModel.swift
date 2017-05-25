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

class AccountModel : HandyJSON {
    var id : String?
    var nickName : String?
    var phone : String?
    required init() {
        
    }
}
