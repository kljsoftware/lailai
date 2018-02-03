//
//  SplashViewController.swift
//  GC
//
//  Created by hzg on 2018/1/28.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

/// 闪屏页
class SplashViewController: UIViewController {
    
    private let viewModel = LaunchViewModel()

    /// 跳过&广告展示倒计时
    @IBOutlet weak var skipLabel: UILabel!
    @IBOutlet weak var countDownTimeLabel: UILabel!
    
    /// 广告页面
    @IBOutlet weak var adImageView: UIImageView!
   
    /// 计时器
    private var timer:Timer? = nil
    private var duration = 0, current = 0 /// 倒计时总时间, 当前倒计时时间
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    deinit {
        Log.e("deinit")
    }

    /// 点击跳过按钮
    @IBAction func onSkipButtonClicked(_ sender: UIButton) {
        stopTimer()
        finished()
    }
    
    // MARK: - private methods
    /// 初始化
    private func setup() {
        skipLabel.text = LanguageKey.splash_skip.value
        duration = 5
        current = duration
        showTime()
        startTimer()
    }
    
    /// 显示时间
    private func showTime() {
        if current >= 1 {
            countDownTimeLabel.text = "\(current)s"
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
        if current <= 1 {
            stopTimer()
            finished()
            return
        }
        current -= 1
        showTime()
    }
    
    /// 记时结束
    private func finished() {
        viewModel.checkToken()
    }
}