//
//  DonateRecordCell.swift
//  GC
//
//  Created by hzg on 2018/2/3.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class DonateRecordCell: UITableViewCell {
    
    var queryBlockChainClosure:((_ model:DonateRecordModel) -> Void)?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var memerLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var pointLabel: UILabel!
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    private var model:DonateRecordModel?
    
    // MARK: - public methods
    func update(model:DonateRecordModel) {
        self.model = model
        nameLabel.text = model.name
        logoImageView.setImage(urlStr: NetworkImgOrWeb.getUrl(name: model.logo), placeholderStr: "", radius: 30)
        memerLabel.text = model.memberDeaName
        pointLabel.text = "\(LanguageKey.points.value)："
        pointsLabel.text = "\(model.balance)"
        timeLabel.text = model.create_date.transferFormat()
    }
    
    /// 交易Hash
    @IBAction func onQueryBlockChainButtonClicked(_ sender: UIButton) {
        if nil != model {
            queryBlockChainClosure?(model!)
        }
    }
}
