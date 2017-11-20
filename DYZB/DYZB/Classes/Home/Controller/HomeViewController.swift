//
//  HomeViewController.swift
//  DYZB
//
//  Created by libo on 2017/11/19.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit

private let KTitleViewH = 40.0

class HomeViewController: UIViewController {
    //MARK:-懒加载属性
    private lazy var pageTitleView:PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0.0, y: KNavigationBarH, width: Double(KScreenW), height: KTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView : PageContentView = { [weak self] in
        //1.确定内容的frame
        let contentH = KScreenH  - CGFloat(KNavigationBarH)  - CGFloat(KTitleViewH) - CGFloat(KTabbarH)
        let contentViewframe = CGRect(x: 0.0, y: CGFloat(KNavigationBarH) + CGFloat(KTitleViewH), width: KScreenW, height: contentH)
        //2.确定所有的子控制器
        var childVCs = [UIViewController]()
        childVCs.append(RecommenViewController())
        for _ in 0...2{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(vc)
        }
        let contentView = PageContentView(frame: contentViewframe, childVCs: childVCs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // Do any additional setup after loading the view.
        
    }

}

//MARK:设置UI界面
extension HomeViewController{
  private  func setupUI()  {
         //0.不需要调整UIScrollView的内边距
    automaticallyAdjustsScrollViewInsets = false
    //1.设置导航栏
    setupNavigationBar()
    //2.添加titleView
       view.addSubview(pageTitleView)
    //3.添加ContentView
    view.addSubview(pageContentView)
    }
    
  private  func setupNavigationBar()  {
    //设置左侧按钮
    navigationItem.leftBarButtonItem = UIBarButtonItem("logo")
    //设置右侧按钮
     let size = CGSize(width: 40.0, height: 40.0)
    let histroyItem = UIBarButtonItem("image_my_history", hightImageName: "image_my_history_click", size: size)
    let searchItem = UIBarButtonItem("btn_search", hightImageName: "btn_search_click", size: size)
    let qrcodeItem = UIBarButtonItem("Image_scan", hightImageName: "Image_scan_click", size: size)
    
    navigationItem.rightBarButtonItems = [histroyItem,searchItem,qrcodeItem]
    }
}

//MARK:-遵守pageTitleView的代理
extension HomeViewController:PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selecttedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

extension HomeViewController:PageContentViewDelegate{
    
    func pageContentView(contentView: PageContentView, progress: CGFloat, targetIndex: Int, SourceIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, targetIndex: targetIndex, sourceIndex: SourceIndex)
    }
    
}


















