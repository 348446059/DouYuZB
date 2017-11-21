//
//  BaseCollectionViewCell.swift
//  DYZB
//
//  Created by libo on 2017/11/21.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var onlineBtn: UIButton!
    
    var anchor:AnchorModel?{
        didSet{
            //0.校验，模型
            guard let anchor = anchor else {
                return
            }
            //1.取出在线人数
            var onlineStr = ""
            if anchor.online >= 1000{
                onlineStr = "\(Int(anchor.online / 10000))" + "万在线"
            }else{
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            //2.昵称
            nickNameLabel.text = anchor.nickname
            
            //3.现实当前封面图片
            guard let url =  URL(string: anchor.vertical_src)  else {
                return
            }
              iconImageView.kf.setImage(with: url)
        }
    }
}
