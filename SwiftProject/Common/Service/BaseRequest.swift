//
//  SWRequest.swift
//  SwiftProject
//
//  Created by mac on 2017/5/22.
//  Copyright © 2017年 mac. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


typealias successBlock = (RequestResponse? , Error?) -> Void
typealias failBlock = (RequestError?) -> Void

class RequestError: HandyJSON {
    var code : NSInteger = 0
    var errorMsg : String? = nil
    required init() {
        
    }
}

class RequestResponse : HandyJSON {
    var code : NSInteger = 200
    var errorMsg : String? = nil
    var result : Any?
    var success : Bool?
    required init() {}
    
}

class BaseRequest: NSObject {
    
    var apiPath : String? = nil
    var httpMethod : HTTPMethod = .get
    let httpConfig = HTTPConfig.sharedInstance
    var requestUrl: String! {
        get {
            return httpConfig.baseUrl  + self.apiPath!
        }
        set {
            self.requestUrl = newValue
        }
    }
    var bodyParamters : Dictionary<String, Any>?
    
    var encoding: ParameterEncoding {
        get {
            if httpMethod == HTTPMethod.get {
                return URLEncoding.default
            }else{
                return JSONEncoding.default
            }
        }
        
    }
    
    //@escaping 逃逸闭包：函数返回之后执行，一般用于异步回调
    func startRequestWithHandle(success : @escaping successBlock ,fail : @escaping failBlock) -> Void {
        Alamofire.request(self.requestUrl, method: self.httpMethod, parameters: self.bodyParamters, encoding: self.encoding, headers: nil).responseJSON { response in
            print(response)
            
            if response.result.isSuccess{
                let json = try! JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                let object = RequestResponse.deserialize(from: json)
                if (object?.success)!{
                    success(object, response.error)
                }else{
                    
                    let errorObj = RequestError.deserialize(from: json)
                    fail(errorObj)
                }
            }else{
                let obj = RequestError()
                obj.errorMsg = response.error.debugDescription
                obj.code = (response.response?.statusCode)!
                fail(obj)
            }
            
        }
    }
    
    func cancelRequest() -> Void {
        
    }
    
}


class HTTPConfig: NSObject {
    static let sharedInstance = HTTPConfig()
    
    var isOnline: Bool {
        get {
            return false
        }
        
    }
    var baseUrl: String {
        get {
            if self.isOnline {
                return "http://appapi.yizhenjia.com/"
            }else{
                return "http://mobile.api-test.yizhenjia.com/"
            }
        }
    }
    
}

