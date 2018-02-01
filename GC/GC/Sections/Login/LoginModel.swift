//
//  LoginModel.swift
//  GC
//
//  Created by hzg on 2018/2/1.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 登陆请求模型
class LoginRequestModel: BaseRequestModel {
   
    /// 手机号
    var tel = ""
    
    /// 密码
    var password = ""
    
    /// 签名码  HMAC-SHA1加密, base64编码
    var code = ""
}

/// 登陆结果模型
class LoginResultModel: BaseResultModel {
    
    /// 令牌  若成功返回  msg即是令牌信息
  //  var token = ""
}
