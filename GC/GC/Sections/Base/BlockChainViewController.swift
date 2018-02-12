//
//  BlockChainViewController.swift
//  GC
//
//  Created by hzg on 2018/2/8.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class BlockChainViewController: BaseViewController {

    /// 区块链id
    var id = "" {
        didSet {
            viewModel.getBlockChainInfo(id: id)
        }
    }
    
    private var viewModel = GeneralViewModel()
    
    /// 公钥
    @IBOutlet weak var publicLabel: UILabel!
    
    /// 私钥
    @IBOutlet weak var privateLabel: UILabel!
    
    // MARK: - override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = LanguageKey.blockchain.value
        MBProgressHUD.showAdded(to: self.view, animated: true)
        viewModel.setCompletion(onSuccess: {[weak self] (resultModel) in
            guard let wself = self else {
                return
            }
            MBProgressHUD.hide(for: wself.view, animated: true)
            wself.update(model: resultModel as! BlockChainResultModel)
        }) { [weak self] (error) in
            guard let wself = self else {
                return
            }
            UIHelper.tip(message: error)
            MBProgressHUD.hide(for: wself.view, animated: true)
        }
    }
    
    private func update(model:BlockChainResultModel) {
        publicLabel.text = model.publicKey
        privateLabel.text = model.privateKey
    }

    /// 退出登录
    @IBAction func onQuitButtonClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: NoticationUserLogout, object: nil)
    }
}
