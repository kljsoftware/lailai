//
//  BusinessViewModel.swift
//  GC
//
//  Created by hzg on 2018/2/1.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 绿色商家业务模块
class BusinessViewModel: BaseViewModel {
    
    /// 获取绿色商家
    func getDealers() {
        HTTPSessionManager.shared.request(urlString: NetworkURL.getDealers.url, parameters: nil) { (json, success) in
            let resultModel = BusinessResultModel.mj_object(withKeyValues: json)
            if success && resultModel != nil && resultModel!.code == 0 {
                self.successCallback?(resultModel!)
            } else {
                self.failureCallback?("error")
            }
        }
    }
}
