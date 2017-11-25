
//
//  AmuseViewModel.swift
//  DYZB
//
//  Created by libo on 2017/11/23.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit

class AmuseViewModel:BaseViewModel{
}

extension AmuseViewModel{
    func loadAmuseData(finished:@escaping()->Void)  {
       loadAnchorData(isGroupData: true,url: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finished)
    }
}
