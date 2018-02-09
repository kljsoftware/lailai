//
//  TextInputView.swift
//  GC
//
//  Created by hzg on 2018/2/3.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

// 文字评语操作区
class TextInputView: UIView {
    
    // 提示文字
    var placeholder : String = "请输入文字评语"
    
    /// 键盘显示
    var keyboardType = UIKeyboardType.default
    
    /// 文字输入确定返回闭包
    var inputConfirmClosure:((String) -> Void)?
    
    /// 最大文字输入个数，0表示默认不限制
    var maxCount = 0
    
    // 动画时间
    let animationDuration = 0.25
    
    // 文字输入最大高度
    var writingTextViewMaxHeight:CGFloat = 128
    
    // 文字输入最少高度
    let writingTextViewMinHeight:CGFloat = 16
    
    // 文字输入上下方向外边距共32dp
    let writingTextViewOutSideMargin:CGFloat = 32
    
    // 黑子遮罩视图
    @IBOutlet weak var blackCoverView: UIView!
    
    // 文字输入视图
    @IBOutlet weak var writingTextView: UITextView!
    
    // 默认提示文字
    @IBOutlet weak var placeholderLabel: UILabel!
    
    // 文字区域视图高度约束
    @IBOutlet weak var writingAreaViewHeightLayoutConstraint: NSLayoutConstraint!
    
    // 输入框距左右的距离
    @IBOutlet weak var writingTVLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var writingTVRightConstraint: NSLayoutConstraint!
    
    // 软键盘高度
    var keyboardHeight : CGFloat = 0.0

    // 输入值
    private var oldInputValue = ""
    
    // MARK: - super methods
    // 初始化操作
    override func awakeFromNib() {
        
        // 初始化界面
        initUI()
        
        // 注册通知
        registerNotification()
    }
    
    deinit {
        unregisterNotification()
    }
    
    // MARK: - private methods
    // 初始化界面
    fileprivate func initUI() {
        
        // 文字输入
        writingTextView.textColor   = UIColor.black
        
        // 默认隐藏
        self.isHidden = true
        
        // 点击手势
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(performTapGesture(_:)))
        blackCoverView.addGestureRecognizer(tapGes)
    }
    
    // 计算文字区域视图的高度
    fileprivate func calcTextViewHeight() -> CGFloat {
        let size    = writingTextView.sizeThatFits(CGSize(width: frame.width - 20, height: CGFloat.greatestFiniteMagnitude))
        // 向上取整 ps: 若h=32.X，则取3
        let height  = ceil(size.height)
        return height
    }
    
    // 注册通知
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(receiveKeyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(receiveKeyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(receiveKeyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // 销毁通知
    func unregisterNotification() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // MARK: - notification methods
    // 软件盘显示
    func receiveKeyboardWillShowNotification(_ notify:Notification) {
        let userInfo = notify.userInfo
        if userInfo == nil {
            return
        }
        
        // 获取软件盘的高度
        let value   = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let rect    = value.cgRectValue
        keyboardHeight = rect.height
        
        // 设置视图位置
        UIView.animate(withDuration: animationDuration, animations: {
            self.frame.origin.y = -self.keyboardHeight
        })
    }
    
    // 软件盘消失
    func receiveKeyboardWillHideNotification(_ notify:Notification) {
        UIView.animate(withDuration: animationDuration, animations: {
            self.frame.origin.y = 0
        })
    }
    
    // MARK: - Gesture methods
    // tap手势处理
    func performTapGesture(_ ges:UITapGestureRecognizer) {
        hide()
    }
    
    // MARK: - UITextViewDelegate
    // 文字发生改变处理
    func textViewDidChange(_ textView: UITextView) {
        
        if (textView.text as  NSString).length != 0 {
            placeholderLabel.isHidden = true
        } else {
            placeholderLabel.isHidden = false
        }
        var h = calcTextViewHeight()
        if h < writingTextViewMinHeight {
            h = writingTextViewMinHeight
        }
        
        if h > writingTextViewMaxHeight {
            h = writingTextViewMaxHeight
        }
        writingAreaViewHeightLayoutConstraint.constant = h + writingTextViewMinHeight
    }
    
    // 点击确认返回处理
    func textView(_ textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            hide()
            return false
        }
        
        /// 限制最大文字输入数
        if maxCount > 0 {
            var count = textView.text!.count
            if text != "" {
                count = count + 1
            }
            return  count <= maxCount
        }
        
        return true
    }
    
    // MARK: - public methods
    // 显示
    func show(_ str:String? = nil) {
        placeholderLabel.text = placeholder
        if str != nil && str != "" {
            placeholderLabel.isHidden = true
        } else {
            // 文字清空处理
            writingTextView.text = ""
            placeholderLabel.isHidden = false
        }
        
        // 记录初始输入
        oldInputValue = writingTextView.text
        
        // 键盘类型
        writingTextView.keyboardType = keyboardType
        
        // 显示
        self.isHidden = false
        
        // 更新高度
        textViewDidChange(writingTextView)
        
        // 获取焦点
        writingTextView.becomeFirstResponder()
    }
    
    // 隐藏
    func hide() {
        
        // 取消焦点
        writingTextView.resignFirstResponder()
        
        // 隐藏
        self.isHidden = true
        
        // 若全是空白，则显示""
        let text = writingTextView.text.isBlank() ? "" : writingTextView.text
        inputConfirmClosure?(text!)
    }
}
