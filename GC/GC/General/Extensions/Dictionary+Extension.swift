//
//  Dictionary+Extension.swift
//  GC
//
//  Created by hzg on 2018/2/3.
//  Copyright © 2018年 demo. All rights reserved.
//

extension Dictionary {
    
    /// 转化成网络参数拼接 "&key=value&key=value"
    func urlParamsString() -> String {
        var str = ""
        for kv in self {
            str += "&\(kv.key)=\(kv.value)"
        }
        return str
    }
}
