//
//  CycleModel.swift
//  DYZB
//
//  Created by libo on 2017/11/21.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    //标题
    @objc var title = ""
    //图片地址
    @objc var pic_url = ""
    //主播信息对应的字典
    var room :[String:NSObject]?{
        didSet{
            guard let room = room else {
                return
            }
            anchor = AnchorModel(dict: room)
        }
    }
    
    var anchor :AnchorModel?
    
    init(dict: [String:NSObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
