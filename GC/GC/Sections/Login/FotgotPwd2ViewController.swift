//
//  FotgotPwd2ViewController.swift
//  GC
//
//  Created by hzg on 2018/1/30.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class FotgotPwd2ViewController: PortraitViewController {

    var tel = ""
    
    /// 输入密码，再次输入密码，注册按钮
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var pwd2TextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        registerNotification()
    }
    
    deinit {
        unregisterNotification()
    }
    
    private func setup() {
        navigationItem.title = LanguageKey.settingpwd.value
        navigationItem.hidesBackButton = true
        pwdTextField.placeholder = LanguageKey.input_pwd.value
        pwd2TextField.placeholder = LanguageKey.input_pwd_again.value
        saveButton.setTitle(LanguageKey.save.value, for: .normal)
        let buttonItem = UIBarButtonItem(title: LanguageKey.back_login.value, style: UIBarButtonItemStyle.done, target: self, action: #selector(onQuitButtonClicked))
        navigationItem.rightBarButtonItem = buttonItem
        setNextEnabled()
    }
    
    /// 注册通知
    fileprivate func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(notifyTextFieldValueChanged(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    /// 注销通知
    fileprivate func unregisterNotification() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    /// 输入区域发生改变
    @objc private func notifyTextFieldValueChanged(_ notify : Notification!) {
        setNextEnabled()
    }
    
    /// 设置下一步按钮使能
    private func setNextEnabled() {
        let isValidPwd = pwdTextField.text != nil && !pwdTextField.text!.isBlank()
        let isValidPwd2  = pwd2TextField.text != nil && !pwd2TextField!.text!.isBlank()
        saveButton.isEnabled  = isValidPwd && isValidPwd2
    }
    
    // MARK: - action methods
    /// 返回登陆
    func onQuitButtonClicked(sender:UIButton) {
        NotificationCenter.default.post(name: NoticationUserLogin, object: nil)
    }
    
    /// 点击保存密码按钮
    @IBAction func onSaveButtonClicked(_ sender: UIButton) {
        save()
    }
    
    /// 保存密码并登录
    fileprivate func save() {
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
        
        LoginViewModel().login(tel: tel, pwd: pwdTextField.text!)
    }
}

extension FotgotPwd2ViewController : UITextFieldDelegate {
    // 点击软键盘Next、go处理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == pwdTextField {
            pwd2TextField.becomeFirstResponder()
        } /*else if textField == pwdTextField {
             authCodeTextField.becomeFirstResponder()
         }*/ else {
            save()
        }
        return true
    }
}
