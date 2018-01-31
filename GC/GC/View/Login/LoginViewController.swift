//
//  LoginViewController.swift
//  GC
//
//  Created by hzg on 2018/1/30.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    /// 手机号输入
    @IBOutlet weak var phoneTextField: UITextField!
    
    /// 密码输入
    @IBOutlet weak var pwdTextField: UITextField!
    
    /// 验证码输入
    @IBOutlet weak var authCodeTextField: UITextField!
    
    /// 记住密码
    @IBOutlet weak var rememberpwdTextField: UITextField!
    
    /// 登陆按钮
    @IBOutlet weak var loginButton: UIButton!
    
    /// 注册按钮
    @IBOutlet weak var registerButton: UIButton!
    
    /// 忘记密码或账号
    @IBOutlet weak var forgotPwdButton: UIButton!
    
    // MARK: - override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        cancelFirstResponder()
    }
    
    // MARK: - private methods
    /// 初始化设置
    private func setup() {
        navigationItem.title = LanguageKey.login.value
        phoneTextField.placeholder = LanguageKey.phoneNum.value
        pwdTextField.placeholder = LanguageKey.pwd.value
        authCodeTextField.placeholder = LanguageKey.authCode.value
        rememberpwdTextField.placeholder = LanguageKey.rememberpwd.value
        loginButton.setTitle(LanguageKey.login.value, for: .normal)
        registerButton.setTitle(LanguageKey.register.value, for: .normal)
        forgotPwdButton.setTitle(LanguageKey.forgotpwd.value, for: .normal)
        loginButton.isExclusiveTouch = true
        registerButton.isExclusiveTouch = true
        forgotPwdButton.isExclusiveTouch = true
    }
    
    /// 取消焦点，隐藏键盘
    private func cancelFirstResponder() {
        if phoneTextField.isFirstResponder {
            phoneTextField.resignFirstResponder()
        }
        if pwdTextField.isFirstResponder {
            pwdTextField.resignFirstResponder()
        }
        if authCodeTextField.isFirstResponder {
            authCodeTextField.resignFirstResponder()
        }
    }
    
    // MARK: - IBAction methods
    /// 点击注册按钮
    @IBAction func onRegisterButtonClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: NoticationUserRegister, object: nil)
    }
    
    /// 点击忘记密码按钮
    @IBAction func onForgotButtonClicked(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "fotgotpwd")
        navigationController?.pushViewController(vc, animated: true)
    }

    /// 点击登录按钮
    @IBAction func onLoginButtonClicked(_ sender: UIButton) {
        /// 请求登陆, 登陆成功保存token并进入主界面
        NotificationCenter.default.post(name: NoticationUserLoginSuccess, object: nil)
    }
}
