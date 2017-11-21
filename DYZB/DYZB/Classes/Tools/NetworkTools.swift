//
//  NetworkTools.swift
//  DYZB
//
//  Created by libo on 2017/11/20.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools {
  
    class func requestData(type:MethodType, url:String, params:[String : String]? = nil,finishedCallBack:@escaping (AnyObject)->())  {
        
        
        //1.获取请求类型
        let callback  = { (response:DataResponse<Any>) in
            guard let result = response.result.value else {
                print(response.result.error ?? "请求出错")
                return
            }
            finishedCallBack(result as AnyObject)
        }
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
      
    if type == .GET {
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: callback)
    }else{
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default,headers: headers).responseJSON(completionHandler: callback)
        
    }
       
        //2.发送请求
    
//    Alamofire.request(requestData(type: method, url: url, params: params, finishedCallBack: { (response) in
//        // 3.获取结果
//        guard let result = response.result.value else {
//            print(response.result.error)
//            return
//        }
//
//        // 4.将结果回调出去
//        finishedCallback(result: result)
//    })
   
//    Alamofire.request(method, url, parameters: params).responseJSON { (response) in
//      
//    }

    
   
    }
   
    
}


