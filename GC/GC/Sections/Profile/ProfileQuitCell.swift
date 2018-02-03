//
//  ProfileQuitCell.swift
//  GC
//
//  Created by hzg on 2018/2/3.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class ProfileQuitCell: UITableViewCell {

    @IBOutlet weak var quitLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        quitLabel.text = LanguageKey.logout.value
    }
}
