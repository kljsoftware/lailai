//
//  DonateRecordViewController.swift
//  GC
//
//  Created by hzg on 2018/2/3.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 常量定义
private let cellHeight:CGFloat = 80

class DonateRecordViewController: BaseViewController {

    /// 商家id
    var id = 0 {
        didSet {
           viewModel.getContributionHistory(id: id)
        }
    }
    
    fileprivate let viewModel = DonateRecordViewModel()
    
    /// 列表
    @IBOutlet weak var tableView: UITableView!
    
    // 通过区块链查看
    @IBOutlet weak var lookBtn: UIButton!
    
    // 总额积分
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViewModel()
    }
    
    deinit {
        Log.e("deinit#")
    }
    
    /// 初始化
    private func setup() {
        
        navigationItem.title = LanguageKey.donate_record.value
        lookBtn.setTitle(LanguageKey.viewbyblock.value, for: .normal)
        lookBtn.layer.borderColor = COLOR_2673FD.cgColor
        lookBtn.layer.borderWidth = 1/UIScreen.main.scale
        
        automaticallyAdjustsScrollViewInsets = false
        tableView.register(UINib(nibName: "DonateRecordCell", bundle: nil), forCellReuseIdentifier: "kDonateRecordCell")
        tableView.mj_header = MJRefreshStateHeader(refreshingBlock: {
            self.tableHeaderRefreshing()
        })
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: {
            self.tableFooterRefreshing()
        })
    }
    
    // 列表下拉刷新
    func tableHeaderRefreshing() {
        tableView.mj_header.beginRefreshing()
        tableView.mj_header.endRefreshing()
    }
    
    // 列表尾部上拉刷新
    func tableFooterRefreshing() {
        tableView.mj_footer.beginRefreshing()
        tableView.mj_footer.endRefreshing()
    }
    
    /// 初始化viewModel
    private func setupViewModel() {
        viewModel.setCompletion(onSuccess: {[weak self] (resultModel) in
            self?.scoreLabel.text = "\(LanguageKey.total.value)：\(self!.viewModel.recordResultModel.data.balance) \(LanguageKey.points_unit.value)"
            self?.tableView.reloadData()
        }) { (error) in
            Log.e(error)
        }
    }
    
    // 通过区块链查看
    @IBAction func lookClicked(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Wallet", bundle: nil).instantiateViewController(withIdentifier: "trade_record") as! TradeRecordViewController
        vc.params = TradeRecordParams(dealerPublicKey: viewModel.recordResultModel.data.dealerPublicKey, memberPublicKey: viewModel.recordResultModel.data.memberPublicKey)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK:  UITableViewDataSource&UITableViewDelegate
extension DonateRecordViewController : UITableViewDataSource, UITableViewDelegate {
    
    // 各个分区的单元(Cell)个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recordResultModel.recordItems.count
    }
    
    // 单元(cell)视图
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kDonateRecordCell", for: indexPath) as! DonateRecordCell
        cell.update(model: viewModel.recordResultModel.recordItems[indexPath.row])
        cell.queryBlockChainClosure = { [weak self](model) in
            AlertController.show(in: self!, title: LanguageKey.hash.value, message: model.blockchain_id, btns: [LanguageKey.ok.value], handler: { (action, text) in
                
            })
        }
        return cell
    }
    
    // 单元(cell)的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}
