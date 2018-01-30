//
//  NetworkMacro.swift
//  Music
//
//  Created by hzg on 2017/11/21.
//  Copyright © 2017年 demo. All rights reserved.
//


// MARK: - 服务器地址
#if true
    let SERVER_ADDRESS = "47.93.125.157/v2"   //测试服
#else
    let SERVER_ADDRESS = "47.93.125.157/v2"   //正式服
#endif

let HTTP_ADDRESS       = "http://\(SERVER_ADDRESS)"

// 加密key
let ENCRYPTION_KEY     = "msx78963214abc"

/// api地址
enum NetworkURL {
    case register // 注册
    
    /// url地址
    var url : String {
        var api = ""
        switch self {
        case .register:
            api = ""
        }
        return "\(HTTP_ADDRESS)\(ENCRYPTION_KEY)\(api)"
    }
}
