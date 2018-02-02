//
//  BaseViewModel.swift
//  GC
//
//  Created by hzg on 2018/2/1.
//  Copyright © 2018年 demo. All rights reserved.
//

typealias SuccessCallback = (_ result: BaseResultModel) -> Void
typealias FailureCallback = (_ result: String) -> Void

/// 基类ViewModel
class BaseViewModel: NSObject {
    
    /// 成功回调方法
    var successCallback: SuccessCallback?
    
    /// 失败回调方法
    var failureCallback: FailureCallback?
    
    /**
     设置完成和失败回调方法
     - parameter successCallback: 成功回调方法
     - parameter failureCallback: 失败回调方法
     */
    func setCompletion(onSuccess successCallback: @escaping SuccessCallback, onFailure failureCallback: @escaping FailureCallback) ->(Void) {
        self.successCallback = successCallback
        self.failureCallback = failureCallback
    }
}
