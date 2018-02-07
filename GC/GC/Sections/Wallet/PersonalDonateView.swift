//
//  PersonalDonateView.swift
//  GC
//
//  Created by hzg on 2018/1/29.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class PersonalDonateView: UIView {
    
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
    
    // MARK: - public methods
    /// 更新
    func update(model:WalletUserInfoModel) {
        avatarImageView.setImage(urlStr: NetworkImgOrWeb.getUrl(name: model.avatar), placeholderStr: "avatar", radius: 30)
        nameLabel.text = model.name
        rankLabel.text = model.rank
        integralSumLabel.text = "\(model.integralSum)"
        breedLabel.text = "\(model.breed)种积分"
    }
}
