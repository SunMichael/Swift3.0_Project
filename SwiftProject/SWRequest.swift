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
typealias failBlock = (Error?) -> Void

class RequestResponse : HandyJSON {
    var code : NSInteger = 200
    var errorMsg : String? = nil
    var result : Any?
    
    required init() {}
    
}

class SWRequest: NSObject {
    
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

    func startRequestWithHandle(success : @escaping successBlock ,fail : @escaping failBlock) -> Void {
        Alamofire.request(self.requestUrl, method: self.httpMethod, parameters: self.bodyParamters, encoding: self.encoding, headers: nil).responseJSON { response in
            print(response)
            if response.result.isSuccess {
                let json = JSON.init(data: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers, error: nil)
                let object = RequestResponse.deserialize(from: json.string)

                success( object, response.error)
            }else{
                fail(response.error)
            }
        }
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

