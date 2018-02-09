//
//  ProfileDetailViewModel.swift
//  GC
//
//  Created by hzg on 2018/2/9.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class ProfileDetailViewModel: BaseViewModel {
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
}

class UploadFileResultModel : BaseResultModel {
    var data = UploadFileModel()
}

class UploadFileModel : NSObject {
    var name = ""
}
