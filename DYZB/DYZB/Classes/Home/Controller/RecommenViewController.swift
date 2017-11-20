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
private let KHeaderH : CGFloat = 50

private let KNormalCellID = "KNormalCellID"
private let KPrettyID = "KPrettyID"
private let KHeaderViewID = "KHeaderViewID"

class RecommenViewController: UIViewController {

    //懒加载
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
    //MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //设置UI界面
        setupUI()
        
      
       
    }

  

}


//MARK 设置UI界面
extension RecommenViewController{
    
    private func setupUI()  {
        
        view.addSubview(collectionView)
    }
    
}


//MARK:dataSource协议
extension RecommenViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0  {
            return 8
        }
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell :UICollectionViewCell!
        
        if indexPath.section == 1 {
             cell = collectionView.dequeueReusableCell(withReuseIdentifier: KPrettyID, for: indexPath)
        }else{
         cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCellID, for: indexPath)
            
        }
       
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderViewID, for: indexPath)
    
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






















