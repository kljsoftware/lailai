//
//  DonateRecordModel.swift
//  GC
//
//  Created by hzg on 2018/2/6.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 请求模型
class DonateRecordRequestModel : BaseRequestModel {
    
    /// 商家id
    var id = 0
    
    /// 第几页 从0开始
    var page = 0
    
    /// 每页显示数
    var size = 0
}

/// 结果模型
class DonateRecordResultModel : BaseResultModel {
    
    /// 是否有更多页
    var has_more = true
    
    var recordItems = [DonateRecordModel]()
    
    /// 指定数组元素类型
    override class func mj_objectClassInArray() -> [AnyHashable: Any]! {
        return ["recordItems" : DonateRecordModel.self]
    }
}

/// 捐赠记录模型
class DonateRecordModel : NSObject {
   
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
    
    /// 捐赠时间
    var create_date:Double = 0
    
    /// 区块链id
    var blockchain_id = 0
}
