//
//  BusinessViewModel.swift
//  GC
//
//  Created by hzg on 2018/2/1.
//  Copyright © 2018年 demo. All rights reserved.
//


class BusinessViewModel: BaseViewModel {
    
    func getDealers() {
        HTTPSessionManager.shared.request(urlString: NetworkURL.getDealers.url, parameters: nil) { (json, success) in
            let models = BusinessModel.mj_objectArray(withKeyValuesArray: json) as? [BusinessModel]
            if success && models != nil {
                
            } else {
                
            }
        }
    }
}
