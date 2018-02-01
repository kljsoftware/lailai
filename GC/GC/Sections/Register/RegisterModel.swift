//
//  RegisterModel.swift
//  GC
//
//  Created by hzg on 2018/2/1.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 注册请求模型
class RegisterRequestModel: BaseRequestModel {
    
    /// 手机号
    var tel = ""
    
    /// 密码
    var password = ""
    
    /// 签名码  HMAC-SHA1加密, base64编码
    var code = ""
}

/// 注册请求结果模型
class RegisterResultModel: BaseResultModel {
    
    /// 令牌/密钥
    var token = ""
}
