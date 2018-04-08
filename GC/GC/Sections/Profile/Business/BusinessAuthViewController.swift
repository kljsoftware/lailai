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
        navigationItem.title = "\(businessname)\(LanguageKey.port_auth.value)"
        userTextField.placeholder = "\(businessname)\(LanguageKey.login_name.value)"
        pwdTextField.placeholder = "\(businessname)\(LanguageKey.login_pwd.value)"
        authButton.setTitle("\(LanguageKey.auth_green_points_get.value)\(businessname)\(LanguageKey.points_data.value)", for: .normal)
    }

}
