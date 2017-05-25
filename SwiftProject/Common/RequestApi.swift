//
//  RequestApi.swift
//  SwiftProject
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 mac. All rights reserved.
//

import Foundation



class RequestApi: NSObject {
    
    public class func userLogin(_ phone: String , andCode code : String , completion: @escaping (_ account: AccountModel? , _ error : RequestError?) -> () ) -> Void{
        let request = SWRequest()
        request.apiPath = "user/login"
        request.bodyParamters = ["phone" : phone , "code" : code]
        request.startRequestWithHandle(success: { (response, error) in
            let dic = response?.result as! NSDictionary
            let model = AccountModel.deserialize(from: dic)
            completion(model, nil)
        }) { (error) in
            completion(nil, error)
        }
    }
}
