//
//  TradeRecordModel.swift
//  GC
//
//  Created by Sunny on 2018/4/5.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

/// 请求模型
class TradeRecordRequestModel : BaseRequestModel {
    
    /// 商家公钥
    var dealerPublicKey = ""
    
    /// 会员公钥
    var memberPublicKey = ""
}

/// 请求结果
class TradeRecordResultModel: BaseResultModel {
    
    /// 捐赠总额
    var num = 0
}
