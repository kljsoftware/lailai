//
//  Register2ViewController.swift
//  GC
//
//  Created by hzg on 2018/1/30.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class Register2ViewController: UIViewController {
    
    /// 参数:电话号码
    var phone = ""
    
    private let viewModel = RegiserViewModel()

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
        
        guard let pwd1 = pwdTextField.text else {
            UIHelper.tip(message: "密码不能为空")
            return
        }
        
        guard let pwd2 = pwd2TextField.text else {
            UIHelper.tip(message: "密码不能为空")
            return
        }
        
        if pwd1 != pwd2 {
            UIHelper.tip(message: "密码输入不一致")
            return
        }
        
        viewModel.register(tel: phone, pwd: pwd1)
    }
}
