//
//  MapView.swift
//  GC
//
//  Created by hzg on 2018/1/30.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

// 地图视图
class MapView: UIView {
    
    var navController: UINavigationController?
    
    /// 业务模块
    fileprivate let viewModel = BusinessViewModel()
    // 定位管理器
    fileprivate var locationManager: CLLocationManager!
    /// 搜索栏
    fileprivate var searchBar: UISearchBar!
    /// 地图
    fileprivate var mapView: MKMapView!
    /// 当前定位位置
    fileprivate var currentLocation: CLLocation?
    
    /// map around view
    fileprivate lazy var aroundView: MapAroundView = {
        let _aroundView = Bundle.main.loadNibNamed("MapAroundView", owner: nil, options: nil)![0] as! MapAroundView
        self.addSubview(_aroundView)
        _aroundView.snp.makeConstraints({ (maker) in
            maker.left.right.bottom.equalTo(self)
            maker.height.equalTo(50)
        })
        _aroundView.aroundButtonClosure = { [weak self] in
            guard let wself = self else {
                return
            }
            if wself.currentLocation != nil {
                let vc = UIStoryboard.init(name: "Business", bundle: nil).instantiateViewController(withIdentifier: "business_list") as! BusinessListViewController
                vc.loaction = ("\(wself.currentLocation!.coordinate.longitude)", "\(wself.currentLocation!.coordinate.latitude)")
                vc.didSelectClosure = { [weak self] (model) in
                    self?.loaction(models: [model])
                }
                wself.navController?.pushViewController(vc, animated: true)
            }
        }
        return _aroundView
    }()
    
    // MARK: - override methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initMapView()
        initSearchBar()
        initLocationManager()
        
        viewModel.setCompletion(onSuccess: { [weak self](resultModel) in
            guard let wself = self else {
                return
            }
            wself.loaction(models: wself.viewModel.businessResultModel.data)
        }) { (error) in
            UIHelper.tip(message: error)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initMapView() {
        mapView             = MKMapView(frame: CGRect(x: 0, y: 44, width: self.frame.size.width, height: self.frame.size.height-44))
        mapView.delegate    = self
        // 地图类型
        mapView.mapType     = MKMapType.standard
        // 获取用户当前位置信息
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        // 显示罗盘
        if #available(iOS 9.0, *) {
            mapView.showsCompass = true
        }
        self.addSubview(mapView)
    }
    
    private func initSearchBar() {
        searchBar               = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 44))
        searchBar.delegate      = self
        searchBar.placeholder   = "搜索绿色商家"
        self.addSubview(searchBar)
    }
    
    private func initLocationManager() {
        // 创建位置管理者
        locationManager                 = CLLocationManager()
        // 设置代理
        locationManager.delegate        = self
        // 每隔100 米定位一次
        locationManager.distanceFilter  = 100
        // 设置定位的精确度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 请求前台授权
        locationManager.requestWhenInUseAuthorization()
    }
    
    /// 设置中心位置
    private func setRegion(center: CLLocationCoordinate2D) {
        if !center.isValid() { return }
        //创建一个MKCoordinateSpan对象，设置地图的范围（越小越精确）
        let latDelta            = 0.05
        let longDelta           = 0.05
        let currentLocationSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let currentRegion       = MKCoordinateRegion(center: center,span: currentLocationSpan)
        mapView.setRegion(currentRegion, animated: true)
    }
    
    /// 添加大头针
    private func addAnnotion(model: BusinessModel, coor: CLLocationCoordinate2D) {
        // 创建一个大头针对象
        let objectAnnotation    = CalloutAnnotation(coordinate: coor, title: model.name)
        // 添加大头针
        mapView.addAnnotation(objectAnnotation)
        // 默认显示气泡
//        mkMapView.selectAnnotation(objectAnnotation, animated: true)
    }
    
    // MARK: - public methods
    /// 定位位置
    func loaction(models: [BusinessModel]) {
        if models.count == 0 { return }
        let coordinate  = models[0].coordinate.split(separator: ",")
        let log         = Double(coordinate[0]) ?? 0
        let lat         = Double(coordinate[1]) ?? 1
        let coor        = CLLocationCoordinate2D(latitude: lat, longitude: log)
        mapView.removeAnnotations(mapView.annotations)
        setRegion(center: coor)
        
        for model in models {
            let coordinate1 = model.coordinate.split(separator: ",")
            let log1        = Double(coordinate1[0]) ?? 0
            let lat1        = Double(coordinate1[1]) ?? 1
            let coor1       = CLLocationCoordinate2D(latitude: lat1, longitude: log1)
            addAnnotion(model: model, coor: coor1)
        }
    }
    
    /// 启动定位服务
    func startUpdatingLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    /// 关闭定位服务
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
}

// MARK: - MKMapViewDelegate
extension MapView: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // 自定义大头针
        var annotaionView: MKAnnotationView?
        // 根据模型进行分类
        if !(annotation is MKUserLocation) {
            if annotation is CalloutAnnotation {
                // 适用于顶部title，底部自定义视图，ios9之后
                annotaionView = CalloutAnnotation.createViewAnnotation(for: mapView, annotation: annotation)
                annotaionView?.annotation = annotation
            }
        }
        return annotaionView
    }
    
    // 选中大头针时触发
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
    }
    
    // 反选时触发
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        
        for annotation in self.mapView.annotations {
            if annotation is CalloutAnnotation {
                DispatchQueue.main.async {
                    mapView.removeAnnotation(annotation)
                }
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension MapView: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        currentLocation = location
        CLGeocoder().reverseGeocodeLocation(location) { [weak self](placemakes, error) in
            guard let placemark = placemakes?.first else { return }
            self?.aroundView.aroundLabel.text = "发现\(placemark.subLocality ?? "")周边的绿色商家"
        }
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

// MARK: - UISearchBarDelegate
extension MapView: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        Log.e("searchBarTextDidBeginEditing#")
        searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.searchDealers(name:searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}
