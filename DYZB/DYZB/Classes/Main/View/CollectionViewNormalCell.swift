//
//  CollectionViewNormalCell.swift
//  DYZB
//
//  Created by libo on 2017/11/20.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: BaseCollectionViewCell {

   
    @IBOutlet weak var roomLabel: UILabel!
    //定义模型属性
    
  override  var anchor:AnchorModel?{
        didSet{
            super.anchor = anchor
            roomLabel.text = anchor?.room_name
        }
    }

}
