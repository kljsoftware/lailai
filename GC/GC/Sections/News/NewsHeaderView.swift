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
    
    private var model: NewsTopModel?
    private var navConroller: UINavigationController?
    
    func update(model: NewsTopModel, navConroller: UINavigationController?) {
        self.model = model
        self.navConroller = navConroller
        coverImageView.setImage(urlStr: NetworkImgOrWeb.getUrl(name: model.newsCover), placeholderStr: "news_header", radius: 0)
        tagLabel.isHidden = false
        tagLabel.text = model.newsTag
        titleLabel.text = model.newsTitle
    }
    
    @IBAction func onNewsTopButtonClicked(_ sender: UIButton) {
        if nil != model {
           // UIHelper.pushToWeb(urlString: model!.newsLink)
            let vc = UIStoryboard.init(name: "News", bundle: nil).instantiateViewController(withIdentifier: "news_details") as! NewsDetailsViewController
            vc.news = (model!.newsTitle, model!.newsLink)
            self.navConroller?.pushViewController(vc, animated: true)
        }
    }
}
