//
//  LaunchViewModel.swift
//  GC
//
//  Created by hzg on 2018/2/1.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 启动业务模块
class LaunchViewModel : BaseViewModel {
    
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
            if success {
                NotificationCenter.default.post(name: NoticationUserLoginSuccess, object: nil)
            } else {
                NotificationCenter.default.post(name: NoticationUserLogin, object: nil)
            }
        }
    }
}