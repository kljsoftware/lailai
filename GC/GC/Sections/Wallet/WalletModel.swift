//
//  WalletModel.swift
//  GC
//
//  Created by hzg on 2018/2/2.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 3.1 获取积分钱包基础数据
class WalletBaseResultModel : BaseResultModel {
    
    /// 用户信息
    var userInfo = WalletUserInfoModel()
    
    /// 广告信息
    var adItems = [AdModel]()
    
    /// 指定数组元素类型
    override class func mj_objectClassInArray() -> [AnyHashable: Any]! {
        return ["adItems" : AdModel.self]
    }
}

/// 用户信息
class WalletUserInfoModel : NSObject {
    var name  = "" // 用户名
    var breed = 0  // 积分种类
    var integralSum =  0  // 捐赠积分数量
    var avatar = ""       //头像图片地址
    var rank = ""         //捐赠级别称号
}

/// 广告模型
class AdModel : NSObject {
    var cover = ""  // 广告图片
    var link  = ""   // 广告页点击要跳转的网址
}

/// 3.2 获取积分钱包商家数据
class WalletResultModel: BaseResultModel {
    
    var has_more = true
    var shopItems = [WalletModel]()
    
    /// 指定数组元素类型
    override class func mj_objectClassInArray() -> [AnyHashable: Any]! {
        return ["shopItems" : WalletModel.self]
    }
}

class WalletModel : NSObject {
    
    /// 商家id
    var id = 0
    
    /// 商家logo
    var logo = ""
    
    /// 商家名
    var name = ""
    
    /// 用户在该商家注册的昵称
    var memberDeaName = ""
    
    /// 余额
    var balance = 0
    
    /// 商家颜色
    var color = ""
}
