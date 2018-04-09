//
//  AppDelegate.swift
//  GC
//
//  Created by hzg on 2018/1/27.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // MARK: - UIApplicationDelegate
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        
        setup()
        addons()
        registerNotification()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        unregisterNotification()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }

    // MARK: - private methods
    /// 初始化
    private func setup() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        window?.rootViewController = UIStoryboard(name: "Launch", bundle: nil).instantiateViewController(withIdentifier: "Launch")
    }
    
    /// 注册通知
    fileprivate func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(notifyUserRegister(_:)), name: NoticationUserRegister, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyUserLogin(_:)), name: NoticationUserLogin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyUserLogin(_:)), name: NoticationUserLogout, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyUserLoginSuccess(_:)), name: NoticationUserLoginSuccess, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyUserLoginSuccess(_:)), name: NoticationLanguageUpdate, object: nil)
    }
    
    /// 销毁通知
    fileprivate func unregisterNotification() {
        NotificationCenter.default.removeObserver(self, name: NoticationUserRegister, object: nil)
        NotificationCenter.default.removeObserver(self, name: NoticationUserLogin, object: nil)
        NotificationCenter.default.removeObserver(self, name: NoticationUserLogout, object: nil)
        NotificationCenter.default.removeObserver(self, name: NoticationUserLoginSuccess, object: nil)
        NotificationCenter.default.removeObserver(self, name: NoticationLanguageUpdate, object: nil)
    }
    
    /// 通知用户注册
    @objc private func notifyUserRegister(_ notify:Notification) {
        window?.rootViewController = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(withIdentifier: "registerNC")
    }
    
    /// 第三方配置相关
    private func addons() {
        
    }
    
    /// 通知用户登录/登出
    @objc private func notifyUserLogin(_ notify:Notification) {
        /// 清除token
        Token.shared.update(value: "")
        window?.rootViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "loginNC")
    }
    
    /// 通知用户登录成功
    @objc private func notifyUserLoginSuccess(_ notify:Notification) {
        window?.rootViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "Home")
    }
}

