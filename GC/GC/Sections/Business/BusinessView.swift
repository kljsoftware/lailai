//
//  BusinessView.swift
//  GC
//
//  Created by hzg on 2018/1/30.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

/// 常量定义
private let cellHeight:CGFloat = 104

/// 绿色商家
class BusinessView: UIView {
    
    /// 数据模型
    var model : BusinessResultModel? {
        didSet {
            if model != nil {
                tableView.reloadData()
            }
        }
    }
    
    /// 回调闭包
    var didSelectClosure:((_ model:BusinessModel) -> Void)?
    
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
    
    // MARK: - private methods
    /// 初始化
    private func setup() {
        tableView.register(UINib(nibName: "BusinessCell", bundle: nil), forCellReuseIdentifier: "kBusinessCell")
    }
}

// MARK:  UITableViewDataSource&UITableViewDelegate
extension BusinessView : UITableViewDataSource, UITableViewDelegate {
    
    // 各个分区的单元(Cell)个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model == nil { return 0}
        return model!.data.count
    }
    
    // 单元(cell)视图
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kBusinessCell", for: indexPath) as! BusinessCell
        cell.udpate(model: model!.data[indexPath.row])
        return cell
    }
    
    // 单元(cell)的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    // 单元(cell)选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectClosure?(model!.data[indexPath.row])
    }
}
