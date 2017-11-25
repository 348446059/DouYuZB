//
//  AmuseMenuViewCell.swift
//  DYZB
//
//  Created by libo on 2017/11/24.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit
private let KGameCellID = "KGameCellID"
class AmuseMenuViewCell: UICollectionViewCell {

    var group :[AnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
  
    
    collectionView.register( UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: KGameCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        
        layout.itemSize = CGSize(width: itemW, height: itemH)
        
        
    }

}

extension AmuseMenuViewCell:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return group?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KGameCellID, for: indexPath) as! GameCollectionViewCell
       cell.clipsToBounds = true
        cell.group = group![indexPath.row]
        return cell
    }
    
    
}
