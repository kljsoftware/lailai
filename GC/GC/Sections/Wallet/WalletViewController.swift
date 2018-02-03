//
//  WalletViewController.swift
//  GC
//
//  Created by hzg on 2018/1/27.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

// 相关常量定义
/// 单元间隔空白、单元宽高、列表头距导航栏初始位置
private let blank:CGFloat = 12, sectionHeight:CGFloat = 32, collectionCellHeight:CGFloat = 100
private let personalDonateViewHeight:CGFloat = 100
private let tableTopMargin:CGFloat = 100
private let bannerHeight:CGFloat = 200

/// 积分钱包
class WalletViewController: UIViewController {
    
    /// 业务模块
    fileprivate let viewModel = WalletViewModel()
    
    /// 条幅广告容器
    @IBOutlet weak var bannerContainerView: UIView!
    
    /// 列表视图距上约束及列表视图
    @IBOutlet weak var tableTopLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        requestData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - private methods
    /// 初始化
    private func setup() {
        navigationItem.title = LanguageKey.tab_wallet.value
        automaticallyAdjustsScrollViewInsets = false
        tableView.register(UINib(nibName: "WalletSectionCell", bundle: nil), forCellReuseIdentifier: "kWalletSectionCell")
        tableView.register(UINib(nibName: "WalletCell", bundle: nil), forCellReuseIdentifier: "kWalletCell")
        tableView.tableHeaderView = tableViewHeaderView()
        tableTopLayoutConstraint.constant = tableTopMargin
    }
    
    /// 设置广告
    private func setupBanner() {
        let banner = BannnerView(frame: CGRect(x: 0, y: 0, width: DEVICE_SCREEN_WIDTH, height: bannerHeight))
        bannerContainerView.addSubview(banner)
        banner.setup(banners: [NetworkImg.getUrl(name: "Starbuckslogo.png"),
                               NetworkImg.getUrl(name: "ddicon02.png")])
    }
    
    /// 请求数据
    private func requestData() {
        viewModel.getPoints()
        viewModel.setCompletion(onSuccess: { [weak self](resultModel) in
            self?.tableView.reloadData()
            self?.setupBanner()
        }) { (error) in
            UIHelper.tip(message: error)
        }
    }
    
    /// 列表头部视图
    private func tableViewHeaderView() -> UIView {
        let containerView = UIView(frame:CGRect(x: 0, y: 0, width: DEVICE_SCREEN_WIDTH, height: personalDonateViewHeight))
        containerView.backgroundColor = UIColor.clear
        containerView.clipsToBounds = true
        let headerView = Bundle.main.loadNibNamed("PersonalDonateView", owner: nil, options: nil)?[0] as! PersonalDonateView
        containerView.addSubview(headerView)
        headerView.snp.makeConstraints { (maker) in
            maker.left.top.equalTo(blank)
            maker.right.bottom.equalTo(-blank)
        }
        return containerView
    }
}

// MARK:  UITableViewDataSource&UITableViewDelegate
extension WalletViewController : UITableViewDataSource, UITableViewDelegate {
    
    // 各个分区的单元(Cell)个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // 单元(cell)视图
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kWalletCell", for: indexPath) as! WalletCell
        cell.walletModel = viewModel.walletModel
        cell.didSelectItemClosure = { [weak self](model) in
            guard let wself = self else {
                return
            }
            let vc = UIStoryboard(name: "Wallet", bundle: nil).instantiateViewController(withIdentifier: "donate_record")
            wself.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableCell(withIdentifier: "kWalletSectionCell")
    }
    
    // 单元(cell)的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let count = viewModel.walletModel.data.count
        let row = count % 2 == 0 ? count / 2 : (count + 1)/2
        let height = collectionCellHeight * CGFloat(row) + CGFloat(row + 1)*blank
        return height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeight
    }
}

// MARK: - UIScrollViewDelegate
extension WalletViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let dy = scrollView.contentOffset.y
        tableTopLayoutConstraint.constant -= dy
        if tableTopLayoutConstraint.constant < 0 {
            tableTopLayoutConstraint.constant = 0
        }

        if tableTopLayoutConstraint.constant > tableTopMargin {
            tableTopLayoutConstraint.constant = tableTopMargin
        }
    }
}


