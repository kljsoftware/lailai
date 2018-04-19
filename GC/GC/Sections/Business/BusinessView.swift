//
//  BusinessView.swift
//  GC
//
//  Created by hzg on 2018/1/30.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

/// 常量定义
private let cellHeight:CGFloat = 105

/// 绿色商家
class BusinessView: UIView {
    
    /// 数据模型
    var model : BusinessResultModel? {
        didSet {
            if model != nil {
                businessModels.append(contentsOf: model!.data)
                tableView.reloadData()
            }
        }
    }
    
    /// 回调闭包
    var didSelectClosure:((_ model:BusinessModel) -> Void)?
    
    /// 刷新闭包
    var refreshingClosure:((_ page:Int) -> Void)?
    
    /// 列表数据
    fileprivate var businessModels = [BusinessModel](), page = 0
    
    /// 列表视图
    private lazy var tableView:UITableView = {
        let _tableView = UITableView(frame: self.bounds)
        _tableView.delegate = self
        _tableView.dataSource = self
        _tableView.separatorStyle = .none
        self.addSubview(_tableView)
        return _tableView
    }()
    
    // MARK: - override methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        Log.e("deinit#")
    }
    
    // MARK: - private methods
    /// 初始化
    private func setup() {
        tableView.register(UINib(nibName: "BusinessCell", bundle: nil), forCellReuseIdentifier: "kBusinessCell")
        tableView.mj_header = MJRefreshStateHeader(refreshingBlock: {
            self.tableHeaderRefreshing()
        })
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: {
            self.tableFooterRefreshing()
        })
    }
    
    /// 列表下拉刷新
    func tableHeaderRefreshing() {
        tableView.mj_header.beginRefreshing()
        businessModels.removeAll()
        tableView.mj_footer.resetNoMoreData()
        page = 0
        refreshingClosure?(0)
    }
    
    /// 列表尾部上拉刷新
    func tableFooterRefreshing() {
        tableView.mj_footer.beginRefreshing()
        if model != nil && model!.has_more {
            page += 1
            refreshingClosure?(page)
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
    }
}

// MARK:  UITableViewDataSource&UITableViewDelegate
extension BusinessView : UITableViewDataSource, UITableViewDelegate {
    
    // 各个分区的单元(Cell)个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businessModels.count
    }
    
    // 单元(cell)视图
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kBusinessCell", for: indexPath) as! BusinessCell
        cell.udpate(model: businessModels[indexPath.row])
        return cell
    }
    
    // 单元(cell)的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    // 单元(cell)选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectClosure?(businessModels[indexPath.row])
    }
}
