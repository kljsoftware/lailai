//
//  NewsViewModel.swift
//  GC
//
//  Created by hzg on 2018/2/8.
//  Copyright © 2018年 demo. All rights reserved.
//


class NewsViewModel: BaseViewModel {
    
    var topNewsModel:NewsTopModel?
    
    var newsItems = [NewsItemModel](), page = 0, has_more = false
    
    func getNews(page:Int = 0, size:Int = 10) {
        let reqeustModel = NewsRequestModel()
        reqeustModel.page = page
        reqeustModel.size = size
        HTTPSessionManager.shared.request(urlString: NetworkURL.getNews.url, parameters: reqeustModel.mj_keyValues()) { (json, success) in
            let resultModel = NewsResultModel.mj_object(withKeyValues: json)
            if success && resultModel != nil && resultModel!.code == 0 {
                if resultModel!.topNews != nil {
                    self.topNewsModel = resultModel?.topNews
                }
                self.has_more = resultModel!.has_more
                self.newsItems.append(contentsOf: resultModel!.newsItems)
                self.successCallback?(resultModel!)
            } else {
                let msg = resultModel != nil ? resultModel!.msg : "error"
                Log.e(msg)
                self.failureCallback?(msg)
            }
        }
    }
}
