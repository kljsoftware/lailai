//
//  UIView+Extension.swift
//  GC
//
//  Created by hzg on 2018/2/3.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

private let pushPopAnimationDuration = 0.5, pushPopDelayDuration = 0.1

extension UIView {
    
    /// 圆角
    @IBInspectable var cornerRadius:CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = false
            layer.shouldRasterize = true // 性能优化 参照http://www.jianshu.com/p/687bf79b4fd3
            layer.rasterizationScale = UIScreen.main.scale
        }
    }
    
    /// 模糊
    class func blurViewWithRect(_ rect: CGRect, style:UIBlurEffectStyle = .light) -> UIView {
        let view = UIView(frame: rect)
        view.backgroundColor = UIColor.clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        view.addSubview(blurView)
        return view
    }

}
