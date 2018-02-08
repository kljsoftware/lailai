//
//  NetworkMacro.swift
//  Music
//
//  Created by hzg on 2017/11/21.
//  Copyright © 2017年 demo. All rights reserved.
//


// MARK: - 服务器地址
let HTTP_ADDRESS = "https://api.greencitycoin.cn"   //正式服

// 加密key
let ENCRYPTION_KEY     = "Guall0130"

/// 令牌信息
class Token {
    static let shared = Token()
    private init() {
        value = UserDefaults.standard.string(forKey: UserDefaultToken) ?? ""
    }
    
    /// 令牌值
    var value = ""
    
    /// 保存/更新令牌值
    func update(value:String) {
        self.value = value
        UserDefaults.standard.set(value, forKey: UserDefaultToken)
    }
}

/// 图片/web地址
class NetworkImgOrWeb {
    class func getUrl(name:String) -> String {
        return "https://\(name)"
    }
}

/// api地址
enum NetworkURL {
    case register // 2.1注册
    case login    // 2.2登录
    case checkToken     // 2.3检查token是否过期
    case getPointsScAd  // 2.4 获取闪屏页广告
    case getPointsBase  // 3.1 获取积分钱包基础数据
    case getPoints      // 3.2 获取积分钱包商家数据
    case modityUserInfo // 3.5个人信息修改
    case modityPassword // 3.6密码修改
    case putFeedback    // 3.7反馈信息
    case getAbout       // 3.9关于
    case getContributionHistory // 3.11捐赠记录
    case getDealers             // 3.12绿色地图
    case getNews        // 5.1获取新闻列表
    case getUserInfo    // 7.1 获取个人信息
    case uploadFile     //
    
    /// url地址
    var url : String {
        var api = ""
        switch self {
        case .register:
            api = "register"
        case .login:
            api = "login"
        case .checkToken:
            api = "\(Token.shared.value)/checkToken"
        case .getPointsScAd:
            api = "getPointsScAd"
        case .getPointsBase:
            api = "\(Token.shared.value)/getPointsBase"
        case .getPoints:
            api = "\(Token.shared.value)/getPointsShop"
        case .modityUserInfo:
            api = "\(Token.shared.value)/modityUserInfo"
        case .modityPassword:
            api = "\(Token.shared.value)/modityPassword"
        case .putFeedback:
            api = "\(Token.shared.value)/putFeedback"
        case .getAbout:
            api = "getAbout"
        case .getContributionHistory:
            api = "\(Token.shared.value)/getContributionHistory"
        case .getDealers:
            api = "\(Token.shared.value)/getDealers"
        case .getNews:
            api = "\(Token.shared.value)/getNews"
        case .getUserInfo:
            api = "\(Token.shared.value)/getUserInfo"
        case .uploadFile:
            api = "\(Token.shared.value)/uploadFile"
        }
        return "\(HTTP_ADDRESS)/v2/\(api)"
    }
}
