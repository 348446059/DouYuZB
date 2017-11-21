//
//  CycleViewCell.swift
//  DYZB
//
//  Created by libo on 2017/11/21.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit
import Kingfisher
class CycleViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    //MARK:定义模型属性
    var cycleModel:CycleModel?{
        didSet{
            titleLabel.text  = cycleModel?.title
            let url = URL(string: cycleModel?.pic_url ?? "")
            iconImageView.kf.setImage(with: url)
        }
    }
    

}
