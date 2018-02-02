//
//  WalletModel.swift
//  GC
//
//  Created by hzg on 2018/2/2.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 3.10积分钱包
class WalletResultModel: BaseResultModel {
    
    var data = [WalletModel]()
    
    /// 指定数组元素类型
    override class func mj_objectClassInArray() -> [AnyHashable: Any]! {
        return ["data" : WalletModel.self]
    }
}

class WalletModel : NSObject {
    
    var id = 0
    
    var tel = ""
    
    var dealerId = 0
    
    /// 商家名
    var dealerName = ""
    
    /// 商家logo
    var dealerLogo = ""
    
    ///
    var memberDeaName = ""
    
    /// 余额
    var balance = 0
}
