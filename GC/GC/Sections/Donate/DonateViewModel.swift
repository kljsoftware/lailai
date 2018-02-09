//
//  DonateViewModel.swift
//  GC
//
//  Created by hzg on 2018/2/9.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 业务模块
class DonateViewModel: BaseViewModel {
    
    var donationsItems = [DonationItemModel]()
    
    func getDonations(page:Int = 0, size:Int = 10) {
        let reqeustModel = DonateRequestModel()
        reqeustModel.page = page
        reqeustModel.size = size
        HTTPSessionManager.shared.request(urlString: NetworkURL.getDonations.url, parameters: reqeustModel.mj_keyValues()) { (json, success) in
            let resultModel = DonateReusltModel.mj_object(withKeyValues: json)
            if success && resultModel != nil && resultModel!.code == 0 {
                self.donationsItems.append(contentsOf: resultModel!.donationsItems)
                self.successCallback?(resultModel!)
            } else {
                let msg = resultModel != nil ? resultModel!.msg : "error"
                Log.e(msg)
                self.failureCallback?(msg)
            }
        }
    }
}
