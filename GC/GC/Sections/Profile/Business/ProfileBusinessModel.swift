//
//  ProfileBusinessModel.swift
//  GC
//
//  Created by Sunny on 2018/4/5.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

/// 请求数据
class ProfileBusinessRequestModel: BaseRequestModel {
    
    /// 第几页 从0开始
    var page = 0
    
    /// 每页显示数
    var size = 0
}

/// 请求结果
class ProfileBusinessResultModel: BaseResultModel {
    
    var has_more = true
    var data = [BusinessInfoModel]()
    
    /// 指定数组元素类型
    override class func mj_objectClassInArray() -> [AnyHashable: Any]! {
        return ["data" : BusinessInfoModel.self]
    }
}

/// 商家信息
class BusinessInfoModel: NSObject {
    
    /// 商家名称
    var dealerName = ""
    
    /// 用户在该商家的公钥地址
    var memberPublicKey = ""
    
}

