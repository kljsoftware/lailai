//
//  NewsHeaderView.swift
//  GC
//
//  Created by hzg on 2018/1/29.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class NewsHeaderView: UIView {
    
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func update(model:NewsTopModel) {
        coverImageView.setImage(urlStr: NetworkImgOrWeb.getUrl(name: model.newsCover), placeholderStr: "news_header", radius: 0)
        tagLabel.text = model.newsTag
        titleLabel.text = model.newsTitle
    }
}
