//
//  BaseAnchorViewController.swift
//  DYZB
//
//  Created by libo on 2017/11/23.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit
private let KItemMargin:CGFloat = 10
let KNormalW = (KScreenW - 3 * KItemMargin) / 2
let KNormalH = KNormalW * 3 / 4
let KPrettyItem = KNormalW * 4 / 3
let KCycleViewH :CGFloat = KScreenW * 3 / 8

private let KGameViewH :CGFloat = 90
private let KHeaderH : CGFloat = 50
let KNormalCellID = "KNormalCellID"
let KPrettyID = "KPrettyID"
private let KHeaderViewID = "KHeaderViewID"
class BaseAnchorViewController: BaseViewController {
  //定义属性
    var baseVM :BaseViewModel!
     lazy var collectionView :UICollectionView = {[unowned self] in
        //1.创建布局
        let layout  = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: KNormalW, height: KNormalH)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }

}


extension BaseAnchorViewController{
     override func setupUI(){
        //1.给父类中的contentView引用赋值
        contentView = collectionView
        //2.添加collectionView
         view.addSubview(collectionView)
        //3.调用父类
        super.setupUI()
    }
}

extension BaseAnchorViewController{
    
   @objc func loadData(){
        print("草泥马--调用了")
      }
}

extension BaseAnchorViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCellID, for: indexPath) as! CollectionViewNormalCell
        
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        headerView.group = baseVM.anchorGroups[indexPath.section]
        return headerView
    }
}
