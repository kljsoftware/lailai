//
//  LoginViewController.swift
//  GC
//
//  Created by hzg on 2018/1/30.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    /// 业务模块
    private let viewModel = LoginViewModel()
    
    /// 手机号输入
    @IBOutlet weak var phoneTextField: UITextField!
    
    /// 密码输入
    @IBOutlet weak var pwdTextField: UITextField!
    
    /// 验证码输入
 //   @IBOutlet weak var authCodeTextField: UITextField!
    
    /// 记住密码
    @IBOutlet weak var rememberpwdTextField: UITextField!
    
    /// 登陆按钮
    @IBOutlet weak var loginButton: UIButton!
    
    /// 注册按钮
    @IBOutlet weak var registerButton: UIButton!
    
    /// 忘记密码或账号
    @IBOutlet weak var forgotPwdButton: UIButton!
    
    /// 记住密码开关
    @IBOutlet weak var rememberSwitch: UISwitch!
    
    // MARK: - override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        registerNotification()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        cancelFirstResponder()
    }
    
    deinit {
        unregisterNotification()
    }
    
    // MARK: - private methods
    /// 初始化设置
    private func setup() {
        navigationItem.title = LanguageKey.login.value
        phoneTextField.placeholder = LanguageKey.phoneNum.value
        pwdTextField.placeholder = LanguageKey.pwd.value
        //authCodeTextField.placeholder = LanguageKey.authCode.value
        rememberpwdTextField.placeholder = LanguageKey.rememberpwd.value
        loginButton.setTitle(LanguageKey.login.value, for: .normal)
        registerButton.setTitle(LanguageKey.register.value, for: .normal)
        forgotPwdButton.setTitle(LanguageKey.forgotpwd.value, for: .normal)
        loginButton.isExclusiveTouch = true
        registerButton.isExclusiveTouch = true
        forgotPwdButton.isExclusiveTouch = true
        phoneTextField.text = UserDefaults.standard.value(forKey: UserDefaultUserName) as? String
        let isRememberPwd = (UserDefaults.standard.value(forKey: UserDefaultRememberPwd) ?? "true") as! String
        pwdTextField.text = isRememberPwd == "true" ? UserDefaults.standard.value(forKey: UserDefaultUserPwd) as? String : ""
        rememberSwitch.setOn(isRememberPwd == "true", animated: false)
        setLoginEnabled()
    }
    
    /// 取消焦点，隐藏键盘
    private func cancelFirstResponder() {
        if phoneTextField.isFirstResponder {
            phoneTextField.resignFirstResponder()
        }
        if pwdTextField.isFirstResponder {
            pwdTextField.resignFirstResponder()
        }
//        if authCodeTextField.isFirstResponder {
//            authCodeTextField.resignFirstResponder()
//        }
    }
    
    // 注册通知
    fileprivate func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(notifyTextFieldValueChanged(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    // 注销通知
    fileprivate func unregisterNotification() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    /// 输入区域发生改变
    @objc private func notifyTextFieldValueChanged(_ notify : Notification!) {
        setLoginEnabled()
    }
    
    /// 设置登陆按钮使能
    private func setLoginEnabled() {
        let isValidPhone = phoneTextField.text != nil && !phoneTextField.text!.isBlank()
        let isValidPwd   = pwdTextField.text != nil && !pwdTextField.text!.isBlank()
        loginButton.isEnabled  = isValidPhone && isValidPwd
    }
    
    /// 登陆
    fileprivate func login() {
        if loginButton.isEnabled {
            viewModel.login(tel: phoneTextField.text!, pwd: pwdTextField.text!)
        }
    }
    
    // MARK: - IBAction methods
    /// 点击注册按钮
    @IBAction func onRegisterButtonClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: NoticationUserRegister, object: nil)
    }
    
    /// 点击忘记密码按钮
    @IBAction func onForgotButtonClicked(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "fotgotpwd") as! FotgotPwdViewController
        vc.tel = phoneTextField.text ?? ""
        _ = navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 开关变化监听
    @IBAction func onSwitchChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn ? "true" : "false", forKey: UserDefaultRememberPwd)
    }
    
    /// 点击登录按钮
    @IBAction func onLoginButtonClicked(_ sender: UIButton) {
        login()
    }

}

extension LoginViewController : UITextFieldDelegate {
    // 点击软键盘Next、go处理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == phoneTextField {
            pwdTextField.becomeFirstResponder()
        } /*else if textField == pwdTextField {
            authCodeTextField.becomeFirstResponder()
        }*/ else {
            login()
        }
        return true
    }
}
