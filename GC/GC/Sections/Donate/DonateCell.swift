//
//  DonateCell.swift
//  GC
//
//  Created by hzg on 2018/2/9.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class DonateCell: UITableViewCell {

    var queryBlockChainClosure:((_ model:DonationItemModel) -> Void)?
    
    @IBOutlet weak var orgnameLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var briefLabel: UILabel!
    private var model:DonationItemModel?
    
    @IBAction func onBlockChainButtonClicked(_ sender: UIButton) {
        if nil != model {
            queryBlockChainClosure?(model!)
        }
    }
    
    func update(model:DonationItemModel) {
        self.model = model
        orgnameLabel.text = model.orgName
        coverImageView.setImage(urlStr: NetworkImgOrWeb.getUrl(name: model.cover), placeholderStr: "news_header", radius: 0)
        titleLabel.text = model.title
        briefLabel.text = model.brief
    }
}
