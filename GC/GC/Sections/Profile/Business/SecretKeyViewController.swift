//
//  SecretKeyViewController.swift
//  GC
//
//  Created by Sunny on 2018/4/5.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

/// 常量定义
private let cellHeight: CGFloat = 50

/// 我的秘钥地址
class SecretKeyViewController: BaseViewController {

    /// 商家列表
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var viewModel = ProfileBusinessViewModel()
    
    var curModel: BusinessInfoModel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = LanguageKey.secret_key_address.value
        
        automaticallyAdjustsScrollViewInsets = false
        tableView.register(UINib(nibName: "SecretKeyInputCell", bundle: nil), forCellReuseIdentifier: "kSecretKeyInputCell")
        tableView.mj_header = MJRefreshStateHeader(refreshingBlock: {
            self.tableHeaderRefreshing()
        })
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: {
            self.tableFooterRefreshing()
        })
        
        setDataModel()
    }
    
    deinit {
        Log.e("deinit#")
    }
    
    // 列表下拉刷新
    func tableHeaderRefreshing() {
        tableView.mj_header.beginRefreshing()
        tableView.mj_footer.resetNoMoreData()
        viewModel.page = 0
        viewModel.isRefresh = true
        MBProgressHUD.showAdded(to: self.view, animated: true)
        viewModel.getBusinessList(isAllBusiness: false)
    }
    
    // 列表尾部上拉刷新
    func tableFooterRefreshing() {
        tableView.mj_footer.beginRefreshing()
        viewModel.isRefresh = false
        if viewModel.profileBusinessModel.has_more {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            viewModel.page += 1
            viewModel.getBusinessList(isAllBusiness: false)
        } else {
            tableView.mj_footer.endRefreshingWithNoMoreData()
        }
    }
    
    /// 停止刷新
    func stopRefreshing() {
        if tableView.mj_header.isRefreshing {
            tableView.mj_header.endRefreshing()
        }
        if tableView.mj_footer.isRefreshing {
            tableView.mj_footer.endRefreshing()
        }
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    /// 请求数据
    func setDataModel() {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        viewModel.getBusinessList(isAllBusiness: false)
        
        viewModel.setCompletion(onSuccess: { (resultModel) in
            self.stopRefreshing()
            self.tableView.reloadData()
            
        }) { (error) in
            self.stopRefreshing()
            UIHelper.tip(message: error)
        }
    }
}

// MARK:  UITableViewDataSource&UITableViewDelegate
extension SecretKeyViewController : UITableViewDataSource, UITableViewDelegate {
    
    // 各个分区的单元(Cell)个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.profileBusinessModel.data.count
    }
    
    // 单元(cell)视图
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kSecretKeyInputCell", for: indexPath) as! SecretKeyInputCell
        cell.delegate = self
        cell.indexPath = indexPath
        cell.update(model: viewModel.profileBusinessModel.data[indexPath.row])
        return cell
    }
    
    // 单元(cell)的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}

extension SecretKeyViewController : SecretKeyInputCellDelegate {
    
    func inputDidSelected(at indexPath: IndexPath) {
        
        curModel = viewModel.profileBusinessModel.data[indexPath.row]
        
        AlertController.show(in: self, title: LanguageKey.input_public_key.value, text: curModel.memberPublicKey, placeholder: LanguageKey.input_public_key.value, btns: [LanguageKey.cancel.value, LanguageKey.ok.value]) { [weak self](action, text) in
            
            if action.title != LanguageKey.cancel.value && text != nil {
                if text!.count > 0 {
                    
                    self?.viewModel.inputPublicKey(dealerId: self!.curModel.dealerId, memberPublicKey: text!)
                    
                    self?.viewModel.setCompletion(onSuccess: { (resultModel) in
                        self?.curModel.memberPublicKey = text!
                        self?.tableView.reloadData()
                    
                    }, onFailure: { (error) in
                        UIHelper.tip(message: error)
                    })
                }
            }
        }
    }
}
