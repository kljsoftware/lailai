//
//  LaunchViewModel.swift
//  GC
//
//  Created by hzg on 2018/2/1.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 启动业务模块
class LaunchViewModel : BaseViewModel {
    
    /// 广告model
    var adModel = AdModel()
    
    /// 获取闪屏页广告
    func getPointsScAd() {
        HTTPSessionManager.shared.request(method: .GET, urlString: NetworkURL.getPointsScAd.url, parameters: nil) { [weak self] (josn, success) in
            let model = SplashModel.mj_object(withKeyValues: josn)
            if success && model != nil && model!.code == 0 {
                self?.adModel = model!.data
                self?.successCallback?(model!)
            } else {
                let msg = model != nil ? model!.msg : "error"
                UIHelper.tip(message: msg)
                self?.checkToken()
            }
        }
    }
    
    /// 检查token是否有效
    func checkToken() {
        
        /*
         本地是否有token, 若没有直接进入登录界面
         */
        if Token.shared.value.isBlank() {
           NotificationCenter.default.post(name: NoticationUserLogin, object: nil)
           return
        }

        // 非首次流程
        /*
         1，本地有token，验证是否可用 checkToken;
         2，不可用让用户重新登陆
         */
        HTTPSessionManager.shared.request(method: .POST, urlString: NetworkURL.checkToken.url, parameters: nil) { (josn, success) in
            let model = BaseResultModel.mj_object(withKeyValues: josn)
            if success && model != nil && model!.code == 0 {
                NotificationCenter.default.post(name: NoticationUserLoginSuccess, object: nil)
            } else {
                let msg = model != nil ? model!.msg : "error"
                UIHelper.tip(message: msg)
                Token.shared.update(value: "")
                NotificationCenter.default.post(name: NoticationUserLogin, object: nil)
            }
        }
    }
}
