//
//  WalletCell.swift
//  GC
//
//  Created by hzg on 2018/2/2.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

/// 单元间隔空白、单元宽高
private let blank:CGFloat = 12
private let walletCellWidth = (DEVICE_SCREEN_WIDTH - blank*3)/2, walletCellHeight:CGFloat = 100

/// 积分捐赠单元
class WalletCell: UITableViewCell {

    /// 网格视图
    @IBOutlet weak var collectionView: UICollectionView!
    
    /// 积分捐赠模型
    var walletModel = WalletResultModel() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    /// 捐赠项点击回调闭包
    var didSelectItemClosure:((_ model: WalletModel) -> Void)?
    
    /// 初始化
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "WalletCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "kWalletCollectionViewCell")
        collectionView.register(UINib(nibName: "WalletCollectionSectionView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "kWalletCollectionSectionView")
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension WalletCell :  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDataSource
    /// 网格分区
    /// 总共网格单元的个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return walletModel.data.count
    }
    
    // 网格单元
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kWalletCollectionViewCell", for: indexPath) as! WalletCollectionViewCell
        cell.update(model: walletModel.data[indexPath.row])
        return cell
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
        let vc = UIStoryboard(name: "Wallet", bundle: nil).instantiateViewController(withIdentifier: "donate_record")
        didSelectItemClosure?(walletModel.data[indexPath.row])
    }
}
