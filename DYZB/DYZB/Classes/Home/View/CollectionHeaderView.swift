//
//  CollectionHeaderView.swift
//  DYZB
//
//  Created by libo on 2017/11/20.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var moreBtn: UIButton!
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage.init(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
    
    
    
    
}
