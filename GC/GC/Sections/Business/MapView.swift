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
    
    func location(center:CLLocation) {
        //创建一个MKCoordinateSpan对象，设置地图的范围（越小越精确）
        let latDelta = 0.05
        let longDelta = 0.05
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate,
                                                                  span: currentLocationSpan)
        //设置显示区域
        mkMapView.setRegion(currentRegion, animated: true)
        
        //创建一个大头针对象
        let objectAnnotation = MKPointAnnotation()
        
        //设置大头针的显示位置
        objectAnnotation.coordinate = center.coordinate
        
        //设置点击大头针之后显示的标题
        objectAnnotation.title = "南京夫子庙"
        
        //设置点击大头针之后显示的描述
        objectAnnotation.subtitle = "南京市秦淮区秦淮河北岸中华路"
        
        //添加大头针
        mkMapView.addAnnotation(objectAnnotation)
    }
}

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
