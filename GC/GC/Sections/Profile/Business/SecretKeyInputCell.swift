//
//  SecretKeyInputCell.swift
//  GC
//
//  Created by Sunny on 2018/4/5.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

protocol SecretKeyInputCellDelegate : NSObjectProtocol {
    
    func inputDidSelected(at indexPath: IndexPath)
}

class SecretKeyInputCell: UITableViewCell {
    
    @IBOutlet weak var businessnameLabel: UILabel!
    
    @IBOutlet weak var secretKeyLabel: UILabel!
    
    var indexPath: IndexPath!
    
    // 申明代理属性
    weak var delegate: SecretKeyInputCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// 手动输入点击事件
    @IBAction func inputClicked(_ sender: UIButton) {
        self.delegate?.inputDidSelected(at: indexPath)
    }
    
    /// 刷新数据
    func update(model: BusinessInfoModel) {
        businessnameLabel.text = model.dealerName
        if model.memberPublicKey != "" {
            secretKeyLabel.text =  model.memberPublicKey
            secretKeyLabel.font = UIFont.systemFont(ofSize: 8)
        } else {
            secretKeyLabel.text =  "尚未授权商"
            secretKeyLabel.font = PINGFANG_FONT_12
        }
    }
    
}