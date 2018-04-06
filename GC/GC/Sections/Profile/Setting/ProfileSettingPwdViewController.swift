//
//  ProfileSettingPwdViewController.swift
//  GC
//
//  Created by hzg on 2018/1/30.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class ProfileSettingPwdViewController: BaseViewController {
    
    /// 业务模块
    let viewModel = ProfileViewModel()
    
    /// 旧密码，输入密码，再次输入密码，注册按钮
    @IBOutlet weak var oldPwdTF: UITextField!
    @IBOutlet weak var newPwdTF: UITextField!
    @IBOutlet weak var newPwdTF1: UITextField!
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
        oldPwdTF.placeholder = LanguageKey.inut_pwd_old.value
        newPwdTF.placeholder = LanguageKey.input_pwd.value
        newPwdTF1.placeholder = LanguageKey.input_pwd_again.value
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
        let isValidPwd = newPwdTF.text != nil && !newPwdTF.text!.isBlank()
        let isValidPwd2  = newPwdTF1.text != nil && !newPwdTF1.text!.isBlank()
        saveButton.isEnabled  = isValidPwd && isValidPwd2
    }
    
    fileprivate func save() {
        
        let oldpwd = UserDefaults.standard.value(forKey: UserDefaultUserPwd) as? String ?? ""
        
        if oldPwdTF.text != oldpwd {
            UIHelper.tip(message: "旧密码错误")
            return
        }
        
        guard let pwd1 = newPwdTF.text else {
            UIHelper.tip(message: "密码不能为空")
            return
        }
        
        guard let pwd2 = newPwdTF1.text else {
            UIHelper.tip(message: "密码不能为空")
            return
        }
        
        if pwd1 != pwd2 {
            UIHelper.tip(message: "密码输入不一致")
            return
        }
        
        viewModel.modityPassword(newpwd: newPwdTF.text!, oldpwd: oldpwd)
        viewModel.setCompletion(onSuccess: { [weak self](resultModel) in
            guard let wself = self else {
                return
            }
            UserDefaults.standard.set(wself.newPwdTF.text!, forKey: UserDefaultUserPwd)
            UIHelper.tip(message: "修改成功")
            wself.navigationController?.popViewController(animated: true)
        }) { (error) in
            UIHelper.tip(message: error)
        }
    }
    
    /// 点击保存密码按钮
    @IBAction func onSaveButtonClicked(_ sender: UIButton) {
        save()
    }
}
