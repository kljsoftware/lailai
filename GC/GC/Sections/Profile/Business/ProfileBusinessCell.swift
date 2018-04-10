//
//  ProfileBusinessCell.swift
//  GC
//
//  Created by hzg on 2018/2/9.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class ProfileBusinessCell: UITableViewCell {

    @IBOutlet weak var businessnameLabel: UILabel!
    
    @IBOutlet weak var businesslinkLabel: UILabel!
    
    /// 刷新数据
    func update(model: BusinessInfoModel) {
        businessnameLabel.text = model.dealerName
        businesslinkLabel.text =  model.MemberPublicKey != "" ? LanguageKey.auth_line.value : ""
    }
    
}
