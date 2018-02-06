//
//  DonateModel.swift
//  GC
//
//  Created by hzg on 2018/2/6.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 6.1 获取公益捐赠列表
class DonateRequestModel : BaseRequestModel {
    var page = 0  // 第几页 从0开始
    var size = 10 // 每页显示数
}

class DonateReusltModel : BaseResultModel {
    var has_more = true
    var donationsItems = [DonationItemModel]()
    
    /// 指定数组元素类型
    override class func mj_objectClassInArray() -> [AnyHashable: Any]! {
        return ["donationsItems" : DonationItemModel.self]
    }
}

class DonationItemModel : NSObject {
    var id = 0 //捐赠id
    var orgName = "" //组织名称
    var cover = "" // 捐赠封面
    var title = "" // 标题
    var brief = "" // 简介
    var blockchain_id =  0  // 区块链id
}
