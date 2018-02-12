//
//  BannnerView.swift
//  GC
//
//  Created by hzg on 2018/1/29.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

/// 条幅广告
class BannnerView: UIView {
    
    /// 广告数据
    var banners = Array<AdModel>()
    
    /// 切换广告
    var didPageChangedClosure:((_ page:Int) -> Void)?
    
    /// 滚动视图
    lazy var scrollView:UIScrollView = {
        let _scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        _scrollView.showsVerticalScrollIndicator = false
        _scrollView.showsHorizontalScrollIndicator = false
        _scrollView.bounces = false
        _scrollView.isPagingEnabled = true
        _scrollView.backgroundColor = UIColor.clear
        _scrollView.delegate = self
        self.insertSubview(_scrollView, at: 0)
        _scrollView.contentSize = CGSize(width: CGFloat(self.banners.count) * self.frame.width, height: self.frame.height)
        _scrollView.setContentOffset(CGPoint(x: self.frame.width, y: 0), animated: false)
        for i in 0..<self.banners.count {
            let banner = Bundle.main.loadNibNamed("AdView", owner: nil, options: nil)?[0] as! AdView
            banner.model = self.banners[i]
            banner.frame = CGRect(x: CGFloat(i) * self.frame.width, y: 0, width: self.frame.width, height: self.frame.height)
            _scrollView.addSubview(banner)
        }
        return _scrollView
    }()
    
    // MARK: - public methods
    /// 初始化
    func setup(banners:[AdModel]) {
        if banners.count > 0 {
            self.banners = banners
            scrollView.contentOffset = CGPoint.zero
        }
    }
}

// MARK: - UIScrollViewDelegate
extension BannnerView : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / DEVICE_SCREEN_WIDTH)
        didPageChangedClosure?(page)
    }
}
