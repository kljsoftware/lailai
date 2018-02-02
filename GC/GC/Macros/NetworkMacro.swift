//
//  NetworkMacro.swift
//  Music
//
//  Created by hzg on 2017/11/21.
//  Copyright © 2017年 demo. All rights reserved.
//


// MARK: - 服务器地址
#if true
    let SERVER_ADDRESS = "106.14.170.7"   //测试服
#else
    let SERVER_ADDRESS = "47.93.125.157/v2"   //正式服
#endif

let HTTP_ADDRESS       = "http://\(SERVER_ADDRESS)"

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

/// 图片地址
class NetworkImg {
    class func getUrl(name:String) -> String {
        return "\(HTTP_ADDRESS)/img/\(name)"
    }
}

/// api地址
enum NetworkURL {
    case register // 3.1注册
    case login    // 3.3登录
    case checkToken     // 3.4检查token是否过期
    case modityUserInfo // 3.5个人信息修改
    case modityPassword // 3.6密码修改
    case putFeedback    // 3.7反馈信息
    case getAbout       // 3.9关于
    case getPoints      // 3.10积分钱包
    case getContributionHistory // 3.11捐赠记录
    case getDealers             // 3.12绿色地图
    
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
        case .modityUserInfo:
            api = "\(Token.shared.value)/modityUserInfo"
        case .modityPassword:
            api = "\(Token.shared.value)/modityPassword"
        case .putFeedback:
            api = "\(Token.shared.value)/putFeedback"
        case .getAbout:
            api = "getAbout"
        case .getPoints:
            api = "\(Token.shared.value)/getPoints"
        case .getContributionHistory:
            api = "\(Token.shared.value)/getContributionHistory"
        case .getDealers:
            api = "\(Token.shared.value)/getDealers"
        }
        return "\(HTTP_ADDRESS)/v2/\(api)"
    }
}
