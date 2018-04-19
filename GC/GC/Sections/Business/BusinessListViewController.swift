//
//  BusinessListViewController.swift
//  GC
//
//  Created by hzg on 2018/2/9.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 常量定义
private let cellHeight: CGFloat = 105

/// 上家列表
class BusinessListViewController: BaseViewController {
    
    /// 回调闭包
    var didSelectClosure: (([BusinessModel]) -> Void)?
    
    /// 位置
    var loaction = (x: "", y: "") {
        didSet {
            viewModel.searchDealers(x: loaction.x, y: loaction.y)
        }
    }
    
    /// 业务模块
    fileprivate let viewModel = BusinessViewModel()
    /// 当前商家
    fileprivate var businessModel: BusinessModel!
    /// 列表
    @IBOutlet weak var tableView: UITableView!
    
    
    // MAKR: - override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViewModel()
    }
    
    deinit {
        Log.e("deinit")
    }
    
    // MARK: - private methods
    /// 初始化
    private func setup() {
        navigationItem.title = LanguageKey.tab_business.value
        tableView.register(UINib(nibName: "BusinessCell", bundle: nil), forCellReuseIdentifier: "kBusinessCell")
    }
    
    private func setupViewModel() {
        viewModel.setCompletion(onSuccess: {[weak self] (resultModel) in
            MBProgressHUD.hide(for: self!.view, animated: true)
            if self!.viewModel.isBranch {
                self?.viewModel.businessBranchModel.data.insert(self!.businessModel, at: 0)
                self?.didSelectClosure!(self!.viewModel.businessBranchModel.data)
                self?.navigationController?.popViewController(animated: true)
                
            } else {
                self?.tableView.reloadData()
            }
        }) { (error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            UIHelper.tip(message: error)
        }
    }
}

// MARK: - UITableViewDataSource&UITableViewDelegate
extension BusinessListViewController: UITableViewDataSource, UITableViewDelegate {
    
    // 各个分区的单元(Cell)个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.businessResultModel.data.count
    }
    
    // 单元(cell)视图
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kBusinessCell", for: indexPath) as! BusinessCell
        cell.udpate(model: viewModel.businessResultModel.data[indexPath.row])
        return cell
    }
    
    // 单元(cell)的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    // 单元(cell)选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        businessModel = viewModel.businessResultModel.data[indexPath.row]
        viewModel.getDealerBranch(dealerId: businessModel.id)
    }
}
