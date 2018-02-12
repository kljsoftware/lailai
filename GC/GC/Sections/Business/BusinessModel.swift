//
//  BusinessModel.swift
//  GC
//
//  Created by hzg on 2018/2/1.
//  Copyright © 2018年 demo. All rights reserved.
//


/// 4.商家地图
/// 4.1 获取绿色商家位置列表 请求模型
class BusinessRequestModel : BaseRequestModel {
    var page = 0  // 第几页 从0开始
    var size = 10 // 每页显示数
}

/// 4.2 根据位置返回商家列表
class BusinessDealersRequestModel : BaseRequestModel {
    var x = ""
    var y = ""         //位置坐标 如果是关键字搜索 此参数传当前位置
    var name = ""         //搜索关键字 按位置搜索时 此参数为空
    var range = 5000      //搜索范围 上传参数为空 则后台去默认值 目前约定是500m  如果是按关键字搜索时  暂时定 此参数传入10000
    var page = 0         //第几页 从0开始
    var size = 10         //每页显示数
}

/// 4.3 根据关键字返回商家列表
class BusinessNameRequestModel : BaseRequestModel {
    var name = ""  // 搜索关键字
    var page = 0   // 第几页 从0开始
    var size = 10  // 每页显示数
}

/// 结果模型
class BusinessResultModel : BaseResultModel {
    
    /// 是否有更多页
    var has_more = true
    
    var data = [BusinessModel]()
    
    /// 指定数组元素类型
    override class func mj_objectClassInArray() -> [AnyHashable: Any]! {
        return ["data" : BusinessModel.self]
    }
}

/// 绿色商家
class BusinessModel : NSObject {
    var id =  1    /// 商家id
    var name = ""  /// 商家名
    var desc = ""  /// 商家描述
    var color = ""
    var dealerTel = "" /// 商家电话
    var logo = ""  /// 商家logo
    var coordinate = "" /// 商家定位坐标
    var address = ""    /// 商家地址
    var level = 0  /// 商家星级
    var link  = 0  ///
    var createdDate = 0 /// 创建日期
    var del = 0    ///
    var blockchainId = "" /// 区块链id

    /// 将属性名换为其他key去字典中取值
    override class func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["description" : "desc"]
    }
}
