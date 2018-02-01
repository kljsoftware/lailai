//
//  FotgotPwdViewController.swift
//  GC
//
//  Created by hzg on 2018/1/30.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class FotgotPwdViewController: UIViewController {

    /// 手机号&手机号输入
    @IBOutlet weak var phoneTextField: UITextField!
    
    /// 验证码&验证码输入
    @IBOutlet weak var codeTextField: UITextField!
    
    /// 下一步
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        navigationItem.title = LanguageKey.forgotpwd.value
        navigationItem.hidesBackButton = true
        phoneTextField.placeholder = LanguageKey.phoneNum.value
        codeTextField.placeholder = LanguageKey.authCode.value
        nextButton.setTitle(LanguageKey.nextStep.value, for: .normal)
    }
    
    /// 下一步
    @IBAction func onNextButtonClicked(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "fotgotpwd2")
        navigationController?.pushViewController(vc, animated: true)
    }
}
