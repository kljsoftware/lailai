//
//  AnnotationView.swift
//  GC
//
//  Created by sunzhiwei on 2018/4/17.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit
import MapKit

// 边距
public let CalloutBorderSpace: CGFloat = 5

/// 自定义大头针
class CalloutAnnotation: NSObject, MKAnnotation {
    
    /// 位置
    var coordinate: CLLocationCoordinate2D
    /// 主标题
    var title: String?
    /// 副标题
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
        super.init()
    }
    
    /// 在模型中创建大头针视图
    class func createViewAnnotation(for mapView: MKMapView, annotation: MKAnnotation) -> MKAnnotationView {
        let identifier = "DetailCalloutAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if annotationView == nil {
            // 创建一个大头针视图
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            // 设置大头针颜色
            if #available(iOS 9.0, *) {
                annotationView?.pinTintColor = UIColor.green
                // 添加约束才可以使用自定义视图
                let backgroundView = UIView(frame: CGRect.zero)
                backgroundView.backgroundColor = UIColor.red
                let widthConstraint = NSLayoutConstraint(item: backgroundView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
                backgroundView.addConstraint(widthConstraint)
                let heightConstraint = NSLayoutConstraint(item: backgroundView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
                backgroundView.addConstraint(heightConstraint)
                annotationView?.detailCalloutAccessoryView =  backgroundView
            } else {
                annotationView?.pinColor = .green
            }
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView!
    }
}
