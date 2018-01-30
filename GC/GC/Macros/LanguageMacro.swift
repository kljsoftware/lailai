//
//  LanguageMacro.swift
//  Music
//
//  Created by hzg on 2017/12/7.
//  Copyright © 2017年 demo. All rights reserved.
//

/// 多语言常量设置

/// 多语言键值类型
enum LanguageKey : String {
   
    case tab_wallet   // 积分钱包
    case tab_business // 绿色商家
    case tab_news     // 绿色新闻
    case tab_profile  // 我
    case splash_skip  // 跳过
    case register     // 注册
    case input_pwd    // 输入密码
    case input_pwd_again // 再次输入密码
    case phoneNum     // 手机号
    case authCode     // 验证码
    case nextStep     // 下一步
    case login        // 登陆
    case rememberpwd  // 记住密码
    case forgotpwd    // 忘记账号或密码
    case settingpwd   // 设置密码
    case save         // 保存
    case wallet_donate // 积分捐赠
    case profile_setting // 个人设置
    
    /// 获取对应的语言字串
    var value : String {
        return LanguageHelper.shared.getLanguageText(by: self.rawValue)
    }
}


