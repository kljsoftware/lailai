//
//  ProfileDetailDescCell.swift
//  GC
//
//  Created by hzg on 2018/2/3.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class ProfileDetailDescCell: UITableViewCell {

    /// 标签名
    @IBOutlet weak var nameLabel: UILabel!
    
    /// 标签内容
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - public methods
    func update(name:String, content:String) {
        nameLabel.text = name
        contentLabel.text = content
    }
    
}
