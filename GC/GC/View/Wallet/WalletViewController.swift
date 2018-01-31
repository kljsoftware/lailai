//
//  WalletViewController.swift
//  GC
//
//  Created by hzg on 2018/1/27.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

// 相关常量定义
/// 单元间隔空白、单元宽高
private let blank:CGFloat = 12
private let walletCellWidth = (DEVICE_SCREEN_WIDTH - blank*3)/2, walletCellHeight:CGFloat = 100
private let personalDonateViewHeight:CGFloat = 80

/// 积分钱包
class WalletViewController: UIViewController {

    /// 捐赠视图
    @IBOutlet weak var donateLabel: UILabel!
    
    /// 网格视图
    @IBOutlet weak var collectionView: UICollectionView!
    
    /// 条幅广告容器
    @IBOutlet weak var bannerContainerView: UIView!
    
    /// 个人捐赠视图
    private lazy var personalDonateView:PersonalDonateView = {
        let _personalDonateView = Bundle.main.loadNibNamed("PersonalDonateView", owner: nil, options: nil)?.first as! PersonalDonateView
        self.bannerContainerView.addSubview(_personalDonateView)
        _personalDonateView.snp.makeConstraints { (maker) in
            maker.left.equalTo(blank)
            maker.bottom.right.equalTo(-blank)
            maker.height.equalTo(personalDonateViewHeight)
        }
        return _personalDonateView
    }()
    
    /// 数据模型
    var model = WalletResultModel()
    
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
    private func setup() {
        
        /// 标题
        navigationItem.title = LanguageKey.tab_wallet.value
        
        /// 积分捐赠区域
        donateLabel.text = LanguageKey.wallet_donate.value
        collectionView.register(UINib(nibName: "WalletCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "kWalletCollectionViewCell")
        collectionView.register(UINib(nibName: "WalletCollectionSectionView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "kWalletCollectionSectionView")
    }
    
    private func requestData() {
        personalDonateView.update()
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension WalletViewController :  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDataSource
    /// 网格分区
    /// 总共网格单元的个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    // 网格单元
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "kWalletCollectionViewCell", for: indexPath)
    }
    
    /// 分区单元
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "kWalletCollectionSectionView", for: indexPath)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    /// 设置选择单元的宽高
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: walletCellWidth, height: walletCellHeight)
    }
    
    /// 单元之前的间隔
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return blank
    }
    
    /// 点击单元
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
