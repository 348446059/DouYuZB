//
//  DashViewController.swift
//  DYZB
//
//  Created by libo on 2017/11/25.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit

class DashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       self.view.backgroundColor = UIColor.black
        let dashboardView = SamDashBoardView(frame: CGRect(x: (UIScreen.main.bounds.size.width - 300) / 2.0, y: 200, width: 300, height: 150))
        dashboardView.gradientColors = [UIColor.green, UIColor.orange, UIColor.red]
        dashboardView.needleColor = UIColor.white
        dashboardView.shortScaleColor = UIColor.white.withAlphaComponent(0.6)
        dashboardView.shortScales = 5
        dashboardView.longScales = 11
        dashboardView.longScaleColor = UIColor.white
        dashboardView.longScaleTexts = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        
        dashboardView.scale = 0.6
        self.view.addSubview(dashboardView)
        
        
    }

   
}
