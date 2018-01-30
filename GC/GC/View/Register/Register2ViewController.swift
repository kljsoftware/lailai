//
//  Register2ViewController.swift
//  GC
//
//  Created by hzg on 2018/1/30.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class Register2ViewController: UIViewController {

    /// 输入密码，再次输入密码，注册按钮
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var pwd2TextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        navigationItem.title = LanguageKey.register.value
        navigationItem.hidesBackButton = true
        pwdTextField.placeholder = LanguageKey.input_pwd.value
        pwd2TextField.placeholder = LanguageKey.input_pwd_again.value
        registerButton.setTitle(LanguageKey.register.value, for: .normal)
    }
    
    /// 点击注册按钮
    @IBAction func onRegisterButtonClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: NoticationUserLoginSuccess, object: nil)
    }
}
