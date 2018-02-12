//
//  BusinessViewModel.swift
//  GC
//
//  Created by hzg on 2018/2/1.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 绿色商家业务模块
class BusinessViewModel: BaseViewModel {
    
    var businessResultModel = BusinessResultModel()
    
    /// 获取绿色商家
    func getDealers(page:Int = 0, size:Int = 10) {
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
    func searchDealers(x:String = "", y:String = "", name:String = "", range:String = "", page:Int = 0, size:Int = 10) {
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
}
