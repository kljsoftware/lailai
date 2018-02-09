//
//  BusinessAuthViewController.swift
//  GC
//
//  Created by hzg on 2018/2/9.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class BusinessAuthViewController: BaseViewController {

    var businessname = "" {
        didSet {
            perform(#selector(delay), with: nil, afterDelay: 0.1)
        }
    }
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var authButton: UIButton!
    
    @objc private func delay() {
        navigationItem.title = "\(businessname)接口授权"
        userTextField.placeholder = "\(businessname)登录名"
        pwdTextField.placeholder = "\(businessname)登录密码"
        authButton.setTitle("授权绿色积分钱包获取\(businessname)积分数据", for: .normal)
    }

}
