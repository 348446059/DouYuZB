//
//  AnchorGroup.swift
//  DYZB
//
//  Created by libo on 2017/11/21.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit

class AnchorGroup: BaseModel {
    //该主播对应的房间信息
    @objc var room_list : [[String:NSObject]]?{
        didSet {
            guard let room_list = room_list else {
                return
            }
            for dict in room_list{
                let anchor = AnchorModel(dict: dict)
                anchors.append(anchor)
                
            }
        }
    }
    
   
    //组显示图标
   @objc var icon_name = "home_header_normal"
   
    //定义主播的模型数组
    lazy var anchors = [AnchorModel]()
}
