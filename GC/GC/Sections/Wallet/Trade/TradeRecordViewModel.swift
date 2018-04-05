//
//  TradeRecordModel.swift
//  GC
//
//  Created by Sunny on 2018/4/5.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class TradeRecordViewModel: BaseViewModel {
    
    var tradeRecordModel = TradeRecordResultModel()

    /// 通过区块链查看捐赠总额
    func getContributionNum(dealerPublicKey: String, memberPublicKey: String) {
        let reqeustModel = TradeRecordRequestModel()
        reqeustModel.dealerPublicKey = dealerPublicKey
        reqeustModel.memberPublicKey = memberPublicKey
        HTTPSessionManager.shared.request(urlString: NetworkURL.getContributeNum.url, parameters: reqeustModel.mj_keyValues()) { (json, success) in
            let resultModel = TradeRecordResultModel.mj_object(withKeyValues: json)
            if success && resultModel != nil && resultModel!.code == 0 {
                self.tradeRecordModel = resultModel!
                self.successCallback?(resultModel!)
            } else {
                let msg = resultModel != nil ? resultModel!.msg : "error"
                Log.e(msg)
                self.failureCallback?(msg)
            }
        }
    }
}
