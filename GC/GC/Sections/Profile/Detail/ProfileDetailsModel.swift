//
//  ProfileDetailsModel.swift
//  GC
//
//  Created by hzg on 2018/2/6.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 7.2 修改个人信息

class ProfileModifyRequestModel : BaseRequestModel {
    var name = "" // 用户名
    var logo = ""     //头像图片地址
    var short_name = ""     //昵称
    var tel = ""     //手机号
    var sex = 2     //性别 1男 2 女
    var city = ""   //地区
    var email = ""  //邮箱
    var desc =  "" //个人描述

    /// 将属性名换为其他key去字典中取值
    override class func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["description" : "desc"]
    }
}
