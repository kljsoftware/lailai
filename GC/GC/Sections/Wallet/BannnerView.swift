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
    var banners = [String]()
    
    /// 滚动视图
    lazy var scrollView:UIScrollView = {
        let _scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        _scrollView.showsVerticalScrollIndicator = false
        _scrollView.showsHorizontalScrollIndicator = false
        _scrollView.bounces = false
        _scrollView.isPagingEnabled = true
        _scrollView.backgroundColor = UIColor.clear
        self.addSubview(_scrollView)
        _scrollView.contentSize = CGSize(width: CGFloat(self.banners.count) * self.frame.width, height: self.frame.height)
        _scrollView.setContentOffset(CGPoint(x: self.frame.width, y: 0), animated: false)
        for i in 0..<self.banners.count {
            let banner = UIImageView()
            banner.frame = CGRect(x: CGFloat(i) * self.frame.width, y: 0, width: self.frame.width, height: self.frame.height)
            banner.contentMode = .scaleAspectFill
            banner.setImage(urlStr: self.banners[i], placeholderStr: "news_header.png", radius: 0)
            _scrollView.addSubview(banner)
        }
        return _scrollView
    }()
    
    /// 轮播间隔时间、页码控制
    private var timeInterval:TimeInterval = 3
    private lazy var pageControl:UIPageControl = {
        let _pageControl = UIPageControl(frame: CGRect.init(x: DEVICE_SCREEN_WIDTH - 100, y: 80, width: 100, height: 20))
        _pageControl.numberOfPages = self.banners.count
        _pageControl.pageIndicatorTintColor = UIColor.gray
        _pageControl.currentPageIndicatorTintColor = COLOR_2673FD
        self.addSubview(_pageControl)
        return _pageControl
    }()
    
    // MARK: - public methods
    /// 初始化
    func setup(banners:[String]) {
        if banners.count > 0 {
            self.banners = banners
            scrollView.contentOffset = CGPoint.zero
            pageControl.currentPage = 0
            if banners.count > 1 { /// 如果大于1，开始轮播显示图片
                delayPerform()
            }
        }
    }
    
    // MARK: - private methods
    /// 循环执行
    private func delayPerform() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeInterval) { [weak self] in
            guard let wself = self else {
                return
            }
            wself.pageControl.currentPage = (wself.pageControl.currentPage + 1) % wself.banners.count
            wself.scrollView.contentOffset = CGPoint(x: wself.frame.width * CGFloat(wself.pageControl.currentPage), y: 0)
            wself.delayPerform()
        }
    }
}
