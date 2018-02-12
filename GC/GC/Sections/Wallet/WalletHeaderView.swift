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
    
    /// 更新
    func update(model:WalletBaseResultModel) {
        bannerView.setup(banners: model.adItems)
        avatarImageView.setImage(urlStr: NetworkImgOrWeb.getUrl(name: model.userInfo.avatar), placeholderStr: "avatar", radius: 30)
        nameLabel.text = model.userInfo.name
        rankLabel.text = model.userInfo.rank
        integralSumLabel.text = "捐赠积分数量: \(model.userInfo.integralSum)"
        breedLabel.text = "积分种类: \(model.userInfo.breed)种"
    }
}
