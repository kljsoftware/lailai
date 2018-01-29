//
//  NewsResultModel.swift
//  GC
//
//  Created by hzg on 2018/1/29.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class NewsResultModel: NSObject {
    
    /// 封面
    var cover = ""
    
    /// 热门焦点
    var hotFocus = ""
    
    /// 新闻
    var news = NewsModel()
    
    /// 指定数组元素类型
    override class func mj_objectClassInArray() -> [AnyHashable: Any]! {
        return ["news" : NewsModel.self]
    }
}

class NewsModel : NSObject {
    
    /// 封面
    var cover = ""
    
    /// 标题
    var title = ""
    
    /// 分享来源（个人或其它）
    var source = ""
    
    /// 分享时间
    var time = "" // yyyy-MM-dd HH:mm:ss
}
