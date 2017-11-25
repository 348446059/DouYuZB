//
//  FunnyViewController.swift
//  DYZB
//
//  Created by libo on 2017/11/24.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit
private let KTopMargin:CGFloat = 8
class FunnyViewController: BaseAnchorViewController {
    fileprivate lazy var funnyVM = FunnyModel()
}

extension FunnyViewController{
    override func loadData() {
        ///Users/user/Desktop/DouYuZB/DYZB/DYZB.xcodeproj1.给父类的model赋值
        baseVM = funnyVM
        
        funnyVM.loadFunnyData {
            self.collectionView.reloadData()
            self.loaddateFinished()
        }
        
    }
}
extension FunnyViewController{
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: KTopMargin, left: 0, bottom: 0, right: 0)
        
        
    }
}





























