//
//  SettingLanguageViewController.swift
//  GC
//
//  Created by sunzhiwei on 2018/4/8.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class SettingLanguageViewController: BaseViewController {

    /// 列表
    @IBOutlet weak var tableView: UITableView!
    
    /// 数据源
    fileprivate var dataArray = ["简体中文", "English"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = LanguageKey.language.value
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK:  UITableViewDataSource&UITableViewDelegate
extension SettingLanguageViewController : UITableViewDataSource, UITableViewDelegate {
    
    // 各个分区的单元(Cell)个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    // 单元(cell)视图
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell?.textLabel?.textColor = COLOR_333333
            cell?.textLabel?.font = ARIAL_FONT_14
        }
        cell?.textLabel?.text = dataArray[indexPath.row]
        return cell!
    }
    
    /// 单元点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 { // 简体中文
            LanguageHelper.shared.setLanguage(type: LanguageType.zhHans)
        } else { // 英语
            LanguageHelper.shared.setLanguage(type: LanguageType.en)
        }
        NotificationCenter.default.post(name: NoticationLanguageUpdate, object: nil)
        self.navigationController?.popViewController(animated: true)
    }
}

