//
//  UIHelper.swift
//  GC
//
//  Created by hzg on 2018/2/1.
//  Copyright © 2018年 demo. All rights reserved.
//

import Toast_Swift

/// 界面助手类
class UIHelper {
    
    /// 提示
    class func tip(message:String, position:ToastPosition = .center) {
        let window = (UIApplication.shared.delegate as! AppDelegate).window
        window?.makeToast(message, duration: 1, position: position)
    }
    
    /// 调转至广告页
    class func pushToAdView(model:AdModel) {
        pushToWeb(urlString: model.link)
    }
    
    /// 调整至网页
    class func pushToWeb(urlString:String) {
        guard let url = URL(string: urlString) else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
    }
}
