//
//  RecommenCycle.swift
//  DYZB
//
//  Created by libo on 2017/11/21.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit
private let KCycleCell = "KCycleCell"
class RecommenCycle: UIView {

    var cycleTimer :Timer?
    
    var cyclesModels :[CycleModel]?{
        didSet{
            //1.刷新collection
            collectionView.reloadData()
            //2.设置pageControl
            pageControl.numberOfPages = cyclesModels?.count ?? 0
            
            //3.默认滚动到中间某个位置
            let indexPath = IndexPath(item: (cyclesModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            //4添加定时器
            removetimer()
            addTimer()
        }
    }
    
    
    //控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = .init(rawValue: 0)
        
        //注册cell
        collectionView.register(UINib(nibName: "CycleViewCell", bundle: nil), forCellWithReuseIdentifier: KCycleCell)
        
        
        
    }
    
    override func layoutSubviews() {
        //设置collectionViewlayout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        
        
    }
   

}

extension RecommenCycle{
 class func recommendCycleView() -> RecommenCycle {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommenCycle
    }
}


extension RecommenCycle:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cyclesModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KCycleCell, for: indexPath) as! CycleViewCell
         
        let cycleModel = cyclesModels![indexPath.row % cyclesModels!.count]
        
         cell.cycleModel = cycleModel
        
        return cell
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        //2.计算pageControl的index
        pageControl.currentPage = Int(offsetX /  scrollView.bounds.width) % (cyclesModels?.count ?? 1)
        
        
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removetimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
    
}

//MARK:-定时器方法
extension RecommenCycle{
    
    private func addTimer(){
        cycleTimer = Timer(timeInterval: 2.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.current.add(cycleTimer!, forMode: .commonModes)
    }
    
    private func removetimer(){
        cycleTimer?.invalidate() //运行循环中移除
        cycleTimer = nil
    }
    
    @objc func scrollToNext() {
        //1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        //2.滚动到该位置
        
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
    }
}


