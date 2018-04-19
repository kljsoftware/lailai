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
    
    // 登录及注册
    case register               // 2.1 注册
    case login                  // 2.2 登录
    case checkToken             // 2.3 检查token是否过期
    case getPointsScAd          // 2.4 获取闪屏页广告
    
    // 积分钱包
    case getPointsBase          // 3.1 获取积分钱包基础数据
    case getPoints              // 3.2 获取积分钱包商家数据
    case getContributionHistory // 3.3 获取用户在一个商家积分捐赠记录
    case getContributeNum       // 3.4 通过区块链查看总额
    
    // 商家地图
    case getDealers             // 4.1 获取绿色商家位置列表
    case searchDealers          // 4.2 搜索商家
    case getDealerAndBranch     // 4.3 获取指定商家及分支
    
    // 公益捐赠
    case getNews                // 5.1 获取新闻列表
    
    // 公益捐赠
    case getDonations           // 6.1 获取公益捐赠列表
    
    // 我
    case getUserInfo            // 7.1 获取个人信息
    case modityUserInfo         // 7.2 个人信息修改
    case getAbout               // 7.3 获取关于内容
    case putFeedback            // 7.4 反馈信息
    case modityPassword         // 7.5 修改密码
    case putMemberDeaRelKey     // 7.6 手动输入秘钥
    case getDealerList          // 7.7 授权商家列表
    case getBlockchainAddress   // 7.8 我的区块链地址列表
    
    // 通用部分
    case getBlockChainInfo      // 8.1 获取区块链信息
    case uploadFile             // 8.2 上传文件
    
    
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
        case .getContributionHistory:
            api = "\(Token.shared.value)/getContributionHistory"
        case .getContributeNum:
            api = "\(Token.shared.value)/getContributeNum"
        case .getDealers:
            api = "\(Token.shared.value)/getDealers"
        case .searchDealers:
            api = "\(Token.shared.value)/searchDealers"
        case .getDealerAndBranch:
            api = "\(Token.shared.value)/getDealerAndBranch"
        case .getNews:
            api = "\(Token.shared.value)/getNews"
        case .getDonations:
            api = "\(Token.shared.value)/getDonations"
        case .getUserInfo:
            api = "\(Token.shared.value)/getUserInfo"
        case .modityUserInfo:
            api = "\(Token.shared.value)/modityUserInfo"
        case .getAbout:
            api = "getAbout"
        case .putFeedback:
            api = "\(Token.shared.value)/putFeedback"
        case .modityPassword:
            api = "\(Token.shared.value)/modityPassword"
        case .putMemberDeaRelKey:
            api = "\(Token.shared.value)/putMemberDeaRelKey"
        case .getDealerList:
            api = "\(Token.shared.value)/getDealerList"
        case .getBlockchainAddress:
            api = "\(Token.shared.value)/getBlockchainAddress"
        case .getBlockChainInfo:
            api = "\(Token.shared.value)/getBlockChainInfo"
        case .uploadFile:
            api = "\(Token.shared.value)/uploadFile"
        }
        return "\(HTTP_ADDRESS)/v2/\(api)"
    }
}
