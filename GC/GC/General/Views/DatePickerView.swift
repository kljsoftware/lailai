//
//  DatePickerView.swift
//  GC
//
//  Created by sunzhiwei on 2018/4/9.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

private let MAXYEAR = 2099
private let MINYEAR = 1000

/// 弹出日期类型
enum DateStyle : Int {
    case YearMonthDayHourMinute // 年月日时分
    case MonthDayHourMinute     // 月日时分
    case YearMonthDay           // 年月日
    case YearMonth              // 年月
    case MonthDay               // 月日
    case HourMinute             // 时分
}

/// 时间/日期选择器
class DatePickerView: UIView {
    
    /// 日期相关数组
    fileprivate var yearArr     = [String]()
    fileprivate var monthArr    = [String]()
    fileprivate var dayArr      = [String]()
    fileprivate var hourArr     = [String]()
    fileprivate var minuteArr   = [String]()
    fileprivate var yearIndex   = 0
    fileprivate var monthIndex  = 0
    fileprivate var dayIndex    = 0
    fileprivate var hourIndex   = 0
    fileprivate var minuteIndex = 0
    fileprivate var dateFormatter = "yyyy-MM-dd HH:mm"
    
    /// 内容视图
    fileprivate var contentView: UIView!
    /// pickerView
    private var pickerView: UIPickerView!
    /// 按钮区域视图
    private var buttonAreaView: UIView!
    
    /// 日期类型
    fileprivate var dateStyle = DateStyle.YearMonthDayHourMinute
    /// 当前日期
    fileprivate var currentDate: Date!
    /// 最大日期
    fileprivate var maxDate: Date!
    /// 最小日期
    fileprivate var minDate: Date!
    /// 申明日期闭包
    fileprivate var selectedDateClosure: ((Date) -> Void)?
    
    
    // MARK: - class methods
    class func show(currentDate: Date? = nil, dateStyle: DateStyle, selectedDateClosure: ((Date) -> Void)?) {
        let window      = UIApplication.shared.keyWindow!
        let datePicker  = DatePickerView(currentDate: currentDate, dateStyle: dateStyle, selectedDateClosure: selectedDateClosure)
        window.addSubview(datePicker)
    }
    
    // MARK : - private methods
    private init(currentDate: Date? = nil, dateStyle: DateStyle, selectedDateClosure: ((Date) -> Void)?) {
        
        super.init(frame: CGRect(x: 0, y: 0, width: DEVICE_SCREEN_WIDTH, height: DEVICE_SCREEN_HEIGHT))
        self.currentDate = currentDate ?? Date()
        self.dateFormatter = ["yyyy-MM-dd HH:mm", "MM-dd HH:mm", "yyyy-MM-dd", "yyyy-MM", "MM-dd", "HH:mm"][dateStyle.rawValue]
        self.selectedDateClosure = selectedDateClosure
        
        initUI()
        showPicker()
        configData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        Log.e("deinit#")
    }
    
    /// 配置数据
    private func configData() {
        
        for i in MINYEAR ... MAXYEAR {
            yearArr.append("\(i)")
        }
        for i in 0 ..< 60 {
            if i > 0 && i <= 12 {
                monthArr.append("\(i)")
            }
            if i < 24 {
                hourArr.append("\(i)")
            }
            minuteArr.append("\(i)")
        }
        maxDate = Date.convert(from: "2099-12-31 23:59", format: "yyyy-MM-dd HH:mm")
        minDate = Date.convert(from: "1000-01-01 00:00", format: "yyyy-MM-dd HH:mm")
        scrollTo(date: currentDate, animated: true)
    }
    
    /// 滚动到指定日期
    fileprivate func scrollTo(date: Date, animated: Bool) {
        
        setDayData(from: Calendar.current.component(.day, from: date), month: Calendar.current.component(.month, from: date))
        
        yearIndex = Calendar.current.component(.day, from: date) - MINYEAR
        monthIndex = Calendar.current.component(.month, from: date) - 1
        dayIndex = Calendar.current.component(.day, from: date) - 1
        hourIndex = Calendar.current.component(.hour, from: date)
        minuteIndex = Calendar.current.component(.minute, from: date)
        
        var indexArr = [Int]()
        
        if dateStyle == .YearMonthDayHourMinute {
            indexArr = [yearIndex, monthIndex, dayIndex, hourIndex, minuteIndex]
        }
        if dateStyle == .YearMonthDay {
            indexArr = [yearIndex, monthIndex, dayIndex]
        }
        if dateStyle == .YearMonth {
            indexArr = [yearIndex, monthIndex]
        }
        if dateStyle == .MonthDayHourMinute {
            indexArr = [monthIndex, dayIndex, hourIndex, minuteIndex]
        }
        if dateStyle == .MonthDay {
            indexArr = [monthIndex, dayIndex]
        }
        if dateStyle == .HourMinute {
            indexArr = [hourIndex, minuteIndex]
        }
        pickerView.reloadAllComponents()
        
        for i in 0 ..< indexArr.count {
            pickerView.selectRow(indexArr[i], inComponent: i, animated: animated)
        }
    }
    
