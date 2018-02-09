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
    
    func update(name:String, isAuthorized:Bool = false) {
        businessnameLabel.text = name
        businesslinkLabel.text = isAuthorized ? "已授权连接" : ""
    }
    
}
