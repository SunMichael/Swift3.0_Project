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
            let token = dic["token"] as? String
            let model = AccountModel.deserialize(from: dic["user"] as? NSDictionary)
            SHUserDefault.shareInstance.accountInfor = model!
            SHUserDefault.shareInstance.setToken(token: token!)

            print(" property : \(model?.getProperties(cls: (model?.classForCoder)!))" )
            
            
            completion(model, nil)
        }) { (error) in
            completion(nil, error)
        }
    }
    
    public class func getUserYuesaoInfor(completion:@escaping (_ ysmodel: YuesaoModel? , _ error : RequestError? ) -> ()) -> (){
        let request = BaseRequest()
        request.apiPath = ""
        request.startRequestWithHandle(success: { (response, error) in
            let dic = response?.result as! NSDictionary
            let model = YuesaoModel.deserialize(from: dic)
            completion(model , nil)
        }) { (error) in
            completion(nil , error)
        }
    }
}



class SHUserDefault: NSObject {
    private static let shareDefault = UserDefaults.standard
    static let shareInstance = SHUserDefault()
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
    
    func setToken(token : String) -> (){
        SHUserDefault.shareDefault.set(token, forKey: "token")
    }
    func getToken() -> String {
        return SHUserDefault.shareDefault.object(forKey: "token") as! String
    }

    
}
