//
//  ProfileSettingPwdViewController.swift
//  GC
//
//  Created by hzg on 2018/1/30.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class ProfileSettingPwdViewController: UIViewController {
    
    /// 业务模块
    let viewModel = ProfileViewModel()

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
        pwdTextField.placeholder = LanguageKey.input_pwd.value
        pwd2TextField.placeholder = LanguageKey.input_pwd_again.value
        saveButton.setTitle(LanguageKey.save.value, for: .normal)
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
    
    /// 点击保存密码按钮
    @IBAction func onSaveButtonClicked(_ sender: UIButton) {
        let oldpwd = UserDefaults.standard.value(forKey: UserDefaultUserPwd) as? String ?? ""
        viewModel.modityPassword(newpwd: pwdTextField.text!, oldpwd: oldpwd)
        viewModel.setCompletion(onSuccess: { [weak self](resultModel) in
            guard let wself = self else {
                return
            }
            UserDefaults.standard.set(wself.pwdTextField.text!, forKey: UserDefaultUserPwd)
            UIHelper.tip(message: "修改成功")
        }) { (error) in
            UIHelper.tip(message: error)
        }
    }
}
