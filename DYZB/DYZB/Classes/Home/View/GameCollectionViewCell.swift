//
//  GameCollectionViewCell.swift
//  DYZB
//
//  Created by libo on 2017/11/21.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit
import Kingfisher
class GameCollectionViewCell: UICollectionViewCell {
    var group : AnchorGroup?{
        didSet{
            
            titleLabel.text = group?.tag_name
            let icon_url = URL(string: group?.icon_url ?? "")
             iconImageView.kf.setImage(with: icon_url, placeholder: #imageLiteral(resourceName: "home_more_btn"))
        }
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
