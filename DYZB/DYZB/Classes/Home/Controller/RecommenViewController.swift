//
//  RecommenViewController.swift
//  DYZB
//
//  Created by libo on 2017/11/20.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit


private let KGameViewH :CGFloat = 90
private let KHeaderH : CGFloat = 50



class RecommenViewController: BaseAnchorViewController {

    
    
    //懒加载
    
    private lazy var recommenVM = RecommenViewModel()
   
    
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
    
  

}


//MARK 设置UI界面
extension RecommenViewController{
    
  override  func setupUI()  {
    
        //1.调用super
        super.setupUI()
        
        //2.添加cycleView
        collectionView.addSubview(cycleView)
        
        //3.添加gameView
        collectionView.addSubview(gameView)
        
        //4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: KCycleViewH + KGameViewH, left: 0, bottom: 0, right: 0)
        
       
    }
    
}

extension RecommenViewController{
    override func loadData(){
         //0 给父类中的viewModel赋值
          baseVM = recommenVM
        
        //1.发送推荐数据
        recommenVM.requestData {
            //1 展示推荐数据
            self.collectionView.reloadData()
            //2 展示gameView数据
            var groups = self.recommenVM.anchorGroups
            
            //1.移除前两组数据
            groups.removeFirst()
            groups.removeFirst()
            
            //2.添加更多组
            let group = AnchorGroup()
            group.tag_name = "更多"
            groups.append(group)
            self.gameView.anchorGroups = groups
            
            self.loaddateFinished()
        }
        
        //2.请求轮播数据
        recommenVM.requestCycleDate {
            self.cycleView.cyclesModels = self.recommenVM.cycleModels
        }
    }
}


extension RecommenViewController:UICollectionViewDelegateFlowLayout{
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            //1.取出prettyCell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: KPrettyID, for: indexPath) as! CollectionViewPrettyCell
            
            // 2.设置数据
            prettyCell.anchor = recommenVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return prettyCell
            
        }else{
         return   super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            
            return CGSize(width: KNormalW, height: KPrettyItem)
        }
        return CGSize(width: KNormalW, height: KNormalH)
    }
    
}




















