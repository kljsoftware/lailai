//
//  BusinessViewController.swift
//  GC
//
//  Created by hzg on 2018/1/27.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit
import SnapKit

/// 常量定义
private let businessTitleWidth:CGFloat = 140, businessTitleHeight:CGFloat = 44

/// 绿色商家
class BusinessViewController: PortraitViewController {
    
    private let viewModel = BusinessViewModel()
    
    /// 导航标题视图
    fileprivate lazy var businessTitleView:BusinessTitleView = {
        let _businessTitleView = Bundle.main.loadNibNamed("BusinessTitleView", owner: nil, options: nil)![0] as! BusinessTitleView
        self.navigationItem.titleView = _businessTitleView
        self.navigationItem.titleView?.snp.makeConstraints({ (maker) in
            maker.centerX.centerY.equalToSuperview()
            maker.width.equalTo(businessTitleWidth)
            maker.height.equalTo(businessTitleHeight)
        })
        return _businessTitleView
    }()
    
    /// 滚动视图
    @IBOutlet weak var scrollView: UIScrollView!
    
    /// 绿色商家
    private var businessView:BusinessView!
    
    /// 地图
    fileprivate var mapView:MapView!
    
    /// 默认第一次定位
    fileprivate var fristDefautLocation = true
   
    // MARK: - override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        requestData()
    }
    
    /// 初始化设置
    private func setup() {
        businessTitleView.businessButtonCallback = { [weak self] in
            self?.scrollView.contentOffset.x = 0
        }
        businessTitleView.mapbuttonCallback = { [weak self] in
            guard let wself = self else {
                return
            }
            wself.scrollView.contentOffset.x = DEVICE_SCREEN_WIDTH
            wself.fristMapLoaction()
        }
        automaticallyAdjustsScrollViewInsets = false
        businessView = BusinessView(frame: CGRect(x: 0, y: 0, width: DEVICE_SCREEN_WIDTH, height: APP_CONTENT_HEIGHT))
        businessView.didSelectClosure = {[weak self] (model) in
            guard let wself = self else {
                return
            }
            wself.businessTitleView.update(isSelectBusiness: false)
            wself.fristDefautLocation = false
            wself.scrollView.contentOffset.x = DEVICE_SCREEN_WIDTH
            wself.mapView.loaction(models: [model])
        }
        mapView = MapView(frame: CGRect(x: DEVICE_SCREEN_WIDTH, y: 0, width: DEVICE_SCREEN_WIDTH, height: APP_CONTENT_HEIGHT))
        mapView.navController = navigationController
        scrollView.addSubview(businessView)
        scrollView.addSubview(mapView)
        scrollView.contentSize = CGSize(width: 2 * DEVICE_SCREEN_WIDTH, height: APP_CONTENT_HEIGHT)
    }
    
    /// 请求网络数据
    private func requestData() {

        viewModel.getDealers()
        viewModel.setCompletion(onSuccess: { [weak self](resultModel) in
            self?.businessView.model = self?.viewModel.businessResultModel
        }) { (error) in
            UIHelper.tip(message: error)
        }
    }
    
    /// 第一次地图定位
    fileprivate func fristMapLoaction() {
        if viewModel.businessResultModel.data.count > 0 && fristDefautLocation {
            let model = viewModel.businessResultModel.data.first!
            mapView.loaction(models: [model])
            fristDefautLocation = false
        }
    }
}

// MARK: - UIScrollViewDelegate
extension BusinessViewController : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let isMap = scrollView.contentOffset.x != 0
        businessTitleView.update(isSelectBusiness: !isMap)
        if isMap {
            fristMapLoaction()
        }
    }
}
