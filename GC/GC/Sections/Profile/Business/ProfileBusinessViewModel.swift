//
//  ProfileBusinessViewModel.swift
//  GC
//
//  Created by Sunny on 2018/4/5.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class ProfileBusinessViewModel: BaseViewModel {

    var profileBusinessModel = ProfileBusinessResultModel()
    
    var page = 0
    var isRefresh = true
    
    /// 通过区块链查看捐赠总额
    func getBusinessList() {
        let reqeustModel = ProfileBusinessRequestModel()
        reqeustModel.page = page
        reqeustModel.size = 20
        HTTPSessionManager.shared.request(urlString: NetworkURL.getDealerList.url, parameters: reqeustModel.mj_keyValues()) { (json, success) in
            let resultModel = ProfileBusinessResultModel.mj_object(withKeyValues: json)
            if success && resultModel != nil && resultModel!.code == 0 {
                if self.isRefresh {
                    self.profileBusinessModel.data.removeAll()
                    self.profileBusinessModel.data = resultModel!.data
                } else {
                    self.profileBusinessModel.data += resultModel!.data
                }
                self.profileBusinessModel.has_more = resultModel!.has_more
                self.successCallback?(self.profileBusinessModel)
            } else {
                let msg = resultModel != nil ? resultModel!.msg : "error"
                Log.e(msg)
                self.failureCallback?(msg)
            }
        }
    }
}
