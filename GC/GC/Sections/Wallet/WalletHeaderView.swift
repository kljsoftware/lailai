//
//  WalletHeaderView.swift
//  GC
//
//  Created by hzg on 2018/2/12.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class WalletHeaderView: UIView {

    private var bannerView: BannerView?
    
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
    
    /// 点击个人信息闭包
    var didSelectedInfo: (() -> Void)?
    
    /// 点击广告闭包
    var didSelectedAd: ((AdModel) -> Void)?
    
    /// 广告数据
    fileprivate var adItems: [AdModel]!
    
    
    /// 更新
    func update(model: WalletBaseResultModel) {
        
        adItems = model.adItems
        
        if bannerView != nil {
            bannerView?.removeFromSuperview()
            bannerView = nil
        }
        bannerView = BannerView.banner(frame: CGRect(x: 0, y: 0, width: DEVICE_SCREEN_WIDTH, height: 150), delegate: self, imageURLs: adItems.flatMap{NetworkImgOrWeb.getUrl(name: $0.cover)}, placeholderImage: "", timerInterval: 3, currentIndicatorImage: "dot_sel", pageIndicatorImage: "dot")
        self.addSubview(bannerView!)

        avatarImageView.setImage(urlStr: NetworkImgOrWeb.getUrl(name: model.userInfo.avatar), placeholderStr: "avatar", radius: 30)
        nameLabel.text = model.userInfo.name
        rankLabel.text = model.userInfo.rank
        integralSumLabel.text = "\(LanguageKey.balance_points.value)：\(model.userInfo.integralSum)"
        breedLabel.text = "\(LanguageKey.points_type.value)：\(model.userInfo.breed)\(LanguageKey.kinds_unit.value)"
    }
    
    /// 点击个人信息
    @IBAction func tapInfoGes(_ sender: UITapGestureRecognizer) {
        if didSelectedInfo != nil {
            didSelectedInfo!()
        }
    }
}

// MARK: - BannerViewDelegate
extension WalletHeaderView : BannerViewDelegate {

    func bannerView(bannerView: BannerView, didSelected index: Int) {
        if didSelectedAd != nil {
            didSelectedAd!(adItems[index])
        }
    }
}
