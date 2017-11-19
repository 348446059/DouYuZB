//
//  MainViewController.swift
//  DYZB
//
//  Created by libo on 2017/11/19.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC("Home")
        addChildVC("Live")
        addChildVC("Follow")
        addChildVC("Profile")
        
    }
    
    private func addChildVC(_ storyName:String){
        //1.通过storyboard获取控制器
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        //2.将childVC 作为子控制器
        addChildViewController(childVC)
    }

}
