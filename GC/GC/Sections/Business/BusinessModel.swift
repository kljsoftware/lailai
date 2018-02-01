//
//  BusinessModel.swift
//  GC
//
//  Created by hzg on 2018/2/1.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 请求模型
class BusinessRequestModel : BaseRequestModel {

}

/*
/// 结果模型
class BusinessResultModel : BaseResultModel {
    
    var items = [BusinessModel]()
    
    /// 指定数组元素类型
    override class func mj_objectClassInArray() -> [AnyHashable: Any]! {
        return ["items" : BusinessModel.self]
    }
}
 */

/// 绿色商家
class BusinessModel : NSObject {
    var id =  1    /// 商家id
    var name = ""  /// 商家名
    var desc = ""  /// 商家描述
    var logo = ""  /// 商家logo
    var coordinate = "" /// 商家定位坐标
    var address = ""    /// 商家地址
    var level = 0  /// 商家星级
    var link  = 0  ///
    var createdDate = 0 /// 创建日期
    var del = 0    ///

    /// 将属性名换为其他key去字典中取值
    override class func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["description" : "desc"]
    }
}
