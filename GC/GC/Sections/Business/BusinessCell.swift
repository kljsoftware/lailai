//
//  BusinessCell.swift
//  GC
//
//  Created by hzg on 2018/1/30.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    /// 商标
    @IBOutlet weak var logoImageView: UIImageView!
    
    ///  商家名
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    /// 地址
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - public methods
    /// 更新
    func udpate(model:BusinessModel) {
        
        /// logo
        logoImageView.setImage(urlStr: NetworkImgOrWeb.getUrl(name: model.logo), placeholderStr: "", radius: 30)
        
        /// 商家名
        nameLabel.text = model.name
        
        /// 号码
        phoneLabel.text = "—— ——"
        
        /// 星级评价显示
        let stars = [star1, star2, star3, star4, star5]
        for star in stars {
            star?.isHidden = true
        }
        stars[0]?.isHidden = false
        if model.level > 0 {
            for i in 0..<model.level {
                stars[i]?.isHidden = false
            }
        }
        
        /// 地址
        addressLabel.text = model.address
        
    }
    
}
