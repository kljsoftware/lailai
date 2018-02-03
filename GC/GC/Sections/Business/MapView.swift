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
    
    /// 地图
    fileprivate lazy var mkMapView:MKMapView = {
        let _mkMapView = MKMapView(frame:self.bounds)
        _mkMapView.mapType = MKMapType.standard
        _mkMapView.delegate = self
        return _mkMapView
    }()
    
    // MARK: - override methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mkMapView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 定位位置
    func loaction(model:BusinessModel) {
        let coordinate = model.coordinate.split(separator: ",")
        let log = Double(coordinate[0]) ?? 0
        let lat = Double(coordinate[1]) ?? 1
        let coor = CLLocationCoordinate2D(latitude: lat, longitude: log)
        mkMapView.removeAnnotations(mkMapView.annotations)
        setRegion(center: coor)
        addAnnotion(model: model, coor: coor)
    }
    
    /// 设置中心位置
    func setRegion(center:CLLocationCoordinate2D) {
        //创建一个MKCoordinateSpan对象，设置地图的范围（越小越精确）
        let latDelta = 0.05
        let longDelta = 0.05
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center,span: currentLocationSpan)
        mkMapView.setRegion(currentRegion, animated: true)
    }
    
    /// 添加大头针
    func addAnnotion(model:BusinessModel, coor:CLLocationCoordinate2D) {
       
        //创建一个大头针对象
        let objectAnnotation = MKPointAnnotation()
        
        //设置大头针的显示位置
        objectAnnotation.coordinate = coor
        
        //设置点击大头针之后显示的标题
        objectAnnotation.title = model.name
        
        //设置点击大头针之后显示的描述
        objectAnnotation.subtitle = model.address
        
        //添加大头针
        mkMapView.addAnnotation(objectAnnotation)
    }
}

// MARK: - MKMapViewDelegate
extension MapView : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuserId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuserId)
            as? MKPinAnnotationView
        if pinView == nil {
            //创建一个大头针视图
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuserId)
            pinView?.canShowCallout = true
            pinView?.animatesDrop = true
            //设置大头针颜色
            if #available(iOS 9.0, *) {
                pinView?.pinTintColor = UIColor.green
            } else {
                pinView?.pinColor = .green
            }
            //设置大头针点击注释视图的右侧按钮样式
            pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }else{
            pinView?.annotation = annotation
        }
        
        return pinView
    }
}

// MARK: - CLLocationManagerDelegate
extension MapView : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        locationManager.stopUpdatingLocation() // 取到定位即可停止刷新，没有必要一直刷新，耗电
        setRegion(center: location.coordinate)
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