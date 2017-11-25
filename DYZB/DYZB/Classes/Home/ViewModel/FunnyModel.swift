//
//  FunnyModel.swift
//  DYZB
//
//  Created by libo on 2017/11/24.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit

class FunnyModel:BaseViewModel{

}

extension FunnyModel{
    func loadFunnyData(finishedCallback:@escaping()->Void)  {
        loadAnchorData(isGroupData: false,url: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallback)
    }
}
