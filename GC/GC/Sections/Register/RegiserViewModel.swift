//
//  RegiserViewModel.swift
//  GC
//
//  Created by hzg on 2018/2/1.
//  Copyright © 2018年 demo. All rights reserved.
//

class RegiserViewModel {
    
    func register(tel:String, pwd:String) {
        let result = "\(tel)@\(pwd)".hmac(algorithm: CryptoAlgorithm.SHA1, key: ENCRYPTION_KEY)
        let base64 = result.data(using: String.Encoding.utf8)?.base64EncodedString() ?? ""
        Log.e("result = \(result), base64 = \(base64)")
        let reqModel = RegisterRequestModel()
        reqModel.tel = tel
        reqModel.password = pwd
        reqModel.code = base64
        
        HTTPSessionManager.shared.request(method: .POST, urlString: NetworkURL.register.url, parameters: reqModel.mj_keyValues()) { (json, success) in
            Log.e("json = \(json), success = \(success)")
        }
    }
}
