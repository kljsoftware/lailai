//
//  AreaModel.swift
//  GC
//
//  Created by Sunny on 2018/4/6.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

/// 省
class ProvinceModel: NSObject {
    
    var province = ""
    var citys = [CityModel]()
    
    /// 指定数组元素类型
    override class func mj_objectClassInArray() -> [AnyHashable: Any]! {
        return ["citys" : CityModel.self]
    }
}

/// 市
class CityModel: NSObject {
    
    var city = ""
    var districts = [String]()
}
