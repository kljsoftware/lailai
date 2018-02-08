//
//  Double+Extension.swift
//  GC
//
//  Created by hzg on 2018/2/8.
//  Copyright © 2018年 demo. All rights reserved.
//


extension Double {
    func transferFormat() -> String {
        //转换为时间
        let date = Date(timeIntervalSince1970: self/1000)
        
        //格式话输出
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
