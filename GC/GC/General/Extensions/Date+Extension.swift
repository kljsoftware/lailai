//
//  Date+Extension.swift
//  GC
//
//  Created by hzg on 2018/2/3.
//  Copyright © 2018年 demo. All rights reserved.
//

import Foundation

/// 日期
extension Date {
    
    /// 格式：例如：yyyy-MM-dd， HH:mm:ss
    func getTime(format:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
