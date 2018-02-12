//
//  PageControl.swift
//  GC
//
//  Created by hzg on 2018/2/12.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit


private let dot_sel_width:CGFloat = 12, dot_nor_wh:CGFloat = 6, blank:CGFloat = 6

/// 页码控制器
class PageControl: UIView {
   
    fileprivate lazy var containerView:UIView = {
        let w:CGFloat = CGFloat(self.total - 1)*dot_nor_wh + dot_sel_width + CGFloat(self.total - 1)*blank
        let _container = UIView(frame: CGRect(x: (DEVICE_SCREEN_WIDTH - w)/2, y: 0, width: w, height: dot_nor_wh))
        self.addSubview(_container)
        return _container
    }()
    
    private var total = 0, current = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       // fatalError("init(coder:) has not been implemented")
    }
    
    /// 点视图
    private var dotViews = [UIImageView](), selDotView = UIImageView()
    
    /// 初始化
    func setup(total:Int, current:Int) {
        self.total = total
        self.current = current
        if self.total <= 1 {
            return
        }
        
        /// 初始化页码
        for _ in 0...total-1 {
            let dotView = UIImageView(image: UIImage(named:"dot")!)
            dotView.frame = CGRect(x: 0, y: 0, width: dot_nor_wh, height: dot_nor_wh)
            containerView.addSubview(dotView)
            dotViews.append(dotView)
        }
        selDotView = UIImageView(image: UIImage(named:"dot_sel")!)
        selDotView.frame = CGRect(x: 0, y: 0, width: dot_sel_width, height: dot_nor_wh)
        containerView.addSubview(selDotView)
        
        // 布局页码点视图
        layoutDotViews()
    }
    
    func setCurrentPage(current:Int) {
        if current == self.current {
            return
        }
        self.current = current
        layoutDotViews()
    }
    
    /// 布局页码点视图
    private func layoutDotViews() {
        
        var x:CGFloat = 0, nor_i = 0
        
        /// 排序
        for i in 0...total - 1 {
            if i == current {
                selDotView.frame = CGRect(x: x, y: 0, width: dot_sel_width, height: dot_nor_wh)
                x += dot_sel_width
            } else {
                dotViews[i].frame = CGRect(x: x, y: 0, width: dot_nor_wh, height: dot_nor_wh)
                x += dot_nor_wh
                nor_i += 1
            }
            x += blank
        }
    }
}
