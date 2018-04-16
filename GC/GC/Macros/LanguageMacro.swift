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
    
    /// 首页
    case tab_wallet         // 积分钱包
    case tab_business       // 绿色商家
    case tab_news           // 绿色新闻
    case tab_donate         // 公益捐赠
    case tab_profile        // 我
    
    /// 登录注册
    case splash_skip        // 跳过
    case register           // 注册
    case pwd                // 密码
    case inut_pwd_old       // 输入旧密码
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
    case sendCode           // 发送验证码
    case sendAgain          // 重新发送
    case phone_null         // 手机号为空或输入错误
    case pwd_null           // 密码不能为空
    case pwd_different      // 密码输入不一致
    case pwd_reset          // 重置密码
    
    /// 积分钱包
    case wallet_donate      // 积分捐赠
    case donate_record      // 积分捐赠记录
    case total              // 累计总额
    case points_unit        // 分
    case viewbyblock        // 通过区块链查看
    case hash               // 交易哈希
    case trade_record       // 交易记录
    case my_donate_total    // 我的积分捐赠总额
    case balance_points     // 捐赠积分数量
    case points_type        // 积分种类
    case kinds_unit         // 种
    
    /// 积分商家
    case map                // 地图
    case balance            // 捐赠积分额
    case points             // 积分
    
    /// 我
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
    case birthday           // 生日
    case desc               // 个人描述
    case man                // 男
    case woman              // 女
    case language           // 语言
    case faq                // 反馈
    case version            // 版本号
    case about              // 关于绿积分
    case faq_words_10       // 反馈字数应不小于10字
    case faq_success        // 感谢反馈，我们将及时处理！
    case modify_success     // 修改成功
    case save_success       // 保存成功
    case pwd_old_error      // 旧密码错误
//    case green_city_points  // 绿城积分
//    case want_open          // 想要打开
    case auth_line          // 已授权连接
    case input_public_key   // 输入公钥地址（可在对应商家平台查看）
    case no_auth_business   // 尚未授权商
    case port_auth          // 接口授权
    case login_name         // 登录名
    case login_pwd          // 登录密码
    case auth_green_points_get // 授权绿色积分钱包获取
    case points_data        // 积分数据
    case input              // 手动输入
    
    /// 其他
    case ok                 // 确定
    case cancel             // 取消
    case open               // 打开
    
    
    /// 获取对应的语言字串
    var value : String {
        return LanguageHelper.shared.getLanguageText(by: self.rawValue)
    }
}


