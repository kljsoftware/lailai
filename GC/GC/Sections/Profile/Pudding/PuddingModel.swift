//
//  PuddingModel.swift
//  GC
//
//  Created by sunzhiwei on 2018/5/7.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

/// 请求数据
class PuddingRequestModel: BaseRequestModel {
    
    /// 第几页 从0开始
    var page = 0
    
    /// 每页显示数
    var size = 0
}


/// 请求结果
class PuddingResultModel: BaseResultModel {
    
    var has_more = true
    var puddingSum = 0  // 布丁总额
    var puddingRecordinfos = [PuddingRecordinfoModel]()
    
    /// 指定数组元素类型
    override class func mj_objectClassInArray() -> [AnyHashable: Any]! {
        return ["puddingRecordinfos" : PuddingRecordinfoModel.self]
    }
}

/// 布丁详情
class PuddingRecordinfoModel: NSObject {
    var puddingInfoid = 0           // 详情id
    var memberTel = ""              // 用户手机号
    var puddingNum = 0              // 布丁额
    var puddingType = 0             // 布丁变动类型 0增加 1减少
    var puddingAddress = ""         // 布丁来源或去向
    var puddingRatio: Float = 0.0   // 布丁兑比
    var memcpId = 0                 // 积分交易记录id
    var createdDate: Double = 0.0   // 创建时间

}
