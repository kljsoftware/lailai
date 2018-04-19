//
//  AnnotationView.swift
//  GC
//
//  Created by sunzhiwei on 2018/4/17.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit
import MapKit

/// 自定义气泡视图
class BubbleContentView: UIView {
    
    /// 提示文字
    @IBOutlet weak var telTLabel: UILabel!
    @IBOutlet weak var addressTLabel: UILabel!
    @IBOutlet weak var publicKeyTLabel: UILabel!
    
    /// 内容信息
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var publicKeyLabel: UILabel!
    
    /// 初始化
    override func awakeFromNib() {
        super.awakeFromNib()
        telTLabel.text          = LanguageKey.telephone.value + "："
        addressTLabel.text      = LanguageKey.address.value + "："
        publicKeyTLabel.text    = LanguageKey.public_key.value + "："
    }
    
    /// 更新数据
    func updateData(annotation: CalloutAnnotation) {
        logoImgView.setImage(urlStr: NetworkImgOrWeb.getUrl(name: annotation.logo), placeholderStr: "", radius: 22)
        nameLabel.text      = annotation.dealerName
        telLabel.text       = annotation.dealerTel
        addressLabel.text   = annotation.address
        if annotation.isBranch {
            publicKeyTLabel.isHidden = true
            publicKeyLabel.isHidden = true
        } else {
            publicKeyTLabel.isHidden = false
            publicKeyLabel.isHidden = false
            publicKeyLabel.text = annotation.publicKey
        }
    }
}

/// 自定义大头针
class CalloutAnnotation: NSObject, MKAnnotation {

    /// 位置
    var coordinate: CLLocationCoordinate2D
    /// 主标题
    var title: String?
    /// 副标题
    var subtitle: String?
    /// logo
    var logo: String = ""
    /// 名称
    var dealerName: String = ""
    /// 电话
    var dealerTel: String = ""
    /// 地址
    var address: String = ""
    /// 公钥
    var publicKey: String = ""
    /// 是否为商家分支
    var isBranch = false
    

    init(coordinate: CLLocationCoordinate2D, logo: String, dealerName: String, dealerTel: String, address: String, publicKey: String, isBranch: Bool) {
        self.coordinate = coordinate
        self.logo       = logo
        self.dealerName = dealerName
        self.dealerTel  = dealerTel
        self.address    = address
        self.publicKey  = publicKey
        self.isBranch   = isBranch
        super.init()
    }

    /// 在模型中创建大头针视图
    class func createViewAnnotation(for mapView: MKMapView, annotation: CalloutAnnotation) -> MKAnnotationView? {
        let identifier = "CalloutAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if annotationView == nil {
            // 创建大头针视图
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        if #available(iOS 9.0, *) {
            annotationView?.pinTintColor = annotation.isBranch ? UIColor.purple : UIColor.green
            // 添加约束才可以使用自定义视图
            let contentView = Bundle.main.loadNibNamed("BubbleContentView", owner: nil, options: nil)![0] as? BubbleContentView
            contentView?.updateData(annotation: annotation)
            annotationView?.detailCalloutAccessoryView = contentView
            contentView?.snp.makeConstraints({ (maker) in
                maker.width.equalTo(240)
                maker.height.equalTo(annotation.isBranch ? 110 : 150)
            })
        } else {
            annotationView?.pinColor = annotation.isBranch ? .purple : .green
        }
        return annotationView
    }
}

