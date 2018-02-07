//
//  ProfileViewModel.swift
//  GC
//
//  Created by hzg on 2018/2/7.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 个人业务模块
class ProfileViewModel: BaseViewModel {
    
    /// 个人信息
    var userInfo = ProfileUserInfoModel()
    
    // 7.1 获取个人信息
    func getUserInfo() {
        HTTPSessionManager.shared.request(urlString: NetworkURL.getUserInfo.url, parameters: nil) { (json, success) in
            let resultModel = ProfileResultModel.mj_object(withKeyValues: json)
            if success && resultModel != nil && resultModel!.code == 0 {
                self.userInfo = resultModel!.userInfo
                self.successCallback?(resultModel!)
            } else {
                let msg = resultModel != nil ? resultModel!.msg : "error"
                Log.e(msg)
                self.failureCallback?(msg)
            }
        }
    }
}
