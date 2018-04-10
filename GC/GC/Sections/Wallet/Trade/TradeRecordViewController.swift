//
//  TradeRecordViewController.swift
//  GC
//
//  Created by Sunny on 2018/4/5.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

// 参数
struct TradeRecordParams {
    
    var dealerPublicKey = ""
    var memberPublicKey = ""
    
    init(dealerPublicKey: String, memberPublicKey: String) {
        self.dealerPublicKey    = dealerPublicKey
        self.memberPublicKey    = memberPublicKey
    }
}

class TradeRecordViewController: BaseViewController {
    
    // 参数
    var params: TradeRecordParams?
    
    // 积分
    @IBOutlet weak var scoreLabel: UILabel!
    // 确定按钮
    @IBOutlet weak var okBtn: UIButton!
    
    fileprivate let viewModel = TradeRecordViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = LanguageKey.trade_record.value
        okBtn.setTitle(LanguageKey.ok.value, for: .normal)
        okBtn.layer.borderColor = COLOR_2673FD.cgColor
        okBtn.layer.borderWidth = 1/UIScreen.main.scale
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        viewModel.getContributionNum(dealerPublicKey: params!.dealerPublicKey, memberPublicKey: params!.memberPublicKey)
        
        viewModel.setCompletion(onSuccess: {[weak self] (resultModel) in
            self?.scoreLabel.text = "\(self!.viewModel.tradeRecordModel.num) \(LanguageKey.points.value)"
            MBProgressHUD.hide(for: self!.view, animated: true)
        
        }) { (error) in
            Log.e(error)
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 确定按钮点击事件
    @IBAction func okClicked(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
