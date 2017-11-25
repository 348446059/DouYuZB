//
//  BaseViewModel.swift
//  DYZB
//
//  Created by libo on 2017/11/23.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit

class BaseViewModel: NSObject {
  lazy var anchorGroups = [AnchorGroup]()
}

extension BaseViewModel{
    func loadAnchorData(isGroupData:Bool,url:String,parameters:[String:Any]? = nil,finishedCallback:@escaping()->Void)  {
        NetworkTools.requestData(type: .GET, url: url,params: parameters) { (result) in
            //1.对结果处理
            guard let resultDict = result as? [String:Any] else{return}
            guard let dataArray = resultDict["data"] as? [[String:Any]] else{
                return
            }
            if isGroupData{
                //2.便利
                for item in dataArray{
                    self.anchorGroups.append(AnchorGroup(dict: item))
                }
            }else{
                //2.1创建分组
                let group = AnchorGroup()
                
                //2.2遍历dataArray
                for dict in dataArray{
                    group.anchors.append(AnchorModel(dict: dict))
                }
                
                //2.3 添加分组
                self.anchorGroups.append(group)
            }
           
            
            finishedCallback()
        }
    }
}


























