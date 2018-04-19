//
//  CLLocationCoordinate2D+Extension.swift
//  GC
//
//  Created by hzg on 2018/2/9.
//  Copyright © 2018年 demo. All rights reserved.
//

import CoreLocation

extension CLLocationCoordinate2D {
    
    /// 是否有效
    func isValid() -> Bool {
        
        // 经度最大是180° 最小是0°
        if (0.0 > longitude || 180.0 < longitude) {
            return false
        }
        
        // 纬度最大是90° 最小是0°
        if (0.0 > latitude || 90.0 < latitude) {
            return false
        }
        
        return true
    }
}
