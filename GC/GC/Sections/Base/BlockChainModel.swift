//
//  BlockChainModel.swift
//  GC
//
//  Created by hzg on 2018/2/6.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 8.1 获取区块链信息

class BlockChainRequestModel : BaseRequestModel {
    var id = "" /// 区块链id
}

class BlockChainResultModel : BaseResultModel {
    var pulic = ""     //公钥
    var pri = ""     //私钥
    
    /// 将属性名换为其他key去字典中取值
    override class func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["private" : "pri"]
    }
}
