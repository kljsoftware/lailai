//
//  DonateRecordViewModel.swift
//  GC
//
//  Created by hzg on 2018/2/8.
//  Copyright © 2018年 demo. All rights reserved.
//


// 3.3 获取用户在一个商家积分捐赠记录
class DonateRecordViewModel: BaseViewModel {
    
    var recordResultModel = DonateRecordResultModel()
    
    /// 积分捐赠
    func getContributionHistory(id:Int, page:Int = 0, size:Int = 10) {
        let reqeustModel = DonateRecordRequestModel()
        reqeustModel.id = id
        reqeustModel.page = page
        reqeustModel.size = size
        HTTPSessionManager.shared.request(urlString: NetworkURL.getContributionHistory.url, parameters: reqeustModel.mj_keyValues()) { (json, success) in
            let resultModel = DonateRecordResultModel.mj_object(withKeyValues: json)
            if success && resultModel != nil && resultModel!.code == 0 {
                self.recordResultModel = resultModel!
                self.successCallback?(resultModel!)
            } else {
                let msg = resultModel != nil ? resultModel!.msg : "error"
                Log.e(msg)
                self.failureCallback?(msg)
            }
        }
    }
}
