//
//  RecommenViewModel.swift
//  DYZB
//
//  Created by libo on 2017/11/20.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit

class RecommenViewModel {
//MARK：懒加载属性
     lazy var anchorGroups = [AnchorGroup]()
     lazy var cycleModels = [CycleModel]()
    private lazy var bigDataGroup = AnchorGroup()
    private lazy var prettyGroup = AnchorGroup()
    
}

//MARK:-发送网络请求
extension RecommenViewModel{
    //请求推荐数据
    func requestData( finishedCallback:@escaping ()->Void)  {
        //1.定义参数
         let parameters = ["limite":"4", "offset":"0", "time" : NSDate.getCurrentTime()]
       //2.创建Group组任务
        let group = DispatchGroup.init()
        
        group.enter()
        //1.请求推荐数据
        NetworkTools.requestData(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", params: ["time":NSDate.getCurrentTime()]) { (result) in
            //1.将result转为字典
            guard  let resultDict = result as? [String:NSObject] else{
                return
            }
            //2.根据data的key 获取数据
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else{
                return
            }
            
            //3 遍历字典 转为模型
            //3.1 创建组
            self.bigDataGroup = AnchorGroup()
            //3.2 设置属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for item in dataArray{
                let anchor = AnchorModel(dict: item)
                self.bigDataGroup.anchors.append(anchor)
            }
            group.leave()
        }
        
        //2.请求第二部分颜值数据
        group.enter()
        NetworkTools.requestData(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", params: parameters) { (result) in
            //1.将result转为字典
            guard  let resultDict = result as? [String:NSObject] else{
                return
            }
            //2.根据data的key 获取数据
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else{
                return
            }
            //3 遍历字典 转为模型
              //3.1 创建组
           self.prettyGroup = AnchorGroup()
            //3.2 设置属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            //3.3主播数据
            for item in dataArray{
                let anchor = AnchorModel(dict: item)
                self.prettyGroup.anchors.append(anchor)
            }
            group.leave()
        }
        //3.请求2-12后面部分的游戏数据
       group.enter()
        NetworkTools.requestData(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getHotCate", params: parameters) { (result) in
            //print(result)
            //1.将result转为字典
            guard  let resultDict = result as? [String:NSObject] else{
                return
            }
            //2.根据data的key 获取数据
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else{
                return
            }
            
            //3.便利数组
            for item in dataArray{
                let anchor = AnchorGroup(dict: item)
                self.anchorGroups.append(anchor)
            }
            for item in self.anchorGroups{
                for anchor in item.anchors{
                    print(anchor.nickname)
                }
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
           
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishedCallback()
        }
        
    }
   
    //请求无限轮播的数据
    func requestCycleDate(finishedCallBack: @escaping ()->Void) {
        NetworkTools.requestData(type: .GET, url: "http://www.douyutv.com/api/v1/slide/6", params: ["version" : "2.300"]) { (result) in
            guard let resultDict = result as? [String:NSObject] else{
                return
            }
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {
                return
            }
            
            for item in dataArray{
                let model = CycleModel(dict: item)
                self.cycleModels.append(model)
            }
            
            finishedCallBack()
        }
    }
}





















