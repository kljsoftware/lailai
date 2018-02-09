//
//  GeneralViewModel.swift
//  GC
//
//  Created by hzg on 2018/2/8.
//  Copyright © 2018年 demo. All rights reserved.
//

class GeneralViewModel: BaseViewModel {

    /// 8.1 获取区块链信息
    func getBlockChainInfo(id:String) {
        let reqModel = BlockChainRequestModel()
        reqModel.id = id
        HTTPSessionManager.shared.request(urlString: NetworkURL.getBlockChainInfo.url, parameters: reqModel.mj_keyValues()) { (json, success) in
            let resultModel = BlockChainResultModel.mj_object(withKeyValues: json)
            if success && resultModel != nil && resultModel!.code == 0 {
                self.successCallback?(resultModel!)
            } else {
                let msg = resultModel != nil ? resultModel!.msg : "error"
                Log.e(msg)
                self.failureCallback?(msg)
            }
        }
    }
}
