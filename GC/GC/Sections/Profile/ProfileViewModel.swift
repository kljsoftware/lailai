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
    
    // 7.5 修改密码
    func modityPassword(newpwd:String, oldpwd:String) {
        let reqModel = ModifyPasswordRequestModel()
        reqModel.newPassword = newpwd
        reqModel.oldPassword = oldpwd
        HTTPSessionManager.shared.request(method: .POST, urlString: NetworkURL.modityPassword.url, parameters: reqModel.mj_keyValues()) { (json, success) in
            let resultModel = BaseResultModel.mj_object(withKeyValues: json)
            if success && resultModel != nil && resultModel!.code == 0 {
                self.successCallback?(resultModel!)
            } else {
                let msg = resultModel != nil ? resultModel!.msg : "error"
                Log.e(msg)
                self.failureCallback?(msg)
            }
        }
    }
    
    /// 7.4 反馈信息
    func feedBack(info:String) {
        let reqModel = PutFeedbackRequestModel()
        reqModel.info = info
        HTTPSessionManager.shared.request(method: .POST, urlString: NetworkURL.putFeedback.url, parameters: reqModel.mj_keyValues()) { (json, success) in
            let resultModel = BaseResultModel.mj_object(withKeyValues: json)
            if success && resultModel != nil && resultModel!.code == 0 {
                self.successCallback?(resultModel!)
            } else {
                let msg = resultModel != nil ? resultModel!.msg : "error"
                Log.e(msg)
                self.failureCallback?(msg)
            }
        }
    }
    
    /// 7.3 获取关于内容
    func getAbout() {
        HTTPSessionManager.shared.request(urlString: NetworkURL.getAbout.url, parameters: nil) { (json, success) in
            let resultModel = AboutResultModel.mj_object(withKeyValues: json)
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
