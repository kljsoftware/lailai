//
//  NewsViewController.swift
//  GC
//
//  Created by hzg on 2018/1/27.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

/// 常量定义
private let cellHeight:CGFloat = 80

/// 绿色新闻
class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = LanguageKey.tab_news.value
        automaticallyAdjustsScrollViewInsets = false
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "kNewsCell")
        tableView.tableHeaderView = tableViewHeaderView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// 列表头部视图
    private func tableViewHeaderView() -> UIView {
        let containerView = UIView(frame:CGRect(x: 0, y: 0, width: DEVICE_SCREEN_WIDTH, height: 200))
        containerView.clipsToBounds = true
        let headerView = Bundle.main.loadNibNamed("NewsHeaderView", owner: nil, options: nil)?[0] as! NewsHeaderView
        containerView.addSubview(headerView)
        headerView.snp.makeConstraints { (maker) in
            maker.left.right.top.bottom.equalTo(containerView)
        }
        return containerView
    }
}

// MARK:  UITableViewDataSource&UITableViewDelegate
extension NewsViewController : UITableViewDataSource, UITableViewDelegate {
    
    // 各个分区的单元(Cell)个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // 单元(cell)视图
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kNewsCell", for: indexPath)
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
