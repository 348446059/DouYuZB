//
//  PageContentView.swift
//  DYZB
//
//  Created by libo on 2017/11/20.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate:class {
 func pageContentView(contentView:PageContentView,progress:CGFloat,targetIndex:Int,SourceIndex:Int)
}

private let ContentCellID = "ContentCellID"
class PageContentView: UIView {
 
    //MARK:定义属性
    private var childVcs: [UIViewController]
    private weak var parentVC : UIViewController?
    weak var delegate:PageContentViewDelegate?
    private var startOffsetX:CGFloat = 0
    private var isForbidScroll = false
    
    //MARK:-懒加载属性
    private lazy var collectionView : UICollectionView =  { [weak self] in
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2.创建CollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
        }()
    
    
    //MARK:自定义构造函数
    init(frame: CGRect,childVCs:[UIViewController],parentViewController:UIViewController?) {
        self.childVcs = childVCs
        self.parentVC = parentViewController
        super.init(frame: frame)
        
        //1.设置UI
        setpageUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init error")
    }
}

extension PageContentView{
    
    private func setpageUI(){
        //1.将所有子控制器加到界面中
        for childVc in childVcs {
            parentVC?.addChildViewController(childVc)
        }
        
        //2.添加UIControllerView,用于在cell中存放控制器的View
        collectionView.frame = bounds
        addSubview(collectionView)
    }
}
//MARK:Delegate
extension PageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        //2.设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childVcs[indexPath.row]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        return cell
    }
}

extension PageContentView:UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
         isForbidScroll = false
        startOffsetX =  scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //0 判断是否是点击事件
        if isForbidScroll {
            return
        }
        
        //1.定义获取数据
        var progress:CGFloat = 0
        var sourceIndex:Int = 0
        var targetIndex:Int = 0
        
        //2.判断是左滑还是右
        let currentOffsetX = scrollView.contentOffset.x
          let scrollViewW = scrollView.frame.size.width
        if currentOffsetX > startOffsetX {
            //左滑
            //1.计算progress
            progress =  currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            //2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            //3,计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count - 1
            }
            //4.完全划过
            if currentOffsetX - startOffsetX == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else{
            //右滑
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            targetIndex = Int(currentOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childVcs.count{
                sourceIndex  = childVcs.count - 1
            }
        }
        
        //3.将值传递给titleView
        delegate?.pageContentView(contentView: self, progress: progress, targetIndex: targetIndex, SourceIndex: sourceIndex)
        
        
    }
}


//MARK:对外暴露的方法
extension PageContentView{
    func setCurrentIndex(currentIndex:Int)  {
        let offsetX = CGFloat(currentIndex) * collectionView.frame.size.width
        
        //1.记录需要禁止的代理方法
        isForbidScroll = true
        
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}



























