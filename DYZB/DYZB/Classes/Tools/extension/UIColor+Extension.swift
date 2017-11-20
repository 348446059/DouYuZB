//
//  UIColor+Extension.swift
//  DYZB
//
//  Created by libo on 2017/11/20.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit

extension UIColor{
  convenience  init(r:CGFloat,g:CGFloat,b:CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    
    
    }
}
