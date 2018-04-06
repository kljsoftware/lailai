//
//  AreaPickerView.swift
//  GC
//
//  Created by Sunny on 2018/4/6.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

/// 地区选择
class AreaPickerView: UIView {

    // 数据源
    fileprivate var dataArr = [ProvinceModel]()
    // 当前省
    fileprivate var curProvinceModel: ProvinceModel!
    // 当前市
    fileprivate var curCityModel: CityModel!
    // 当前区
    fileprivate var district: String?

    // 内容视图
    private var contentView: UIView!
    // pickerView
    private var pickerView: UIPickerView!
    // 按钮区域视图
    fileprivate var buttonAreaView: UIView!
    
    // 申明选中行闭包
    fileprivate var selectedClosure: ((String, String, String?) -> Void)?
    
    
    // MARK: - class methods
    class func show(province: String? = nil, city: String? = nil, district: String? = nil, selectedClosure: ((String, String, String?) -> Void)?) {
        let window      = UIApplication.shared.keyWindow!
        let areaPicker  = AreaPickerView(province: province, city: city, district: district!, selectedClosure: selectedClosure)
        window.addSubview(areaPicker)
    }
    
    // MARK : - private methods
    private init(province: String? = nil, city: String? = nil, district: String? = nil, selectedClosure: ((String, String, String?) -> Void)?) {
        
        super.init(frame: CGRect(x: 0, y: 0, width: DEVICE_SCREEN_WIDTH, height: DEVICE_SCREEN_HEIGHT))
        self.selectedClosure = selectedClosure
        
        initUI()
        showPicker()
        
        getAreaData(province: province, city: city, district: district)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        Log.e("deinit#")
    }
    
    /// 初始化
    private func initUI() {
        
        self.backgroundColor = UIColor.clear
        
        // 透明背景点击手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AreaPickerView.hidePicker))
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
            button.setTitle(i == 0 ? "取消" : "确定", for: .normal)
            button.setTitleColor(UIColor(red: 60/255.0, green: 60/255.0, blue: 80/255.0, alpha: 1), for: .normal)
            button.tag = i+1
            button.addTarget(self, action: #selector(AreaPickerView.buttonClicked(_:)), for: .touchUpInside)
            buttonAreaView.addSubview(button)
            
            // 按钮边线
            let lineView = UIView(frame: CGRect(x: 0, y: CGFloat(i)*40, width: contentView.frame.size.width, height: 1/UIScreen.main.scale))
            lineView.backgroundColor = COLOR_C0C0C0
            buttonAreaView.addSubview(lineView)
        }
    }
    
    /// 获取地区本地数据
    private func getAreaData(province: String? = nil, city: String? = nil, district: String? = nil) {
        
        let arr = NSArray(contentsOfFile: Bundle.main.path(forResource: "Area", ofType: "plist")!)!
        for str in arr {
            let provinceModel = ProvinceModel.mj_object(withKeyValues: str)!
            dataArr.append(provinceModel)
        }
        curProvinceModel = dataArr.first!
        curCityModel = curProvinceModel.citys.first!
        self.district = district
        
        for i in 0 ..< dataArr.count {
            let provinceModel = dataArr[i]
            if provinceModel.province == province {
                curProvinceModel = provinceModel
                pickerView.selectRow(i, inComponent: 0, animated: true)
                break
            }
        }
        for i in 0 ..< curProvinceModel.citys.count {
            let cityModel = curProvinceModel.citys[i]
            if cityModel.city == city {
                curCityModel = cityModel
                pickerView.selectRow(i, inComponent: 1, animated: true)
                break
            }
        }
        for i in 0 ..< curCityModel.districts.count {
            if curCityModel.districts[i] == district {
                pickerView.selectRow(i, inComponent: 2, animated: true)
                break
            }
        }
        pickerView.reloadAllComponents()
    }
    
    // MARK: - private methods
    /// 显示选择器 并指定到当前选定的项
    private func showPicker(elements: [String]? = nil) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.frame.origin.y = DEVICE_SCREEN_HEIGHT - 220 - DEVICE_INDICATOR_HEIGHT
            self.backgroundColor            = UIColor(white: 0.0, alpha: 0.4)
        })
    }
    
    // 隐藏pickerView点击手势
    @objc private func hidePicker() {
        
        // 隐藏动画
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.frame.origin.y = DEVICE_SCREEN_HEIGHT
            self.backgroundColor            = UIColor.clear
            
        }, completion: { (finished) in
            self.removeFromSuperview()
        })
    }
    
    // 刷新数据
    private func reloadData() {
        pickerView.reloadAllComponents()
    }
    
    // 取消/确定按钮点击事件
    @objc private func buttonClicked(_ sender : UIButton) {
        
        hidePicker()
        if sender.tag == 2 && selectedClosure != nil {
            selectedClosure!(curProvinceModel.province, curCityModel.city, district)
        }
    }
}

// MARK: - UIPickerViewDataSource & UIPickerViewDelegate
extension AreaPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    /// 返回的列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    /// 每列返回的个数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return dataArr.count
        } else if component == 1 {
            return curProvinceModel.citys.count
        } else {
            return curCityModel.districts.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        // 设置分割线颜色
        pickerView.subviews[1].backgroundColor = COLOR_DEDEE3
        pickerView.subviews[2].backgroundColor = COLOR_DEDEE3
        
        var pickerLabel: UILabel?
        if pickerLabel == nil {
            pickerLabel = UILabel(frame: CGRect(x: DEVICE_SCREEN_WIDTH/3*CGFloat(component), y: 0, width: DEVICE_SCREEN_WIDTH/3, height: 0))
            pickerLabel?.adjustsFontSizeToFitWidth = true
            pickerLabel?.textAlignment = .center
            pickerLabel?.textColor = COLOR_232642
        }
        if component == 0 {
            pickerLabel?.text = dataArr[row].province
        } else if component == 1 {
            pickerLabel?.text = curProvinceModel.citys[row].city
        } else {
            pickerLabel?.text = curCityModel.districts[row]
        }
        return pickerLabel!
    }
    
    // 选中行
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            curProvinceModel = dataArr[row]
            curCityModel = curProvinceModel.citys.first!
            district = curCityModel.districts.first
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            
            
        } else if component == 1 {
            curCityModel = curProvinceModel.citys[row]
            district = curCityModel.districts.first
            pickerView.selectRow(0, inComponent: 2, animated: true)
        } else {
            district = curCityModel.districts[row]
        }
        pickerView.reloadAllComponents()
    }
}

// MARK: - UIGestureRecognizerDelegate
extension AreaPickerView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // 子视图上禁止父视图的手势
        if touch.view!.isDescendant(of: buttonAreaView) {
            return false
        }
        return true
    }
}
