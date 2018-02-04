//
//  FotgotPwd2ViewController.swift
//  GC
//
//  Created by hzg on 2018/1/30.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class FotgotPwd2ViewController: UIViewController {

    /// 输入密码，再次输入密码，注册按钮
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var pwd2TextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        navigationItem.title = LanguageKey.settingpwd.value
        navigationItem.hidesBackButton = true
        pwdTextField.placeholder = LanguageKey.input_pwd.value
        pwd2TextField.placeholder = LanguageKey.input_pwd_again.value
        saveButton.setTitle(LanguageKey.save.value, for: .normal)
        let buttonItem = UIBarButtonItem(title: LanguageKey.back_login.value, style: UIBarButtonItemStyle.done, target: self, action: #selector(onQuitButtonClicked))
        navigationItem.rightBarButtonItem = buttonItem
    }
    
    // MARK: - action methods
    /// 返回登陆
    func onQuitButtonClicked(sender:UIButton) {
        NotificationCenter.default.post(name: NoticationUserLogin, object: nil)
    }
    
    /// 点击保存密码按钮
    @IBAction func onSaveButtonClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: NoticationUserLoginSuccess, object: nil)
    }
}
