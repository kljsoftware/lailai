//
//  AdView.swift
//  GC
//
//  Created by hzg on 2018/2/3.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

/// 广告视图
class AdView: UIView {

    /// 模型文件
    var model:AdModel? {
        didSet {
            if nil != model {
                setup()
            }
        }
    }
    
    /// 广告视图
    @IBOutlet weak var bannerImageView: UIImageView!
    
    /// 初始化
    private func setup() {
        bannerImageView.setImage(urlStr: NetworkImgOrWeb.getUrl(name: model!.cover), placeholderStr: "", radius: 0)
    }
    
    /// 点击广告
    @IBAction func onBannerClicked(_ sender: UIButton) {
        if nil != model {
            UIHelper.pushToWeb(urlString: model!.link)
        }
    }
}
