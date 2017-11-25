//
//  GameViewController.swift
//  DYZB
//
//  Created by libo on 2017/11/22.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit
private let KEdgeMargin:CGFloat = 10
private let KItemW:CGFloat = (KScreenW - 2 * KEdgeMargin) / 3
private let kItemH:CGFloat = KItemW * 6 / 5
private let KGameCellID = "KGameCellID"
private let KGameHeaderID = "KGameHeaderID"
private let KHeaderViewH:CGFloat = 50
private let KGameViewH : CGFloat = 90

class GameViewController: BaseViewController {
    
    fileprivate lazy var gameVM = GameViewModel()
    
    fileprivate lazy var topHeaderView : CollectionHeaderView = {
        let headerView = CollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(KHeaderViewH + KGameViewH), width: KScreenW, height: KHeaderViewH)
        headerView.iconImageView.image = #imageLiteral(resourceName: "Img_orange")
        headerView.titleLabel.text = "常用"
        headerView.moreBtn.isHidden = true
        return headerView
    }()
    //MARK:属性
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
        //创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: KItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, KEdgeMargin, 0, KEdgeMargin)
        layout.headerReferenceSize =  CGSize(width: KScreenW, height: KHeaderViewH)
        
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        collectionView.register( UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: KGameCellID)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
         collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KGameHeaderID)
        return collectionView
        }()

    
    fileprivate lazy var gameView:RecommendGameView = {
        let gameView = RecommendGameView.recommendGame()
        gameView.frame = CGRect(x: 0, y: -KGameViewH, width: KScreenW, height: KGameViewH)
        return gameView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupUI()
        loadData()
        
    }

   
}

extension GameViewController{
   override func setupUI()  {
    contentView = collectionView
    view.addSubview(collectionView)
    //1.添加headerView
    collectionView.addSubview(topHeaderView)
    
    collectionView.addSubview(gameView)
    
    //2.设置collectionView的内边距
    collectionView.contentInset = UIEdgeInsetsMake(KHeaderViewH + KGameViewH, 0, 0, 0)
    
    super.setupUI()
    }
}

extension GameViewController{
    
    fileprivate func loadData(){
       
        gameVM.loadAllGameData {
             //展示全部游戏
            self.collectionView.reloadData()
            
            //展示常用游戏
            self.gameView.anchorGroups = Array(self.gameVM.games[0...9])
      
            self.loaddateFinished()
         }
       
        
    }
    
    
    
}
extension GameViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KGameCellID, for: indexPath) as! GameCollectionViewCell
        
        
         cell.group = gameVM.games[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出header
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KGameHeaderID, for: indexPath) as! CollectionHeaderView
        
        //2.设置属性
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = #imageLiteral(resourceName: "Img_orange")
        headerView.moreBtn.isHidden = true
        
        
        
        return headerView
        
    }
    
}
























