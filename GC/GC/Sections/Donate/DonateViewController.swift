//
//  DonateViewController.swift
//  GC
//
//  Created by hzg on 2018/1/31.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 常量定义
private let cellHeight: CGFloat = 354

/// 公益捐赠
class DonateViewController: PortraitViewController {
    
    let viewModel = DonateViewModel()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViewModel()
    }
    
    private func setup() {
        navigationItem.title = LanguageKey.tab_donate.value
        automaticallyAdjustsScrollViewInsets = false
        tableView.register(UINib(nibName: "DonateCell", bundle: nil), forCellReuseIdentifier: "kDonateCell")
        tableView.mj_header = MJRefreshStateHeader(refreshingBlock: {
            self.tableHeaderRefreshing()
        })
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: {
            self.tableFooterRefreshing()
        })
    }
    
    private func setupViewModel() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        viewModel.getDonations()
        viewModel.setCompletion(onSuccess: { [weak self] (resultModel) in
            guard let wself = self else {
                return
            }
            wself.tableView.reloadData()
            MBProgressHUD.hide(for: wself.view, animated: true)
        }) {[weak self] (error) in
            guard let wself = self else {
                return
            }
            UIHelper.tip(message: error)
            MBProgressHUD.hide(for: wself.view, animated: true)
        }
    }
    
    func tableFooterRefreshing() {
        tableView.mj_footer.beginRefreshing()
        tableView.mj_footer.endRefreshing()
    }
    
    func tableHeaderRefreshing() {
        tableView.mj_header.beginRefreshing()
        tableView.mj_header.endRefreshing()
    }
}

// MARK:  UITableViewDataSource&UITableViewDelegate
extension DonateViewController : UITableViewDataSource, UITableViewDelegate {
    
    // 各个分区的单元(Cell)个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.donationsItems.count
    }
    
    // 单元(cell)视图
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kDonateCell", for: indexPath) as! DonateCell
        cell.update(model: viewModel.donationsItems[indexPath.row])
        cell.queryBlockChainClosure = { [weak self] (model) in
            let vc = UIStoryboard.init(name: "General", bundle: nil).instantiateViewController(withIdentifier: "block_chain") as! BlockChainViewController
            vc.id = model.id
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
    // 单元(cell)的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    // 单元(cell)选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
