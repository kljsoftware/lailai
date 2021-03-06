//
//  RegisterViewController.swift
//  GC
//
//  Created by hzg on 2018/1/28.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

/// 注册
class RegisterViewController: PortraitViewController {
    
    /// 手机号&手机号输入
    @IBOutlet weak var phoneTextField: UITextField!
    
    /// 验证码&验证码输入
    @IBOutlet weak var codeTextField: UITextField!
    
    /// 下一步 
    @IBOutlet weak var nextButton: UIButton!
    
    /// 发送验证码
    @IBOutlet weak var sendCodeLabel: UILabel!
    
    /// 发送验证码按钮
    @IBOutlet weak var sendCodeButton: UIButton!
    
    /// 计时器
    private var timer:Timer? = nil
    private var current = 0 /// 倒计时总时间, 当前倒计时时间
    
    // MARK: - override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        registerNotification()
    }

    deinit {
        unregisterNotification()
    }
    
    /// 初始化
    private func setup() {
        navigationItem.title = LanguageKey.register.value
        phoneTextField.placeholder = LanguageKey.phoneNum.value
        codeTextField.placeholder = LanguageKey.authCode.value
        nextButton.setTitle(LanguageKey.nextStep.value, for: .normal)
        sendCodeLabel.text = LanguageKey.sendCode.value
        setNextEnabled()
        let buttonItem = UIBarButtonItem(title: LanguageKey.back_login.value, style: UIBarButtonItemStyle.done, target: self, action: #selector(onQuitButtonClicked))
        navigationItem.rightBarButtonItem = buttonItem
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
        let isValidPhone = phoneTextField.text != nil && !phoneTextField.text!.isBlank()
        let isValidCode  = codeTextField.text != nil && !codeTextField!.text!.isBlank()
        nextButton.isEnabled  = isValidPhone && isValidCode
    }
    
    /// 下一步
    fileprivate func next() {
        SMSSDK.commitVerificationCode(codeTextField.text!, phoneNumber: phoneTextField.text!, zone: "86") { [weak self](error) in
            guard let wself = self else {
                return
            }
            wself.stopTimer()
            wself.sendCodeLabel.text = LanguageKey.sendAgain.value
            wself.sendCodeButton.isEnabled = true
            if error == nil {
                let vc = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(withIdentifier: "register2") as! Register2ViewController
                vc.phone = wself.phoneTextField.text!
                wself.navigationController?.pushViewController(vc, animated: true)
            } else {
                Log.e("error = \(error!.localizedDescription)")
                UIHelper.tip(message: error!.localizedDescription)
            }
        }
    }
    
    /// 计时开始
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    /// 停止计时
    private func stopTimer() {
        if nil != timer {
            timer?.invalidate()
            timer = nil
        }
    }
    
    /// 计时
    @objc private func fire() {
        if current <= 0 {
            stopTimer()
            sendCodeLabel.text = LanguageKey.sendAgain.value
            sendCodeButton.isEnabled = true
            return
        }
        current -= 1
        showTime()
    }
    
    /// 显示时间
    private func showTime() {
        if current >= 0 {
            sendCodeLabel.text = "\(current) s"
        }
    }
    
    // MARK: - IBAction methods
    /// 返回登陆
    func onQuitButtonClicked(sender:UIButton) {
        NotificationCenter.default.post(name: NoticationUserLogin, object: nil)
    }
    
    /// 下一步
    @IBAction func onNextButtonClicked(_ sender: UIButton) {
        next()
    }
    
    /// 点击发送验证码
    @IBAction func onSendCodeButtonClicked(_ sender: UIButton) {
        if phoneTextField.text != nil && phoneTextField.text!.checkTelephone() {
            sender.isEnabled = false
            current = 60
            
            SMSSDK.getVerificationCode(by: SMSGetCodeMethod.SMS, phoneNumber: phoneTextField.text!, zone: "86", template: "", result: {[weak self](error) in
                guard let wself = self else {
                    return
                }
                wself.startTimer()
                if error == nil {
                    
                } else {
                    Log.e("error = \(error!.localizedDescription)")
                    UIHelper.tip(message: error!.localizedDescription)
                }
            })
        } else {
            UIHelper.tip(message: LanguageKey.phone_null.value)
        }
    }
}

extension RegisterViewController : UITextFieldDelegate {
    // 点击软键盘Next、go处理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == phoneTextField {
            codeTextField.becomeFirstResponder()
        } /*else if textField == pwdTextField {
             authCodeTextField.becomeFirstResponder()
         }*/ else {
            next()
        }
        return true
    }
}
