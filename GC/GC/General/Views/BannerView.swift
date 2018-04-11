//
//  BannerView.swift
//  GC
//
//  Created by sunzhiwei on 2018/4/11.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

protocol BannerViewDelegate : NSObjectProtocol {
    func bannerView(bannerView: BannerView, didSelected index: Int)
}

private let pageSpace: CGFloat = 6

class BannerView: UIView {

    weak var delegate: BannerViewDelegate?
    
    private var imageName: String = ""
    private var imageURLs = [String]()
    fileprivate var count = 0
    private var timerInterval = 0
    private var currentIndicatorImage = ""
    private var pageIndicatorImage = ""
    private var placeholderImage = ""
    
    private var timer: Timer?
    fileprivate var scrollView: UIScrollView!
    fileprivate var pageControl: UIView?
    fileprivate var currentPage = 0
    
    
    // MARK: - 类方法
    /// 本地图片
    class func banner(frame: CGRect, delegate: BannerViewDelegate, imageName: String, count: Int, timerInterval: Int, currentIndicatorImage: String, pageIndicatorImage: String) -> BannerView {
        return BannerView(frame: frame, delegate: delegate, imageName: imageName, count: count, timerInterval: timerInterval, currentIndicatorImage: currentIndicatorImage, pageIndicatorImage: pageIndicatorImage)
    }
    
    /// 网络图片
    class func banner(frame: CGRect, delegate: BannerViewDelegate, imageURLs: [String], placeholderImage: String, timerInterval: Int, currentIndicatorImage: String, pageIndicatorImage: String) -> BannerView {
        return BannerView(frame: frame, delegate: delegate, imageURLs: imageURLs, placeholderImage: placeholderImage, timerInterval: timerInterval, currentIndicatorImage: currentIndicatorImage, pageIndicatorImage: pageIndicatorImage)
    }
    
    // MARK: - 实例方法
    /// 本地图片
    init(frame: CGRect, delegate: BannerViewDelegate, imageName: String, count: Int, timerInterval: Int, currentIndicatorImage: String, pageIndicatorImage: String) {
        
        super.init(frame: frame)
        
        self.delegate = delegate
        self.imageName = imageName
        self.count = count
        self.timerInterval = timerInterval
        self.currentIndicatorImage = currentIndicatorImage
        self.pageIndicatorImage = pageIndicatorImage
        
        setupMainView()
    }
    
    /// 网络图片
    init(frame: CGRect, delegate: BannerViewDelegate, imageURLs: [String], placeholderImage: String, timerInterval: Int, currentIndicatorImage: String, pageIndicatorImage: String) {
        super.init(frame: frame)

        self.delegate = delegate
        self.imageURLs = imageURLs
        self.count = imageURLs.count
        self.timerInterval = timerInterval
        self.placeholderImage = placeholderImage
        self.currentIndicatorImage = currentIndicatorImage
        self.pageIndicatorImage = pageIndicatorImage
        
        setupMainView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMainView() {
    
        let scrollW = self.frame.width
        let scrollH = self.frame.height
        
        // set up scrollView
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: scrollW, height: scrollH))
        scrollView.backgroundColor = UIColor.white
        scrollView.delegate = self
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentOffset = CGPoint(x: count <= 1 ? 0 : scrollW, y: 0)
        scrollView.contentSize = CGSize(width: CGFloat(count <= 1 ? count : count+2)*scrollW, height: 0)
        self.addSubview(scrollView)
        
