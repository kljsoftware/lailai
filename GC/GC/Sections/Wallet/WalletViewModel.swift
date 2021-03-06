//
//  WalletViewModel.swift
//  GC
//
//  Created by hzg on 2018/2/1.
//  Copyright © 2018年 demo. All rights reserved.
//

class WalletViewModel: BaseViewModel {

    /// 积分捐赠模型
    var walletModel = WalletResultModel()
    
    /// 积分钱包基础数据
    var walletBaseModel = WalletBaseResultModel()
    
    /// 分页
    var page = 0
    
    /// 标记是刷新还是加载
    var isRefresh = true

    
    /// 3.1 获取积分钱包基础数据
    func getPointsBase() {
        HTTPSessionManager.shared.request(urlString: NetworkURL.getPointsBase.url, parameters: nil) { (json, success) in
            let resultModel = WalletBaseResultModel.mj_object(withKeyValues: json)
            if success && resultModel != nil && resultModel!.code == 0 {
                self.walletBaseModel = resultModel!
                self.successCallback?(resultModel!)
            } else {
                let msg = resultModel != nil ? resultModel!.msg : "error"
                Log.e(msg)
                self.failureCallback?(msg)
            }
        }
    }
    
    /// 积分捐赠
    func getPoints() {
        let reqeustModel = WalletRequestModel()
        reqeustModel.page = page
        reqeustModel.size = 10
        HTTPSessionManager.shared.request(urlString: NetworkURL.getPoints.url, parameters: reqeustModel.mj_keyValues()) { (json, success) in
            let resultModel = WalletResultModel.mj_object(withKeyValues: json)
            if success && resultModel != nil && resultModel!.code == 0 {
                if self.isRefresh {
                    self.walletModel.shopItems.removeAll()
                    self.walletModel.shopItems = resultModel!.shopItems
                } else {
                    self.walletModel.shopItems += resultModel!.shopItems
                }
                self.walletModel.has_more = resultModel!.has_more
                self.successCallback?(resultModel!)
            } else {
                let msg = resultModel != nil ? resultModel!.msg : "error"
                Log.e(msg)
                self.failureCallback?(msg)
            }
        }
    }
    
}
