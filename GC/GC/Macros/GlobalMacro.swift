//
//  GlobalMacro.swift
//  Music
//
//  Created by hzg on 2017/11/21.
//  Copyright © 2017年 demo. All rights reserved.
//

import UIKit

/// 日记输出使能
let LOG_ENABLED = true

/// 屏幕宽
let DEVICE_SCREEN_WIDTH         = UIScreen.main.bounds.size.width

/// 屏幕高
let DEVICE_SCREEN_HEIGHT        = UIScreen.main.bounds.size.height

// 判断是否是iPhoneX
let iPhoneX: Bool               = UIScreen.main.bounds.size == CGSize(width: 375, height: 812)

// 状态栏高
let DEVICE_STATUS_BAR_HEIGHT: CGFloat  = iPhoneX ? 44 : 20

// iPhoneX竖屏底部指示部分
let DEVICE_INDICATOR_HEIGHT: CGFloat    = iPhoneX ? 34 : 0

// 导航栏的高度
let DEVICE_NAV_HEIGHT:CGFloat = 44

// 底部栏高
let DEVICE_BOTTOM_HEIGHT:CGFloat = 48

// 内容高度
let APP_CONTENT_HEIGHT:CGFloat = DEVICE_SCREEN_HEIGHT - DEVICE_STATUS_BAR_HEIGHT - DEVICE_NAV_HEIGHT - DEVICE_INDICATOR_HEIGHT - DEVICE_BOTTOM_HEIGHT

/// 常用字体定义
let ARIAL_FONT_16 = UIFont(name: "Arial", size: 16)!
let PINGFANG_FONT_12 = UIFont(name: "PingFangSC-Regular", size: 12)!

/// 常用颜色定义
let COLOR_2673FD = UIColor.hexToColor(0x2673FD)
let COLOR_5A848A = UIColor.hexToColor(0x5A848A)