        if count == 0 {
            let imageView = UIImageView(image: UIImage(named: placeholderImage))
            imageView.frame = CGRect(x: 0, y: 0, width: scrollW, height: scrollH)
            imageView.clipsToBounds = true
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFill
            scrollView.addSubview(imageView)
        } else {
            for i in 0 ..< (count <= 1 ? count : count+2) {
                var tag = 0
                var currentImageName = ""
                if i == 0 {
                    tag = count
                    currentImageName = String(format: "\(imageName)_%02d", count)
                
                } else if i == count + 1 {
                    tag = 1
                    currentImageName = "\(imageName)_01"
                
                } else {
                    tag = i
                    currentImageName = String(format: "\(imageName)_%02d", i)

                }
                let imageView = UIImageView(frame: CGRect(x: scrollW*CGFloat(i), y: 0, width: scrollW, height: scrollH))
                imageView.tag = tag
                imageView.clipsToBounds = true
                imageView.isUserInteractionEnabled = true
                imageView.contentMode = .scaleAspectFill
                scrollView.addSubview(imageView)
                
                if imageName.count > 0 {    // from local
                    let image = UIImage(named: currentImageName)
                    imageView.image = image
                    
                } else {    // from internet
                    imageView.sd_setImage(with: URL(string: imageURLs[tag-1]), placeholderImage: UIImage(named: placeholderImage), options: SDWebImageOptions.retryFailed, completed: nil)
                }
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(imageViewTaped(tap:)))
                imageView.addGestureRecognizer(tap)
            }
        }
        
        if count > 1 {
            addTimer()
            
            // set up pageControl
            let pageImg = UIImage(named: pageIndicatorImage)!
            let curPageImg = UIImage(named: currentIndicatorImage)!
            let width = curPageImg.size.width + CGFloat(count-1)*(pageImg.size.width+pageSpace)
            pageControl = UIView(frame: CGRect(x: (self.frame.width-width)/2, y: scrollH-10-pageSpace, width: width, height: 10))
            pageControl?.isUserInteractionEnabled = false
            var x: CGFloat = 0
            for i in 0 ..< count {
                let imageView = UIImageView(image: i == 0 ? curPageImg : pageImg)
                imageView.frame = CGRect(x: x, y: 0, width: imageView.image!.size.width, height: imageView.image!.size.height)
                imageView.tag = i + 1
                pageControl?.addSubview(imageView)
                x += imageView.image!.size.width + pageSpace
            }
            self.addSubview(pageControl!)
        }
    }
    
    @objc private func imageViewTaped(tap: UITapGestureRecognizer) {
        delegate?.bannerView(bannerView: self, didSelected: tap.view!.tag - 1)
    }
    
    /// MARK: - Timer
    fileprivate func addTimer() {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(timerInterval), target: self, selector: #selector(nextImage), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .commonModes)
    }
    
    fileprivate func removeTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    @objc private func nextImage() {
        scrollView.setContentOffset(CGPoint(x: CGFloat(currentPage+2)*scrollView.frame.width, y:0), animated: true)
    }
    
    fileprivate func setPage() {
        if pageControl != nil {
            
            let pageImg = UIImage(named: pageIndicatorImage)!
            let curPageImg = UIImage(named: currentIndicatorImage)!
            
            var x: CGFloat = 0
            for tmpView in pageControl!.subviews {
                if tmpView is UIImageView {
                    let imageView = tmpView as! UIImageView
                    if currentPage == count {
                        imageView.image = currentPage == imageView.tag ? curPageImg : pageImg
                    } else {
                        imageView.image = currentPage == imageView.tag - 1 ? curPageImg : pageImg
                    }
                    imageView.frame = CGRect(x: x, y: 0, width: imageView.image!.size.width, height: imageView.image!.size.height)
                    x += imageView.image!.size.width + pageSpace
                }
            }
        }
    }
}

// MARK: - UIScrollViewDelegate
extension BannerView : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let scrollW = scrollView.frame.width
        let curPage = Int(scrollView.contentOffset.x / scrollW)
        
        if curPage == count + 1 {
            currentPage = 0
            
        } else if curPage == 0 {
            currentPage = count
            
        } else {
            currentPage = curPage - 1
        }
        setPage()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let scrollW = scrollView.frame.width
        let curPage = Int(scrollView.contentOffset.x / scrollW)
        
        if curPage == count + 1 {
            currentPage = 0
            setPage()
            scrollView.setContentOffset(CGPoint(x: scrollW, y: 0), animated: false)
            
        } else if curPage == 0 {
            currentPage = count
            setPage()
            scrollView.setContentOffset(CGPoint(x: CGFloat(count)*scrollW, y: 0), animated: false)
            
        } else {
            currentPage = curPage - 1
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
}
