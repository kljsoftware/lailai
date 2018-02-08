//
//  WalletCollectionViewCell.swift
//  GC
//
//  Created by hzg on 2018/1/29.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class WalletCollectionViewCell: UICollectionViewCell {
    
    /// bg
    @IBOutlet weak var backImageView: UIImageView!
    
    /// logo
    @IBOutlet weak var logoImageView: UIImageView!
    
    /// name
    @IBOutlet weak var nameLabel: UILabel!
   
    /// 捐赠积分额&及标签名
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var balance: UILabel!
    
    /// 捐赠成员名
    @IBOutlet weak var memberNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - public methods
    func update(model:WalletModel) {
        let color = UIColor.hexStringToColor(model.color)
        backImageView.backgroundColor = color
        memberNameLabel.textColor = color
        logoImageView.setImage(urlStr: NetworkImgOrWeb.getUrl(name: model.logo), placeholderStr: "", radius: 30)
        nameLabel.text = model.name
        balanceLabel.text = "\(model.balance)"
        balance.text = LanguageKey.balance.value
        memberNameLabel.text = model.memberDeaName
    }
}
