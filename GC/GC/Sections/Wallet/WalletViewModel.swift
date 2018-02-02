//
//  WalletViewModel.swift
//  GC
//
//  Created by hzg on 2018/2/1.
//  Copyright © 2018年 demo. All rights reserved.
//

class WalletViewModel: BaseViewModel {

    /// 积分捐赠模型
    var walletModel = WalletResultModel()
    
    /// 积分捐赠
    func getPoints() {
        HTTPSessionManager.shared.request(urlString: NetworkURL.getPoints.url, parameters: nil) { (json, success) in
            let resultModel = WalletResultModel.mj_object(withKeyValues: json)
            if success && resultModel != nil && resultModel!.code == 0 {
                self.walletModel = resultModel!
                self.successCallback?(resultModel!)
            } else {
                self.failureCallback?("error")
            }
        }
    }
    
}
