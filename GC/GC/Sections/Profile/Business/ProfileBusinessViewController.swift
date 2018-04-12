//
//  ProfileBusinessViewController.swift
//  GC
//
//  Created by hzg on 2018/2/4.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 常量定义
private let cellHeight: CGFloat = 50

class ProfileBusinessViewController: BaseViewController {

    /// 商家列表
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var viewModel = ProfileBusinessViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = LanguageKey.accept_busniss.value
        
        automaticallyAdjustsScrollViewInsets = false
        tableView.register(UINib(nibName: "ProfileBusinessCell", bundle: nil), forCellReuseIdentifier: "kProfileBusinessCell")
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
        viewModel.getBusinessList(isAllBusiness: true)
    }
    
    // 列表尾部上拉刷新
    func tableFooterRefreshing() {
        tableView.mj_footer.beginRefreshing()
        viewModel.isRefresh = false
        if viewModel.profileBusinessModel.has_more {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            viewModel.page += 1
            viewModel.getBusinessList(isAllBusiness: true)
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
        viewModel.getBusinessList(isAllBusiness: true)
        
        viewModel.setCompletion(onSuccess: { (resultModel) in
            self.stopRefreshing()
            self.tableView.reloadData()
            
        }) { (error) in
            self.stopRefreshing()
        }
    }
}

// MARK:  UITableViewDataSource&UITableViewDelegate
extension ProfileBusinessViewController : UITableViewDataSource, UITableViewDelegate {
    
    // 各个分区的单元(Cell)个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.profileBusinessModel.data.count
    }
    
    // 单元(cell)视图
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kProfileBusinessCell", for: indexPath) as! ProfileBusinessCell
        cell.update(model: viewModel.profileBusinessModel.data[indexPath.row])
        return cell
    }
    
    // 单元(cell)的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    // 单元(cell)选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let businessModel = viewModel.profileBusinessModel.data[indexPath.row]
        
        if businessModel.memberPublicKey != "" {
            let url = URL(string: businessModel.ios_jump_url)!
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            } else {
                UIApplication.shared.openURL(URL(string: "didtaxi://")!)
            }
        
        } else {
            let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "business_auth") as! BusinessAuthViewController
            vc.businessname = businessModel.dealerName
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
