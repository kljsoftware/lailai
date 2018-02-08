//
//  NewsModel.swift
//  GC
//
//  Created by hzg on 2018/2/6.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 5.1获取新闻列表
class NewsRequestModel : BaseRequestModel {
    var page = 0  // 第几页 从0开始
    var size = 10 // 每页显示数
}

class NewsResultModel : BaseResultModel {
    
    var has_more = true               // 是否有更多页
    
    var topNews = NewsTopModel()      // 置顶新闻项 page等于0时返回此项  page非0 反空
    
    var newsItems = [NewsItemModel]() // 新闻项
    
    /// 指定数组元素类型
    override class func mj_objectClassInArray() -> [AnyHashable: Any]! {
        return ["newsItems" : NewsItemModel.self]
    }
}

class NewsTopModel : NSObject {
    var id          = 1    // 新闻id
    var newsTag     = ""   // 新闻标签
    var newsCover   = ""   // 新闻封面
    var newsLink    = ""   // 新闻链接
    var newsSource  = ""   // 来源
    var createdDate:Double = 0   //新闻时间
}

class NewsItemModel : NSObject {
    var id          = 1    // 新闻id
    var newsTag     = ""   // 新闻标签
    var newsCover   = ""   // 新闻封面
    var newsLink    = ""   // 新闻链接
    var newsSource  = ""   // 来源
    var createdDate:Double = 0   //新闻时间
}
