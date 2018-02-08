//
//  NewsCell.swift
//  GC
//
//  Created by hzg on 2018/1/29.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var sourceLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    func update(model:NewsItemModel) {
        coverImageView.setImage(urlStr: NetworkImgOrWeb.getUrl(name: model.newsCover), placeholderStr: "news_header", radius: 8)
        sourceLabel.text = model.newsSource
        nameLabel.text = model.newsTitle
        timeLabel.text = model.createdDate.transferFormat()
    }
    
}
