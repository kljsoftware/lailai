//
//  BusinessViewModel.swift
//  GC
//
//  Created by hzg on 2018/2/1.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 绿色商家业务模块
class BusinessViewModel: BaseViewModel {
    
    var urlType: NetworkURL = .getDealers
    var showCurLocation: Bool = false
    var businessResultModel = BusinessResultModel()
    var businessBranchModel = BusinessResultModel()
    
    /// 获取绿色商家
    func getDealers(page: Int = 0, size: Int = 10) {
        urlType = .getDealers
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
        urlType = .searchDealers
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
        urlType = .getDealerAndBranch
        let reqModel = BusinessBranchRequestModel()
        reqModel.dealerId = dealerId
        HTTPSessionManager.shared.request(urlString: NetworkURL.getDealerAndBranch.url, parameters: reqModel.mj_keyValues()) { (json, success) in
            let resultModel = BusinessBranchResultModel.mj_object(withKeyValues: json)
            if success && resultModel != nil && resultModel!.code == 0 {
                self.businessBranchModel.data.removeAll()
                for model in resultModel!.data {
                    let businessModel = BusinessModel()
                    businessModel.dealerId = model.dealerId
                    businessModel.logo = model.logo
                    businessModel.dealerName = model.dealerName
                    businessModel.address = model.address
                    businessModel.dealerTel = model.dealerTel
                    businessModel.coordinate = model.coordinate
                    businessModel.isBranch = true
                    self.businessBranchModel.data.append(businessModel)
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
