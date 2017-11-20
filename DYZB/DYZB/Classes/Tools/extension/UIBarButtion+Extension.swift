//
//  UIBarButtion+Extension.swift
//  DYZB
//
//  Created by libo on 2017/11/19.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    

  //便利构造函数
  convenience  init(_ imageName:String,hightImageName:String = "",size:CGSize = CGSize.zero) {
    
    let btn = UIButton()
    btn.setImage(UIImage.init(named: imageName), for: .normal)
    
    if hightImageName != ""{
       btn.setImage(UIImage.init(named: hightImageName), for: .highlighted)
    }
    if size == CGSize.zero{
        btn.sizeToFit()
        
    }else{
         btn.frame = CGRect(origin: CGPoint.zero, size: size)
    }

    self.init(customView: btn)
    }
    
}
