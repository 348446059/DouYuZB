//
//  RecommenViewController.swift
//  DYZB
//
//  Created by libo on 2017/11/20.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit
private let KItemMargin:CGFloat = 10
private let KItemW = (KScreenW - 3 * KItemMargin) / 2
private let KItemH = KItemW * 3 / 4
private let KPrettyItem = KItemW * 4 / 3
private let KCycleViewH :CGFloat = KScreenW * 3 / 8
private let KGameViewH :CGFloat = 90
private let KHeaderH : CGFloat = 50

private let KNormalCellID = "KNormalCellID"
private let KPrettyID = "KPrettyID"
private let KHeaderViewID = "KHeaderViewID"

class RecommenViewController: UIViewController {

    
    
    //懒加载
    
    private lazy var recommenVM = RecommenViewModel()
    private lazy var collectionView :UICollectionView = {[unowned self] in
        //1.创建布局
        let layout  = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: KItemW, height: KItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = KItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: KItemMargin, bottom: 0, right: KItemMargin)
        layout.headerReferenceSize = CGSize(width: KScreenW, height: KHeaderH)
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
         collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
      
        collectionView.register( UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderViewID)
        
        collectionView.register( UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: KNormalCellID)
        collectionView.register( UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: KPrettyID)
        return collectionView
    }()
    
    //轮播collectionView
    private lazy var cycleView = { () -> RecommenCycle in
        let cycleView = RecommenCycle.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(KCycleViewH + KGameViewH), width: KScreenW, height: KCycleViewH)
        return cycleView
    }()
    //游戏推荐collectionView
    private lazy var gameView:RecommendGameView = {
        let recommendGameView = RecommendGameView.recommendGame()
        recommendGameView.frame = CGRect(x: 0, y: -KGameViewH, width: KScreenW, height: 90.0)
        return recommendGameView
    }()
    //MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //设置UI界面
        setupUI()
        
        //发送网络请求
         loadData()
    }

  

}


//MARK 设置UI界面
extension RecommenViewController{
    
    private func setupUI()  {
        //1.添加列表view
        view.addSubview(collectionView)
        
        //2.添加cycleView
        collectionView.addSubview(cycleView)
        
        //3.添加gameView
        collectionView.addSubview(gameView)
        
        //4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: KCycleViewH + KGameViewH, left: 0, bottom: 0, right: 0)
        
       
    }
    
}

extension RecommenViewController{
    private func loadData(){
        //1.发送推荐数据
        recommenVM.requestData {
            //1 展示推荐数据
            self.collectionView.reloadData()
            //2 展示gameView数据
            self.gameView.anchorGroups = self.recommenVM.anchorGroups
        }
        
        //2.请求轮播数据
        recommenVM.requestCycleDate {
            self.cycleView.cyclesModels = self.recommenVM.cycleModels
        }
    }
}
//MARK:dataSource协议
extension RecommenViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommenVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommenVM.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //0.取出组
        let group = recommenVM.anchorGroups[indexPath.section]
        let item = group.anchors[indexPath.row]
        
        
        let cell :BaseCollectionViewCell!
        
        
        if indexPath.section == 1 {
          cell = collectionView.dequeueReusableCell(withReuseIdentifier: KPrettyID, for: indexPath) as! CollectionViewPrettyCell
            
            
        }else{
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCellID, for: indexPath) as! CollectionViewNormalCell
            
        }
       
        
        cell.anchor = item
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderViewID, for: indexPath) as! CollectionHeaderView
    
        headerView.group = recommenVM.anchorGroups[indexPath.section]
        
        
        return headerView
    }
    
    
}

extension RecommenViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: KItemW, height: KPrettyItem)
        }
        return CGSize(width: KItemW, height: KItemH)
    }
    
}






















