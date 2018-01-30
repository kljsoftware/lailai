//
//  ProfileViewController.swift
//  GC
//
//  Created by hzg on 2018/1/27.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

/// 个人详情设置界面
class ProfileViewController: UIViewController {

    /// 登陆显示视图【显示个人名称、电话信息】
    @IBOutlet weak var loginView: UIView!
   
    /// 登出显示视图
    @IBOutlet weak var logoutView: UIView!
    
    /// 退出登陆视图
    @IBOutlet weak var quitLoginView: BorderView!
    
    /// 登陆、注册或个人信息详情按钮; 设置按钮；链接商家按钮; 退出按钮
    @IBOutlet weak var loginOrProfileButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var linkBusinessButton: UIButton!
    @IBOutlet weak var quitButton: UIButton!
   
    // MARK: - override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - private methods
    private func setup() {
        navigationItem.title = LanguageKey.tab_profile.value
        loginOrProfileButton.isExclusiveTouch = true
        settingButton.isExclusiveTouch = true
        linkBusinessButton.isExclusiveTouch = true
        quitButton.isExclusiveTouch = true
    }
    
    // MARK: - IBAction methods
    /// 登陆状态，点击显示个人详细设置界面；否则进入登陆或注册流程
    @IBAction func onLoginOrProfileButtonClicked(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileDetails")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 点击进入设置界面
    @IBAction func onSetttingButtonClicked(_ sender: UIButton) {
        
    }
    
    /// 点击进入链接商家界面
    @IBAction func onLinkBusinessButtonClicked(_ sender: UIButton) {
    }
    
    /// 点击退出登陆
    @IBAction func onQuitButtonClicked(_ sender: UIButton) {
        loginView.isHidden = true
        logoutView.isHidden = false
        quitLoginView.isHidden = true
    }
}
