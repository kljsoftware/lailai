//
//  PuddingViewModel.swift
//  GC
//
//  Created by sunzhiwei on 2018/5/7.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class PuddingViewModel: BaseViewModel {
    
    /// 布丁
    var puddingModel = PuddingResultModel()
    
    var page = 0
    var isRefresh = true
    
    
    // 7.9 我的布丁
    func getPuddingRecord() {
        let reqeustModel = PuddingRequestModel()
        reqeustModel.page = page
        reqeustModel.size = 20
        HTTPSessionManager.shared.request(urlString: NetworkURL.getPuddingRecord.url, parameters: reqeustModel.mj_keyValues()) { (json, success) in
            let resultModel = PuddingResultModel.mj_object(withKeyValues: json)
            if success && resultModel != nil && resultModel!.code == 0 {
                if self.isRefresh {
                    self.puddingModel.puddingRecordinfos.removeAll()
                    self.puddingModel.puddingRecordinfos = resultModel!.puddingRecordinfos
                } else {
                    self.puddingModel.puddingRecordinfos += resultModel!.puddingRecordinfos
                }
                self.puddingModel.has_more = resultModel!.has_more
                self.successCallback?(resultModel!)
            } else {
                let msg = resultModel != nil ? resultModel!.msg : "error"
                Log.e(msg)
                self.failureCallback?(msg)
            }
        }
    }
}
