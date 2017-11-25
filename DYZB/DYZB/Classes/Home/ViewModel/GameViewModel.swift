//
//  GameViewModel.swift
//  DYZB
//
//  Created by libo on 2017/11/22.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit

class GameViewModel {

    var games = [GameModel]()
    
}


extension GameViewModel{
    func loadAllGameData(finishedcallback: @escaping ()->Void)  {
        NetworkTools.requestData(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getColumnDetail", params: ["shortName":"game"]) { (result) in
           guard let resultDict = result as? [String:Any] else {
                return
            }
            guard let dataArray = resultDict["data"] as? [[String:Any]] else{
                return
            }
            
            //字典转模型
            for dict in dataArray{
                self.games.append(GameModel(dict: dict))
            }
            
            finishedcallback()
        }
    }
    
}







