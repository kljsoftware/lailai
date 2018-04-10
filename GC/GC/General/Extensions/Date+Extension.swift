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
    
    /// 字符串转换为时间
    static func convert(from dateStr: String, format: String) -> Date? {
        let dateFormatter           = DateFormatter()
        dateFormatter.locale        = NSLocale.current
        dateFormatter.timeZone      = NSTimeZone.local
        dateFormatter.dateFormat    = format
        let date = dateFormatter.date(from: dateStr)
        return date
    }
    
    /// 时间转换为字符串
    func convert(format: String) -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = format
        let dateStr = dateFormatter.string(from: self)
        return dateStr
    }
}
