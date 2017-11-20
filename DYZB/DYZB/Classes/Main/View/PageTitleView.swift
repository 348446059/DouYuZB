//
//  PageTitleView.swift
//  DYZB
//
//  Created by libo on 2017/11/19.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit

//MARK--定义协议
protocol PageTitleViewDelegate:class {
    func pageTitleView(titleView:PageTitleView,selecttedIndex index:Int)
}

//定义常量
private let KScrollLineH:CGFloat = 2.0
private let KNormalColor:(CGFloat,CGFloat,CGFloat) = (85,85,85)
private let KSelectedColor:(CGFloat,CGFloat,CGFloat) = (255,128,0)

class PageTitleView: UIView {
    //MARK:--定义属性
    private var currentIndex:Int = 0
    var titles: [String]
    lazy var titleLables:[UILabel] = [UILabel]()
    
    
    weak var delegate:PageTitleViewDelegate?
    lazy var scorllView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        return scrollView
    }()
    
    lazy var scrollViewLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    //MARK:自定义构造函数
    init(frame:CGRect,titles:[String]) {
        
      //  self.backgroundColor = UIColor.orange
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init error")
    }

}

extension PageTitleView{
    
    private func setupUI(){
        //1.添加scrollView
        addSubview(scorllView)
     
        scorllView.frame = bounds
        
        //2.添加titles对应的label
        setupTitleLabels()
        
        //3,设置底线和滑块
        setupBottomMenuAndScrollLine()
    }
    
    private func setupTitleLabels(){
        
        //0.确定label的frame
        let labelW = frame.width / CGFloat(titles.count)
        let labelH = frame.height - KScrollLineH
        let labelY = CGFloat( 0.0)
        for (index,title) in titles.enumerated() {
            //1.创建UILabel
            let label = UILabel()
            
            //2.设置属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: KNormalColor.0, g: KNormalColor.1, b: KNormalColor.2)
            
            label.textAlignment = .center
            
            //3.设置frame
            
            let labelX = labelW * CGFloat(index)
            
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scorllView.addSubview(label)
            titleLables.append(label)
            
            //4.添加手势
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tap:)))
            label.addGestureRecognizer(tap)
        }
    }
    
    private func setupBottomMenuAndScrollLine(){
        //1.添加底线
        let line = UIView()
        line.backgroundColor = UIColor.lightGray
        let lineH = CGFloat(0.5)
         line.frame = CGRect(x: 0.0, y: frame.height - lineH, width: frame.width, height: lineH)
       addSubview(line)
        
        //2.添加scrollLine
        //2.1获取第一个label
        guard  let firstLabel = titleLables.first else {
            return
        }
        firstLabel.textColor = UIColor(r: KSelectedColor.0, g: KSelectedColor.1, b: KSelectedColor.2)
        scorllView.addSubview(scrollViewLine)
        scrollViewLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - KScrollLineH, width: firstLabel.frame.width, height: KScrollLineH)
    }
}


extension PageTitleView {
    @objc private func titleLabelClick(tap:UITapGestureRecognizer){
        //1.获取当前label的下标值
        guard let currentLabel = tap.view as? UILabel else {
            return
        }
        if currentIndex == currentLabel.tag { return }
        
        //2.获取之前的label
        let oldLabel = titleLables[currentIndex]
        
        
        //3.切换文字的颜色
        currentLabel.textColor = UIColor(r: KSelectedColor.0, g: KSelectedColor.1, b: KSelectedColor.2)
        oldLabel.textColor = UIColor(r: KNormalColor.0, g: KNormalColor.1, b: KNormalColor.2)
        
        //4.保存最新label的下标值
        currentIndex = currentLabel.tag
        
        //5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollViewLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollViewLine.frame.origin.x = scrollLineX
        }
        
        //6.通知代理
        delegate?.pageTitleView(titleView: self, selecttedIndex: currentIndex)
    }
}

//MARK:--对外暴露的方法
extension PageTitleView{
    
    func setTitleWithProgress(progress:CGFloat,targetIndex:Int,sourceIndex:Int)  {
        //1.取出label
        let sourceLabel = titleLables[sourceIndex]
        let targetLabel = titleLables[targetIndex]
        
        //2.处理滑块
        let moveX = (targetLabel.frame.origin.x - sourceLabel.frame.origin.x) * progress
        scrollViewLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3.颜色的渐变
        //3.1取出变化的范围
        let colorDelta = (KSelectedColor.0 - KNormalColor.0,KSelectedColor.1 - KNormalColor.1,KSelectedColor.2 - KNormalColor.2)
        
        //3.2 变化souceLabel
        sourceLabel.textColor = UIColor(r: KSelectedColor.0 - colorDelta.0 * progress, g: KSelectedColor.1 - colorDelta.1 * progress, b: KSelectedColor.2 - colorDelta.2 * progress)
        
        //3.3变化targetLabel
        targetLabel.textColor = UIColor(r: KNormalColor.0 + colorDelta.0 * progress, g: KNormalColor.1 + colorDelta.1 * progress, b: KNormalColor.2 + colorDelta.2 * progress)
        
        //4.记录最新的currentIndex
        currentIndex = targetIndex
    }
}


















