//
//  CollectionViewPrettyCell.swift
//  DYZB
//
//  Created by libo on 2017/11/20.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionViewPrettyCell: BaseCollectionViewCell {
   
    @IBOutlet weak var cityBtn: UIButton!
    //定义模型属性
  override  var anchor:AnchorModel?{
        didSet{
            super.anchor = anchor
            //3.城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
            
        }
    }
    

}
