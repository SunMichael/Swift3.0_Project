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
import HandyJSON

typealias successBlock = (JSON? , Error?) -> Void
typealias failBlock = (Error?) -> Void

class RequestResponse : NSObject ,HandyJSON {
    var code : NSInteger = 200
    var errorMsg : String? = nil
    var result : Dictionary? = [:]
    required override init() {}
    
}
class BasicTypes: HandyJSON {
    var int: Int = 2
    var doubleOptional: Double?
    var stringImplicitlyUnwrapped: String!
    
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
                let jsonString = "{\"id\":\"77544\",\"json_name\":\"Tom Li\",\"age\":18,\"grade\":2,\"height\":180,\"gender\":\"Female\",\"className\":\"A\",\"teacher\":{\"name\":\"Lucy He\",\"age\":28,\"height\":172,\"gender\":\"Female\",},\"subjects\":[{\"name\":\"math\",\"id\":18000324583,\"credit\":4,\"lessonPeriod\":48},{\"name\":\"computer\",\"id\":18000324584,\"credit\":8,\"lessonPeriod\":64}],\"seat\":\"4-3-23\"}"
                let object = BasicTypes.deserialize(from: jsonString)
                
                success( json, response.error)
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