    /// 初始化
    private func initUI() {
        
        self.backgroundColor = UIColor.clear
        
        // 透明背景点击手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DatePickerView.hidePicker))
        tapGesture.delegate = self
        self.addGestureRecognizer(tapGesture)
        
        contentView = UIView(frame: CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 220 + DEVICE_INDICATOR_HEIGHT))
        contentView.backgroundColor = UIColor.white
        self.addSubview(contentView)
        
        initPickerView()
        
        initButton()
    }
    
    /// 初始化Picker
    private func initPickerView() {
        
        pickerView              = UIPickerView(frame: CGRect(x: 0, y: 40, width: self.frame.width, height: 180))
        pickerView.backgroundColor = UIColor.white
        pickerView.dataSource   = self
        pickerView.delegate     = self
        contentView.addSubview(pickerView)
    }
    
    /// 初始化按钮区域
    private func initButton() {
        
        // 按钮区域
        buttonAreaView = UIView(frame: CGRect(x: pickerView.frame.origin.x, y: 0, width: pickerView.frame.size.width, height: 40))
        buttonAreaView.backgroundColor = UIColor.white
        contentView.addSubview(buttonAreaView)
        
        for i in 0 ..< 2 {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: CGFloat(i)*(buttonAreaView.frame.size.width - 80), y: 0, width: 80, height: 40)
            button.setTitle(i == 0 ? LanguageKey.cancel.value : LanguageKey.ok.value, for: .normal)
            button.setTitleColor(UIColor(red: 60/255.0, green: 60/255.0, blue: 80/255.0, alpha: 1), for: .normal)
            button.tag = i+1
            button.addTarget(self, action: #selector(DatePickerView.buttonClicked(_:)), for: .touchUpInside)
            buttonAreaView.addSubview(button)
            
            // 按钮边线
            let lineView = UIView(frame: CGRect(x: 0, y: CGFloat(i)*40, width: contentView.frame.size.width, height: 1/UIScreen.main.scale))
            lineView.backgroundColor = COLOR_C0C0C0
            buttonAreaView.addSubview(lineView)
        }
    }
    
    // MARK: - private methods
    /// 显示选择器 并指定到当前选定的项
    private func showPicker(elements: [String]? = nil) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.frame.origin.y = DEVICE_SCREEN_HEIGHT - 220 - DEVICE_INDICATOR_HEIGHT
            self.backgroundColor            = UIColor(white: 0.0, alpha: 0.4)
        })
    }
    
    /// 隐藏pickerView点击手势
    @objc private func hidePicker() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.frame.origin.y = DEVICE_SCREEN_HEIGHT
            self.backgroundColor            = UIColor.clear
            
        }, completion: { (finished) in
            self.removeFromSuperview()
        })
    }
    
    /// 取消/确定按钮点击事件
    @objc private func buttonClicked(_ sender : UIButton) {
        
        hidePicker()
        if sender.tag == 2 && selectedDateClosure != nil {
            selectedDateClosure!(currentDate)
        }
    }
    
    /// 通过年求每月天数
    fileprivate func setDayData(from year: Int, month: Int) {
        
        let isRunNian = year%4 == 0 ? (year%100 == 0 ? (year%400 == 0) : true) : false
        var days = 0
        if month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12 {
            days = 31
        } else if month == 4 || month == 6 || month == 9 || month == 11 {
            days = 30
        } else {
            days = isRunNian ? 29 : 28
        }
        dayArr.removeAll()
        for i in 1 ... days {
            dayArr.append("\(i)")
        }
    }
}

// MARK: - UIPickerViewDataSource & UIPickerViewDelegate
extension DatePickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    /// 返回的列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch dateStyle {
        case .YearMonthDayHourMinute:
//            [self addLabelWithName:@[@"年",@"月",@"日",@"时",@"分"]];
            return 5
        case .MonthDayHourMinute:
//            [self addLabelWithName:@[@"月",@"日",@"时",@"分"]];
            return 4
        case .YearMonthDay:
