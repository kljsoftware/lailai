//
//  BusinessViewController.swift
//  GC
//
//  Created by hzg on 2018/1/27.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation

/// 常量定义
private let businessTitleWidth:CGFloat = 200, businessTitleHeight:CGFloat = 44

/// 绿色商家
class BusinessViewController: UIViewController {
    
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
    
    // 定位管理器
    fileprivate lazy var locationManager : CLLocationManager = {
        
        // 1. 创建位置管理者
        let _locationManager = CLLocationManager()
        
        // 2. 设置代理, 接收位置数据（其他方式：block、通知）
        _locationManager.delegate = self
        
        // 3.前台定位，后台定位（在info.plist文件中配置对应的key）
        
        // 4. 设置过滤距离
        // 如果当前位置, 距离上一次的位置之间的物理距离大于以下数值时, 就会通过代理, 将当前位置告诉外界
        _locationManager.distanceFilter = 100   // 每隔100 米定位一次
        
        // 5. 设置定位的精确度（定位精确度越高, 越耗电, 定位的速度越慢）
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // 6. 请求前台授权
        _locationManager.requestWhenInUseAuthorization()
        
        return _locationManager
    }()
   
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
            self?.scrollView.contentOffset.x = DEVICE_SCREEN_WIDTH
        }
        
        businessView = BusinessView(frame: CGRect(x: 0, y: 0, width: DEVICE_SCREEN_WIDTH, height: APP_CONTENT_HEIGHT))
        mapView = MapView(frame: CGRect(x: DEVICE_SCREEN_WIDTH, y: 0, width: DEVICE_SCREEN_WIDTH, height: APP_CONTENT_HEIGHT))
        scrollView.addSubview(businessView)
        scrollView.addSubview(mapView)
        scrollView.contentSize = CGSize(width: 2 * scrollView.frame.width, height: APP_CONTENT_HEIGHT)
    }
    
    /// 请求网络数据
    private func requestData() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        
        viewModel.getDealers()
    }
}

// MARK: - UIScrollViewDelegate
extension BusinessViewController : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        businessTitleView.update(isSelectBusiness: scrollView.contentOffset.x == 0)
    }
}

// MARK: - CLLocationManagerDelegate
extension BusinessViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        locationManager.stopUpdatingLocation() // 取到定位即可停止刷新，没有必要一直刷新，耗电
        mapView.location(center: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Log.e(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            Log.e("用户还未决定授权")
        case .restricted:
            Log.e("访问受限")
        case .denied:
            Log.e("定位不可用或被拒绝")
        case .authorizedAlways: /// 获得前后台授权
            Log.e("获得前后台授权")
        case .authorizedWhenInUse:
            Log.e("获得前台授权")
        }
    }
}
