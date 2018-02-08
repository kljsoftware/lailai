//
//  GeneralModel.swift
//  GC
//
//  Created by hzg on 2018/2/8.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 8.1 获取区块链信息
class BlockChainRequestModel : BaseRequestModel {
    var id = 0 /// 区块链id
}

class BlockChainResultModel : BaseResultModel {
    var publicKey = ""     //公钥
    var privateKey = ""     //私钥
}
