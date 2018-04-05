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

    /// 文字输入
    fileprivate var textInputView: TextInputView?

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
        viewModel.getBusinessList()
    }
    
    // 列表尾部上拉刷新
    func tableFooterRefreshing() {
        tableView.mj_footer.beginRefreshing()
        viewModel.isRefresh = false
        if viewModel.profileBusinessModel.has_more {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            viewModel.page += 1
            viewModel.getBusinessList()
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
        viewModel.getBusinessList()
        
        viewModel.setCompletion(onSuccess: { (resultModel) in
            self.stopRefreshing()
            self.tableView.reloadData()
            
        }) { (error) in
            self.stopRefreshing()
        }
    }
    
    /// 手动输入秘钥
    func showEditView(placeholder: String = "") {
        
        if nil == textInputView {
            textInputView = Bundle.main.loadNibNamed("TextInputView", owner: nil, options: nil)![0] as? TextInputView
            self.view.addSubview(textInputView!)
            textInputView?.snp.makeConstraints({ (maker) in
                maker.left.right.top.bottom.equalTo(self.view)
            })
            textInputView?.inputConfirmClosure = { [weak self](result) in
                if result.count > 0 {
                    self?.viewModel.inputPublicKey(dealerName: self!.curModel.dealerName, memberPublicKey: result)
                    self?.viewModel.setCompletion(onSuccess: { (resultModel) in
                        self?.curModel.memberPublicKey = self!.textInputView!.writingTextView.text
                    }, onFailure: { (error) in
                        self?.textInputView?.writingTextView.text = ""
                        UIHelper.tip(message: error)
                    })
                }
            }
        }
        textInputView?.placeholder = placeholder
        textInputView?.show(curModel.memberPublicKey)
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
        showEditView(placeholder: "输入公钥地址（可在对应商家平台查看）")
    }
}