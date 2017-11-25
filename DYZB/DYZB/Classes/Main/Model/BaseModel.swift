//
//  BaseModel.swift
//  DYZB
//
//  Created by libo on 2017/11/23.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    @objc  var tag_name = ""
    @objc   var icon_url = ""
    //MARK:构造函数
    override init() {
        
    }
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
