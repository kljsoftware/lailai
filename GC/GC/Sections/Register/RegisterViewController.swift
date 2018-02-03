//
//  RegisterViewController.swift
//  GC
//
//  Created by hzg on 2018/1/28.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

/// 注册
class RegisterViewController: UIViewController {
    
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
        let vc = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(withIdentifier: "register2") as! Register2ViewController
        vc.phone = phoneTextField.text!
        navigationController?.pushViewController(vc, animated: true)
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
    /// 下一步
    @IBAction func onNextButtonClicked(_ sender: UIButton) {
        next()
    }
    
    /// 点击发送验证码
    @IBAction func onSendCodeButtonClicked(_ sender: UIButton) {
        sender.isEnabled = false
        current = 60
        startTimer()
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
