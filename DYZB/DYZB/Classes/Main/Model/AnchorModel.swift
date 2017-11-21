//
//  AnchorModel.swift
//  DYZB
//
//  Created by libo on 2017/11/21.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    //房间ID
   @objc  var room_id = 0
    //房间图片
   @objc var vertical_src = ""
    //手机or电脑
   @objc var isVertical = 0
    //房间名城
   @objc var room_name = ""
    //主播名称
   @objc var nickname = ""
    //在线人数
   @objc var online = 0
   
   //所在城市
    @objc var anchor_city = ""
 
    init(dict: [String:NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
