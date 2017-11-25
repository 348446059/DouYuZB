//
//  SamDashView.swift
//  DYZB
//
//  Created by libo on 2017/11/25.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit

//表盘指针
class SamIndicatorView: UIView {
    public var color = UIColor.red {
        didSet{
            self.setNeedsLayout()
        }
    }
    
    convenience  init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawLongLineWithRect(rect: rect)
        drawShortLineWithRect(rect: rect)
        drawRoundWithRect(rect: rect)
    }
    
}

extension SamIndicatorView{
  
    //绘制较长的那条线
  private  func drawLongLineWithRect(rect:CGRect){
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.clear.cgColor)
        context?.setStrokeColor(color.cgColor)
        
        context?.setLineWidth(1)
        context?.move(to: CGPoint(x: 0, y: rect.height / 2.0))
        context?.addLine(to: CGPoint(x: rect.width * 2.0 / 3.0, y: rect.height / 2.0))
        context?.drawPath(using: CGPathDrawingMode.fillStroke)
        context?.strokePath()
    }
    
    //绘制较短的那条线
    private func drawShortLineWithRect(rect:CGRect){
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.clear.cgColor)
        context?.setStrokeColor(color.cgColor)
        
        context?.setLineWidth(2)
        context?.setLineCap(.round)
        context?.move(to: CGPoint(x: rect.width * 2.0 / 3.0, y: rect.height / 2.0))
        context?.addLine(to: CGPoint(x: rect.width - 12, y: rect.height / 2.0))
        context?.drawPath(using: .fillStroke)
        context?.strokePath()
    }
    
    //绘制小圆及边缘阴影
    func drawRoundWithRect(rect:CGRect)  {
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.clear.cgColor)
        context?.setStrokeColor(color.cgColor)
        
        context?.setLineWidth(2)
        context?.addArc(center: CGPoint(x: rect.width - 8, y: rect.height / 2.0), radius: 4, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        
        context?.setStrokeColor(color.withAlphaComponent(0.5).cgColor)
        context?.addArc(center: CGPoint(x: rect.width - 8, y: rect.height / 2.0), radius: 6, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        context?.strokePath()
    }
    
}
