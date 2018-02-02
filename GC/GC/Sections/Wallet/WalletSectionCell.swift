//
//  WalletSectionCell.swift
//  GC
//
//  Created by hzg on 2018/2/2.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class WalletSectionCell: UITableViewCell {

    /// 捐赠视图
    @IBOutlet weak var donateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        donateLabel.text = LanguageKey.wallet_donate.value
    }
}
