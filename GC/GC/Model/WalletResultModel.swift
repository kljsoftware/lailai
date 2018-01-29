//
//  WalletResultModel.swift
//  GC
//
//  Created by hzg on 2018/1/29.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

/// 积分钱包模型
class WalletResultModel: NSObject {
    
    // 条幅广告
    var banners = [String]()
    
    // 个人捐赠记录
    var personalDonate = PersonalDonateModel()
    
    // 积分捐赠
    var donates = [WalletDonateModel]()
    
    /// 指定数组元素类型
    override class func mj_objectClassInArray() -> [AnyHashable: Any]! {
        return ["donates" : WalletDonateModel.self]
    }
}

/// 个人捐赠记录
class PersonalDonateModel : NSObject {
    
    /// 头像
    var avatar = ""
    
    /// 名字
    var name = ""
    
    /// 成就
    var achievement = ""
    
    /// 捐赠总积分
    var totalDonatePoints = ""
    
    /// 捐赠积分种类数
    var donatePointsCount = 0
}

/// 积分捐赠
class WalletDonateModel : NSObject {
    
    /// 背景颜色
    var bgColor = ""
    
    /// 要捐赠商家的名
    var businessName = ""
  
    /// 要捐赠商家的图标
    var businessIcon = ""
    
    /// 捐赠额
    var donatePoints = ""
    
    /// 捐赠人/商家
    var donator = ""
}
