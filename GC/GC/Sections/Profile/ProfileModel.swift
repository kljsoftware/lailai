//
//  ProfileModel.swift
//  GC
//
//  Created by hzg on 2018/2/6.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 7.1 获取个人信息

class ProfileResultModel : BaseResultModel {
    var userInfo = ProfileUserInfoModel()
}

class ProfileUserInfoModel : NSObject {
    var name = ""        // 用户名
    var logo = ""        //头像图片地址
    var short_name = ""  //昵称
    var tel = ""         //手机号
    var sex = 2          // 性别 1男 2 女
    var city = ""        //地区
    var email = ""       //邮箱
    var desc = ""        //个人描述
    
    /// 将属性名换为其他key去字典中取值
    override class func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["description" : "desc"]
    }
}

/// 7.3 获取关于内容

class AboutResultModel : BaseResultModel {
    var content = ""   /// 关于
}

/// 7.4 反馈信息
class PutFeedbackRequestModel : BaseRequestModel {
    var info = ""
}

/// 7.5 修改密码
class ModifyPasswordRequestModel : BaseRequestModel {
    var newPassword  = "" //新密码
    var oldPassword  = "" //旧密码
}
