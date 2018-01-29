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
    case tab_wallet
    case tab_business
    case tab_news
    case tab_profile
    
    /// 闪屏页
    case splash_skip
    
    /// 注册
    case register
    
    /// 积分钱包相关
    case wallet_donate
    
    /// 获取对应的语言字串
    var value : String {
        return LanguageHelper.shared.getLanguageText(by: self.rawValue)
    }
}


