//
//  ProfileCell.swift
//  GC
//
//  Created by hzg on 2018/2/3.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    /// 头像
    @IBOutlet weak var avatarImageView: UIImageView!
   
    /// 用户名
    @IBOutlet weak var userNameLabel: UILabel!
    
    /// 联系方式
    @IBOutlet weak var telLabel: UILabel!
    
    
    // MARK: - public methods
    func update(model: ProfileUserInfoModel) {
        avatarImageView.setImage(urlStr: NetworkImgOrWeb.getUrl(name: model.logo), placeholderStr: "avatar", radius: 30)
        userNameLabel.text = model.shortName
        telLabel.text = model.tel
    }
    
}
