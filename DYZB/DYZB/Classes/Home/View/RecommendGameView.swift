//
//  RecommendGameView.swift
//  DYZB
//
//  Created by libo on 2017/11/21.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit
private let GameCell = "GameCell"

class RecommendGameView: UIView {
    
    //MARK：定义数据
    var anchorGroups :[BaseModel]?{
        
        didSet{
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //移除autoresizingMARK
        autoresizingMask = .init(rawValue: 0)
      
        collectionView.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: GameCell)
        
    }
}

extension RecommendGameView{
  class   func recommendGame() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}


extension RecommendGameView:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorGroups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell, for: indexPath) as! GameCollectionViewCell
      
        
        cell.group = anchorGroups?[indexPath.row]
        
        return cell
        
    }
    
    
}
