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
   
    case tab_wallet         // 积分钱包
    case tab_business       // 绿色商家
    case tab_news           // 绿色新闻
    case tab_donate         // 公益捐赠
    case tab_profile        // 我
    case splash_skip        // 跳过
    case register           // 注册
    case pwd                // 密码
    case input_pwd          // 输入密码
    case input_pwd_again    // 再次输入密码
    case phoneNum           // 手机号
    case authCode           // 验证码
    case nextStep           // 下一步
    case login              // 登录
    case logout             // 退出登录
    case back_login         // 返回登陆
    case rememberpwd        // 记住密码
    case forgotpwd          // 忘记账号或密码
    case settingpwd         // 设置密码
    case save               // 保存
    case ok                 // 确定
    case cancel             // 取消
    case open               // 打开
    case wallet_donate      // 积分捐赠
   
    case setting            // 设置
    case accept_busniss     // 授权商家
    case secret_key_address // 我的秘钥地址
    case blockchain         // 区块链
    case profile_setting    // 个人设置
    case photo              // 照片
    case nick               // 昵称
    case gender             // 性别
    case region             // 地区
    case email              // 邮箱
    case desc               // 个人描述
    case man                // 男
    case woman              // 女
    case language           // 语言
    case faq                // 帮助与反馈
    case about              // 关于绿积分

    case map                // 地图
    case balance            // 捐赠积分额
    case points             // 积分:
    
    case sendCode           // 发送验证码
    case sendAgain          // 重新发送
    case donate_record      // 积分捐赠记录
    case trade_record       // 交易记录
    
    /// 获取对应的语言字串
    var value : String {
        return LanguageHelper.shared.getLanguageText(by: self.rawValue)
    }
}


