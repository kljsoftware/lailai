//
//  NewsViewController.swift
//  GC
//
//  Created by hzg on 2018/1/27.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

/// 常量定义
private let cellHeight: CGFloat = 80

/// 绿色新闻
class NewsViewController: PortraitViewController {
    
    fileprivate var viewModel = NewsViewModel()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViewModel()
    }
    
    private func setup() {
        navigationItem.title = LanguageKey.tab_news.value
        automaticallyAdjustsScrollViewInsets = false
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "kNewsCell")
        tableView.tableHeaderView = tableViewHeaderView()
        tableView.mj_header = MJRefreshStateHeader(refreshingBlock: {
            self.tableHeaderRefreshing()
        })
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: {
            self.tableFooterRefreshing()
        })
    }
    
    private func setupViewModel() {
        viewModel.setCompletion(onSuccess: {[weak self] (resultModel) in
            guard let wself = self else {
                return
            }
            MBProgressHUD.hide(for: wself.view, animated: false)
            wself.stopRefreshing()
            wself.tableReload()
        }) { [weak self](error) in
            guard let wself = self else {
                return
            }
            MBProgressHUD.hide(for: wself.view, animated: false)
            wself.stopRefreshing()
            Log.e(error)
        }
        viewModel.page = 0
        getNews()
    }
    
    ///
    private func getNews() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        viewModel.getNews(page: viewModel.page)
    }
    
    func tableFooterRefreshing() {
        tableView.mj_footer.beginRefreshing()
        if viewModel.has_more {
            viewModel.page += 1
            getNews()
        } else {
            tableView.mj_footer.endRefreshingWithNoMoreData()
        }

    }
    
    func tableHeaderRefreshing() {
        tableView.mj_header.beginRefreshing()
        tableView.mj_footer.resetNoMoreData()
        viewModel.newsItems.removeAll()
        viewModel.page = 0
        getNews()
    }
    
    func stopRefreshing() {
        if tableView.mj_footer.isRefreshing {
            tableView.mj_footer.endRefreshing()
        }
        if tableView.mj_header.isRefreshing {
            tableView.mj_header.endRefreshing()
        }
    }
    
    /// 更新界面
    private func tableReload() {
        if viewModel.topNewsModel != nil {
            (tableView.tableHeaderView?.subviews[0] as! NewsHeaderView).update(model: viewModel.topNewsModel!, navConroller: navigationController)
        }
        tableView.reloadData()
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
        return viewModel.newsItems.count
    }
    
    // 单元(cell)视图
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kNewsCell", for: indexPath) as! NewsCell
        cell.update(model: viewModel.newsItems[indexPath.row])
        return cell
    }
    
    // 单元(cell)的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    // 单元(cell)选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "News", bundle: nil).instantiateViewController(withIdentifier: "news_details") as! NewsDetailsViewController
        vc.news = (viewModel.newsItems[indexPath.row].newsTitle, viewModel.newsItems[indexPath.row].newsLink)
        navigationController?.pushViewController(vc, animated: true)
    }
}
