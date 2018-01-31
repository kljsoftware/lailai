//
//  BusinessTitleView.swift
//  GC
//
//  Created by hzg on 2018/1/30.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

/// 绿色商家导航栏标题视图
class BusinessTitleView: UIView {
    
    /// 按钮回调闭包
    var businessButtonCallback:(()->Void)?
    var mapbuttonCallback:(()->Void)?
    
    /// 商家按钮、地图按钮
    @IBOutlet weak var businessButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var businessLineView: UIView!
    @IBOutlet weak var mapLineView: UIView!
    
    /// 初始化
    override func awakeFromNib() {
        businessButton.setTitle(LanguageKey.tab_business.value, for: .normal)
        mapButton.setTitle(LanguageKey.map.value, for: .normal)
        businessButton.isExclusiveTouch = true
        mapButton.isExclusiveTouch = true
    }

    /// 商家按钮点击
    @IBAction func onBusinessButtonClicked(_ sender: UIButton) {
        if !businessButton.isSelected {
            update(isSelectBusiness: true)
            businessButtonCallback?()
        }
    }
    
    /// 地图按钮点击
    @IBAction func onMapButtonClicked(_ sender: UIButton) {
        if !mapButton.isSelected {
            update(isSelectBusiness: false)
            mapbuttonCallback?()
        }
    }
    
    // MARK: - public methods
    func update(isSelectBusiness:Bool) {
        businessButton.isSelected = isSelectBusiness
        businessLineView.isHidden = !isSelectBusiness
        mapButton.isSelected = !isSelectBusiness
        mapLineView.isHidden = isSelectBusiness
    }
}
