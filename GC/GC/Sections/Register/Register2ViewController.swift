//
//  Register2ViewController.swift
//  GC
//
//  Created by hzg on 2018/1/30.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class Register2ViewController: PortraitViewController {
    
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
        let buttonItem = UIBarButtonItem(title: LanguageKey.back_login.value, style: UIBarButtonItemStyle.done, target: self, action: #selector(onQuitButtonClicked))
        navigationItem.rightBarButtonItem = buttonItem
    }
    
    // MARK: - action methods
    /// 返回登陆
    func onQuitButtonClicked(sender:UIButton) {
        NotificationCenter.default.post(name: NoticationUserLogin, object: nil)
    }
    
    /// 点击注册按钮
    @IBAction func onRegisterButtonClicked(_ sender: UIButton) {
        register()
    }
    
    /// 注册
    fileprivate func register() {
        guard let pwd1 = pwdTextField.text else {
            UIHelper.tip(message: LanguageKey.pwd_null.value)
            return
        }
        
        guard let pwd2 = pwd2TextField.text else {
            UIHelper.tip(message: LanguageKey.pwd_null.value)
            return
        }
        
        if pwd1 != pwd2 {
            UIHelper.tip(message: LanguageKey.pwd_different.value)
            return
        }
        
        viewModel.register(tel: phone, pwd: pwd1)
        viewModel.setCompletion(onSuccess: { (resultModel) in
            
        }) { (error) in
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension Register2ViewController : UITextFieldDelegate {
    // 点击软键盘Next、go处理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == pwdTextField {
            pwd2TextField.becomeFirstResponder()
        } /*else if textField == pwdTextField {
             authCodeTextField.becomeFirstResponder()
         }*/ else {
            register()
        }
        return true
    }
}
