//
//  RegisterViewController.swift
//  GC
//
//  Created by hzg on 2018/1/28.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

/// 注册
class RegisterViewController: UIViewController {
    
    /// 手机号&手机号输入
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    
    /// 验证码&验证码输入
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var codeTextField: UITextField!
    
    /// 下一步 
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        navigationItem.title = LanguageKey.register.value
        phoneLabel.text = LanguageKey.phoneNum.value
        codeLabel.text = LanguageKey.authCode.value
    }
}
