//
//  BaseViewController.swift
//  DYZB
//
//  Created by libo on 2017/11/24.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
   //子类的collectionView
    var contentView :UIView?
    
    fileprivate lazy var animationImageView : UIImageView = { [unowned self] in
       let imageView = UIImageView(image: #imageLiteral(resourceName: "img_loading_1"))
        imageView.center = self.view.center
        
        imageView.animationImages = [#imageLiteral(resourceName: "img_loading_1"),#imageLiteral(resourceName: "img_loading_2")]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        
        
       return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension BaseViewController{
   @objc func setupUI()  {
    
       //1.隐藏内容
        contentView?.isHidden = true
    
       //2.添加执行动画的imageView
        view.addSubview(animationImageView)
    
       //3.开始动画
        animationImageView.startAnimating()
    
       //4.设置view的背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
   @objc func loaddateFinished()  {
        //1.停止动画
        animationImageView.stopAnimating()
        //2.隐藏animationImage
        animationImageView.isHidden = true
        
        //3.显示collecion
        contentView?.isHidden = false
    }
}














