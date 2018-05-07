//
//  PuddingViewController.swift
//  GC
//
//  Created by sunzhiwei on 2018/5/7.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

/// 我的布丁
class PuddingViewController: BaseViewController {

    /// 列表
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var viewModel = PuddingViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = LanguageKey.my_green_pudding.value
        automaticallyAdjustsScrollViewInsets = false
        tableView.register(UINib(nibName: "PointsTotalCell", bundle: nil), forCellReuseIdentifier: "kPointsTotalCell")
        tableView.register(UINib(nibName: "PointsTypeCell", bundle: nil), forCellReuseIdentifier: "kPointsTypeCell")
        tableView.mj_header = MJRefreshStateHeader(refreshingBlock: {
            self.tableHeaderRefreshing()
        })
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: {
            self.tableFooterRefreshing()
        })
        setDataModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        Log.e("deinit#")
    }
    
    /// 列表下拉刷新
    private func tableHeaderRefreshing() {
        tableView.mj_header.beginRefreshing()
        tableView.mj_footer.resetNoMoreData()
        viewModel.page = 0
        viewModel.isRefresh = true
        MBProgressHUD.showAdded(to: self.view, animated: true)
        viewModel.getPuddingRecord()
    }
    
    /// 列表尾部上拉刷新
    private func tableFooterRefreshing() {
        tableView.mj_footer.beginRefreshing()
        viewModel.isRefresh = false
        if viewModel.puddingModel.has_more {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            viewModel.page += 1
            viewModel.getPuddingRecord()
        } else {
            tableView.mj_footer.endRefreshingWithNoMoreData()
        }
    }
    
    /// 停止刷新
    private func stopRefreshing() {
        if tableView.mj_header.isRefreshing {
            tableView.mj_header.endRefreshing()
        }
        if tableView.mj_footer.isRefreshing {
            tableView.mj_footer.endRefreshing()
        }
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    /// 请求数据
    private func setDataModel() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        viewModel.getPuddingRecord()
        
        viewModel.setCompletion(onSuccess: { (resultModel) in
            self.stopRefreshing()
            self.tableView.reloadData()
            
        }) { (error) in
            self.stopRefreshing()
        }
    }
}

// MARK: UITableViewDataSource & UITableViewDelegate
extension PuddingViewController: UITableViewDataSource, UITableViewDelegate {
    
    // 各个分区的单元(Cell)个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.puddingModel.puddingRecordinfos.count
    }
    
    // 单元(cell)视图
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "kPointsTotalCell", for: indexPath) as! PointsTotalCell
            cell.update(model: viewModel.puddingModel)
            cell.instructionsClosure = { [weak self] in
                let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "pudding_instructions")
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "kPointsTypeCell", for: indexPath) as! PointsTypeCell
            cell.update(model: viewModel.puddingModel.puddingRecordinfos[indexPath.row-1])
            return cell
        }
    }
    
    // 单元(cell)的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 80 : 50
    }
}
