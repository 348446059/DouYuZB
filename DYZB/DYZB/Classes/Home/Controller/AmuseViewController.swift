//
//  AmuseViewController.swift
//  DYZB
//
//  Created by libo on 2017/11/23.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit
private let KMenuViewH:CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    fileprivate lazy var amuseVM = AmuseViewModel()
    fileprivate lazy var amuseMenuView :AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenView()
        menuView.frame = CGRect(x: 0, y: -KMenuViewH, width: KScreenW, height: KMenuViewH)
        return menuView
    }()
    
}

//设置UI界面
extension AmuseViewController{
    override func setupUI() {
        super.setupUI()
        //将菜单view添加
        collectionView.addSubview(amuseMenuView)
        collectionView.contentInset = UIEdgeInsets(top: KMenuViewH, left: 0, bottom: 0, right: 0)
    }
}
extension AmuseViewController{
   
    override func loadData() {
       // super.loadData()
        //给父类的baseModel赋值
        baseVM = amuseVM
        //请求数据
        amuseVM.loadAmuseData {
           self.collectionView.reloadData()
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            
            self.amuseMenuView.groups = tempGroups
            
            self.loaddateFinished()
        }
    }
}













