//
//  ProfileDetailViewModel.swift
//  GC
//
//  Created by hzg on 2018/2/9.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class ProfileDetailViewModel: BaseViewModel {
    
    // 8.2 上传文件
    func upload(data:Data) {
        Upload.uploadFile(NetworkURL.uploadFile.url, parameters: ["type":0], data: data, success: { (dict) in
            let resultModel = UploadFileResultModel.mj_object(withKeyValues: dict)
            if resultModel != nil && resultModel!.code == 0 {
                self.successCallback?(resultModel!)
            } else {
                let msg = resultModel != nil ? resultModel!.msg : "error"
                Log.e(msg)
                self.failureCallback?(msg)
            }
        }, failure: { (error) in
            self.failureCallback?(error.localizedDescription)
        })
    }
    
    // 7.2 修改个人信息
    func modityUserInfo(info: ModityUserInfoRequestModel) {
        let parameters = info.mj_keyValues()
        if parameters != nil {
            parameters!["description"] = info.desc
            parameters?.removeObject(forKey: "desc")
        }
        HTTPSessionManager.shared.request(method: .POST, urlString: NetworkURL.modityUserInfo.url, parameters: parameters) { (json, success) in
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
}

class UploadFileResultModel : BaseResultModel {
    var name = ""
}

class ModityUserInfoRequestModel : BaseRequestModel {
    var tel = ""
    var name = ""
    var shortName = ""
    var email = ""
    var sex = ""
    var birthday = ""
    var city = ""
    var level = ""
    var createdDate = ""
    var logo = ""
    var desc = ""
        
    /// 将属性名换为其他key去字典中取值
    override class func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["description" : "desc"]
    }
}
