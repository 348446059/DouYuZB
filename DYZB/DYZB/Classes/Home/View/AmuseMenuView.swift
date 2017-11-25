//
//  AmuseMenuView.swift
//  DYZB
//
//  Created by libo on 2017/11/23.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit
private let KMenuViewCell = "KMenuViewCell"
class AmuseMenuView: UIView {
    var groups : [AnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!


    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "AmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: KMenuViewCell)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = collectionView.bounds.size
        
    }
}

extension AmuseMenuView{
    class func amuseMenView() ->AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}


extension AmuseMenuView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if groups == nil {
            return 0
        }
        let pageNum = (groups!.count - 1)/8 + 1
        pageControl.numberOfPages = pageNum
        
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KMenuViewCell, for: indexPath) as! AmuseMenuViewCell
       setupCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
        
    }
    
    private func setupCellDataWithCell(cell:AmuseMenuViewCell,indexPath:IndexPath){
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        
        cell.group = Array(groups![startIndex...endIndex])
    }
    
}

extension AmuseMenuView:UICollectionViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int((scrollView.contentOffset.x) / scrollView.bounds.width) 
        
    }
}














