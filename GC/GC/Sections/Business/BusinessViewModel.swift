//
//  BusinessViewModel.swift
//  GC
//
//  Created by hzg on 2018/2/1.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 绿色商家业务模块
class BusinessViewModel: BaseViewModel {
    
    var isBranch: Bool = false
    var showCurLocation: Bool = false
    var businessResultModel = BusinessResultModel()
    var businessBranchModel = BusinessResultModel()
    
    /// 获取绿色商家
    func getDealers(page: Int = 0, size: Int = 10) {
        isBranch = false
        let reqModel = BusinessRequestModel()
        reqModel.page = page
        reqModel.size = size
        HTTPSessionManager.shared.request(urlString: NetworkURL.getDealers.url, parameters: reqModel.mj_keyValues()) { (json, success) in
            let resultModel = BusinessResultModel.mj_object(withKeyValues: json)
            if success && resultModel != nil && resultModel!.code == 0 {
                self.businessResultModel = resultModel!
                self.successCallback?(resultModel!)
            } else {
                let msg = resultModel != nil ? resultModel!.msg : "error"
                Log.e(msg)
                self.failureCallback?(msg)
            }
        }
    }
    
    /// 4.2 搜索商家
    func searchDealers(x: String = "", y: String = "", name: String = "", range: String = "", page: Int = 0, size: Int = 10) {
        isBranch = false
        let reqModel = BusinessDealersRequestModel()
        reqModel.x = x
        reqModel.y = y
        reqModel.name = name
        reqModel.page = page
        reqModel.size = size
        HTTPSessionManager.shared.request(urlString: NetworkURL.searchDealers.url, parameters: reqModel.mj_keyValues()) { (json, success) in
            let resultModel = BusinessResultModel.mj_object(withKeyValues: json)
            if success && resultModel != nil && resultModel!.code == 0 {
                self.businessResultModel = resultModel!
                self.successCallback?(resultModel!)
            } else {
                let msg = resultModel != nil ? resultModel!.msg : "error"
                Log.e(msg)
                self.failureCallback?(msg)
            }
        }
    }
    
    /// 4.3 获取指定商家的分支
    func getDealerBranch(dealerId: Int) {
        isBranch = true
        let reqModel = BusinessBranchRequestModel()
        reqModel.dealerId = dealerId
        HTTPSessionManager.shared.request(urlString: NetworkURL.getDealerAndBranch.url, parameters: reqModel.mj_keyValues()) { (json, success) in
            let resultModel = BusinessResultModel.mj_object(withKeyValues: json)
            if success && resultModel != nil && resultModel!.code == 0 {
                self.businessBranchModel = resultModel!
                for model in self.businessBranchModel.data {
                    model.isBranch = true
                }
                self.successCallback?(resultModel!)
            } else {
                let msg = resultModel != nil ? resultModel!.msg : "error"
                Log.e(msg)
                self.failureCallback?(msg)
            }
        }
    }
}
