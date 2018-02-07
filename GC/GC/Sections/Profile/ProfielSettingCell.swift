//
//  ProfielSettingCell.swift
//  GC
//
//  Created by hzg on 2018/2/3.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class ProfielSettingCell: UITableViewCell {
   
    /// 名称
    @IBOutlet weak var nameLabel: UILabel!
    
    /// 更新
    func update(name:String) {
        nameLabel.text = name
    }
    
}
