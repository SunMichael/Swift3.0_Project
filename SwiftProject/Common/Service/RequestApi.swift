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
        let request = BaseRequest()
        request.apiPath = "user/login"
        request.bodyParamters = ["phone" : phone , "code" : code]
        request.startRequestWithHandle(success: { (response, error) in
            let dic = response?.result as! NSDictionary
            let model = AccountModel.deserialize(from: dic["user"] as? NSDictionary)
            SHUserDefault().accountInfor = model!
            

            print(" property : \(model?.getProperties(cls: (model?.classForCoder)!))" )
            
            
            completion(model, nil)
        }) { (error) in
            completion(nil, error)
        }
    }
}



class SHUserDefault: UserDefaults {
    static let shareDefault = SHUserDefault.standard

    var accountInfor: AccountModel {
        get {
            let data = SHUserDefault.shareDefault.value(forKey: "account")
            return NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! AccountModel
        }
        set {
//            self.accountInfor = newValue
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            SHUserDefault.shareDefault.set(data, forKey: "account")
        }
    }
    
}