//            [self addLabelWithName:@[@"年",@"月",@"日"]];
            return 3
        default:
            return 2
        }
    }
    
    /// 每列返回的个数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        let yearNum     = yearArr.count
        let monthNum    = monthArr.count
        setDayData(from: Int(yearArr[yearIndex])!, month: Int(monthArr[monthIndex])!)
        let dayNum      = dayArr.count
        let hourNum     = hourArr.count
        let minuteNum   = minuteArr.count

        switch dateStyle {
        case .YearMonthDayHourMinute:
            return [yearNum, monthNum, dayNum, hourNum, minuteNum][component]
            
        case .MonthDayHourMinute:
            return [monthNum, dayNum, hourNum, minuteNum][component]
            
        case .YearMonthDay:
            return [yearNum, monthNum, dayNum][component]
            
        case .YearMonth:
            return [yearNum, monthNum][component]
            
        case .MonthDay:
            return [monthNum, dayNum][component]
            
        case .HourMinute:
            return [hourNum, minuteNum][component]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        // 设置分割线颜色
        pickerView.subviews[1].backgroundColor = COLOR_DEDEE3
        pickerView.subviews[2].backgroundColor = COLOR_DEDEE3
        
        var pickerLabel: UILabel?
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.adjustsFontSizeToFitWidth = true
            pickerLabel?.textAlignment = .center
            pickerLabel?.textColor = COLOR_232642
        }
        var title = ""
        switch dateStyle {
        case .YearMonthDayHourMinute:
            if component == 0 {
                title = yearArr[row]
            }
            if component == 1 {
                title = monthArr[row]
            }
            if component == 2 {
                title = dayArr[row]
            }
            if component == 3 {
                title = hourArr[row]
            }
            if component == 4 {
                title = minuteArr[row]
            }
        case .MonthDayHourMinute:
            if component == 0 {
                title = monthArr[row]
            }
            if component == 1 {
                title = dayArr[row]
            }
            if component == 2 {
                title = hourArr[row]
            }
            if component == 3 {
                title = minuteArr[row]
            }
        case .YearMonthDay:
            if component == 0 {
                title = yearArr[row]
            }
            if component == 1 {
                title = monthArr[row]
            }
            if component == 2 {
                title = dayArr[row]
            }
        case .YearMonth:
            if component == 0 {
                title = yearArr[row]
            }
            if component == 1 {
                title = monthArr[row]
            }
        case .MonthDay:
            if component == 0 {
                title = monthArr[row]
            }
            if component == 1 {
                title = dayArr[row]
            }
        case .HourMinute:
            if component == 0 {
                title = hourArr[row]
            }
            if component == 1 {
                title = minuteArr[row]
            }
        }
        pickerLabel?.text = title
        return pickerLabel!
    }
    
    /// 选中行
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch dateStyle {
        case .YearMonthDayHourMinute:
            if component == 0 {
                yearIndex = row
            }
            if component == 1 {
                monthIndex = row
            }
            if component == 2 {
                dayIndex = row
            }
            if component == 3 {
                hourIndex = row
            }
            if component == 4 {
                minuteIndex = row
            }
            if component == 0 || component == 1 {
                setDayData(from: Int(yearArr[yearIndex])!, month: Int(monthArr[monthIndex])!)
                if dayArr.count - 1 < dayIndex {
                    dayIndex = dayArr.count - 1
                }
            }
        case .MonthDayHourMinute:
            if component == 1 {
                dayIndex = row
            }
            if component == 2 {
                hourIndex = row
            }
            if component == 3 {
                minuteIndex = row
            }
            if component == 0 {
                setDayData(from: Int(yearArr[yearIndex])!, month: Int(monthArr[monthIndex])!)
                if dayArr.count - 1 < dayIndex {
                    dayIndex = dayArr.count - 1
                }
            }
            setDayData(from: Int(yearArr[yearIndex])!, month: Int(monthArr[monthIndex])!)
        case .YearMonthDay:
            if component == 0 {
                yearIndex = row
            }
            if component == 1 {
                monthIndex = row
            }
            if component == 2 {
                dayIndex = row
            }
            if component == 0 || component == 1 {
                setDayData(from: Int(yearArr[yearIndex])!, month: Int(monthArr[monthIndex])!)
                if dayArr.count - 1 < dayIndex {
                    dayIndex = dayArr.count - 1
                }
            }
        case .YearMonth:
            if component == 0 {
                yearIndex = row;
            }
            if component == 1 {
                monthIndex = row
            }
        case .MonthDay:
            if component == 1 {
                dayIndex = row
            }
            if component == 0 {
                setDayData(from: Int(yearArr[yearIndex])!, month: Int(monthArr[monthIndex])!)
                if dayArr.count - 1 < dayIndex {
                    dayIndex = dayArr.count - 1
                }
            }
            setDayData(from: Int(yearArr[yearIndex])!, month: Int(monthArr[monthIndex])!)
        case .HourMinute:
            if component == 0 {
                hourIndex = row
            }
            if component == 1 {
                minuteIndex = row
            }
        }
        pickerView.reloadAllComponents()
        
        let dateStr = yearArr[yearIndex] + monthArr[monthIndex] + dayArr[dayIndex] + hourArr[hourIndex] + minuteArr[minuteIndex]
        if currentDate < minDate {
            currentDate = minDate
            scrollTo(date: currentDate, animated: true)
        } else if currentDate > maxDate {
            currentDate = maxDate
        } else {
            currentDate = Date.convert(from: dateStr, format: dateFormatter)
        }
        scrollTo(date: currentDate, animated: true)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension DatePickerView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        // 子视图上禁止父视图的手势
        if touch.view!.isDescendant(of: contentView) {
            return false
        }
        return true
    }
}
