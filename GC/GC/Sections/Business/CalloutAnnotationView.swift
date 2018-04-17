//
//  AnnotationView.swift
//  GC
//
//  Created by sunzhiwei on 2018/4/17.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit
import MapKit

/// 边距
public let CalloutBorderSpace: CGFloat = 5

/// 自定义气泡视图
class CalloutAnnotationView: MKAnnotationView {
    
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var publicKeyLabel: UILabel!
    
    /// 初始化
    override func awakeFromNib() {
        
    }
    
    /// 赋值数据模型显示相应的数据
    override var annotation: MKAnnotation? {
        didSet {
            if let calloutAnnotation = annotation as? CalloutAnnotation {
                logoImgView.setImage(urlStr: calloutAnnotation.logo, placeholderStr: "", radius: 22)
                nameLabel.text      = calloutAnnotation.name
                telLabel.text       = calloutAnnotation.tel
                addressLabel.text   = calloutAnnotation.address
                publicKeyLabel.text = calloutAnnotation.publicKey
            }
        }
    }
}

/// 气泡模型
class CalloutAnnotation: NSObject, MKAnnotation {
    
    // 位置
    var coordinate: CLLocationCoordinate2D
    // logo
    var logo: String = ""
    // 名称
    var name: String = ""
    // 电话
    var tel: String = ""
    // 地址
    var address: String = ""
    // 公钥
    var publicKey: String = ""
    
    init(coordinate: CLLocationCoordinate2D, logo: String, name: String, tel: String, address: String, publicKey: String) {
        self.coordinate = coordinate
        self.logo       = logo
        self.name       = name
        self.tel        = tel
        self.address    = address
        self.publicKey  = publicKey
        super.init()
    }
}

///// 自定义大头针
//class CalloutAnnotation: NSObject, MKAnnotation {
//
//    /// 位置
//    var coordinate: CLLocationCoordinate2D
//    /// 主标题
//    var title: String?
//    /// 副标题
//    var subtitle: String?
//
//    init(coordinate: CLLocationCoordinate2D, title: String) {
//        self.coordinate = coordinate
////        self.title = title
//        super.init()
//    }
//
//    /// 在模型中创建大头针视图
//    class func createViewAnnotation(for mapView: MKMapView, annotation: MKAnnotation) -> MKAnnotationView {
//        let identifier = "DetailCalloutAnnotation"
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
//        if annotationView == nil {
//            // 创建一个大头针视图
//            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            annotationView!.canShowCallout = true
//            // 设置大头针颜色
//            if #available(iOS 9.0, *) {
//                annotationView?.pinTintColor = UIColor.green
//                // 添加约束才可以使用自定义视图
//                let backgroundView = UIView(frame: CGRect.zero)
//                backgroundView.backgroundColor = UIColor.red
//                let widthConstraint = NSLayoutConstraint(item: backgroundView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
//                backgroundView.addConstraint(widthConstraint)
//                let heightConstraint = NSLayoutConstraint(item: backgroundView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
//                backgroundView.addConstraint(heightConstraint)
//                annotationView?.detailCalloutAccessoryView = backgroundView
//            } else {
//                annotationView?.pinColor = .green
//            }
//            let logoImgView = UIView(frame: CGRect(x: 0, y: 40, width: 40, height: 40))
//            logoImgView.backgroundColor = UIColor.green
//            annotationView?.leftCalloutAccessoryView = logoImgView
//        } else {
//            annotationView?.annotation = annotation
//        }
//        return annotationView!
//    }
//}
