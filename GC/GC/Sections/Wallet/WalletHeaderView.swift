//
//  WalletHeaderView.swift
//  GC
//
//  Created by hzg on 2018/2/12.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class WalletHeaderView: UIView {

    @IBOutlet weak var bannerView: BannnerView!
    
    /// 头文件
    @IBOutlet weak var avatarImageView: UIImageView!
    
    /// 人名
    @IBOutlet weak var nameLabel: UILabel!
    
    /// 捐赠级别称号
    @IBOutlet weak var rankLabel: UILabel!
    
    /// 捐赠积分数量
    @IBOutlet weak var integralSumLabel: UILabel!
    
    /// 积分种类
    @IBOutlet weak var breedLabel: UILabel!
    
    /// 页码
    @IBOutlet weak var pageControl: PageControl!
    
    /// 点击个人信息闭包
    var didSelectedInfo: (() -> Void)?
    
    /// 更新
    func update(model:WalletBaseResultModel) {
        bannerView.setup(banners: model.adItems)
        bannerView.didPageChangedClosure = { [weak self] (page) in
            guard let wself = self else {
                return
            }
            wself.pageControl.setCurrentPage(current: page)
        }
        avatarImageView.setImage(urlStr: NetworkImgOrWeb.getUrl(name: model.userInfo.avatar), placeholderStr: "avatar", radius: 30)
        nameLabel.text = model.userInfo.name
        rankLabel.text = model.userInfo.rank
        integralSumLabel.text = "\(LanguageKey.balance_points.value)：\(model.userInfo.integralSum)"
        breedLabel.text = "\(LanguageKey.points_type.value)：\(model.userInfo.breed)\(LanguageKey.kinds_unit.value)"
        pageControl.setup(total: model.adItems.count, current: 0)
    }
    
    /// 点击个人信息
    @IBAction func tapInfoGes(_ sender: UITapGestureRecognizer) {
        if didSelectedInfo != nil {
            didSelectedInfo!()
        }
    }
}
