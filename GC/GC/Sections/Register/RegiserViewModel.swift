//
//  RegiserViewModel.swift
//  GC
//
//  Created by hzg on 2018/2/1.
//  Copyright © 2018年 demo. All rights reserved.
//

class RegiserViewModel : BaseViewModel {
    
    func register(tel:String, pwd:String) {
        let result = "\(tel)@\(pwd)".hmac(algorithm: CryptoAlgorithm.SHA1, key: ENCRYPTION_KEY)
        let base64 = result.data(using: String.Encoding.utf8)?.base64EncodedString() ?? ""
        Log.e("result = \(result), base64 = \(base64)")
        let reqModel = RegisterRequestModel()
        reqModel.tel = tel
        reqModel.password = pwd
        reqModel.code = base64
        
        HTTPSessionManager.shared.request(method: .POST, urlString: NetworkURL.register.url, parameters: reqModel.mj_keyValues()) { [weak self](json, success) in
            let model = LoginResultModel.mj_object(withKeyValues: json)
            if success && model != nil && model!.code == 0 {
                Token.shared.update(value: model!.data)
                UserDefaults.standard.set(tel, forKey: UserDefaultUserName)
                UserDefaults.standard.set(pwd, forKey: UserDefaultUserPwd)
                NotificationCenter.default.post(name: NoticationUserLoginSuccess, object: nil)
            } else {
                let msg = model != nil ? model!.msg : "error"
                UIHelper.tip(message: msg)
                self?.failureCallback?(msg)
            }
        }
    }
}
