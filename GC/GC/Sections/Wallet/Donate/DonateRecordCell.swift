//
//  DonateRecordCell.swift
//  GC
//
//  Created by hzg on 2018/2/3.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class DonateRecordCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var memerLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var pointLabel: UILabel!
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    // MARK: - public methods
    func update(model:DonateRecordModel) {
        nameLabel.text = model.name
        logoImageView.setImage(urlStr: NetworkImgOrWeb.getUrl(name: model.logo), placeholderStr: "", radius: 30)
        memerLabel.text = model.memberDeaName
        pointLabel.text = "积分："
        pointsLabel.text = "\(model.balance)"
        timeLabel.text = model.create_date.transferFormat()
    }
}
