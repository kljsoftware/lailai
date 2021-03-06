//
//  ProfileSettingViewController.swift
//  GC
//
//  Created by hzg on 2018/2/4.
//  Copyright © 2018年 demo. All rights reserved.
//

///  常量定义
private let cellHeight:CGFloat = 50, quitCellHeight:CGFloat = 100

/// 单元类型
private enum ProfileSettingType : Int {
    case pwd
    case language
    case faq
    case version
    case about
    case quit
    
    static var count = 6
}

class ProfileSettingViewController: BaseViewController {

    /// 列表视图
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = LanguageKey.setting.value
        automaticallyAdjustsScrollViewInsets = false
        tableView.register(UINib(nibName: "ProfielSettingCell", bundle: nil), forCellReuseIdentifier: "kProfielSettingCell")
        tableView.register(UINib(nibName: "ProfileButtonCell", bundle: nil), forCellReuseIdentifier: "kProfileButtonCell")
        tableView.register(UINib(nibName: "ProfileDetailDescCell", bundle: nil), forCellReuseIdentifier: "kProfileDetailDescCell")
    }

    // MARK: - private methods
    fileprivate func getLabelName(type:ProfileSettingType) -> String {
        var labelName = ""
        switch type {
        case .pwd:      // 密码
            labelName = LanguageKey.pwd_reset.value
        case .language: // 语言
            labelName = LanguageKey.language.value
        case .faq:      // 手机号
            labelName = LanguageKey.faq.value
        case .version:  // 版本号
            labelName = LanguageKey.version.value
        case .about:    // 关于绿积分
            labelName = LanguageKey.about.value
        case .quit:     // 退出
            labelName = LanguageKey.logout.value
        }
        return labelName
    }
}

// MARK:  UITableViewDataSource&UITableViewDelegate
extension ProfileSettingViewController : UITableViewDataSource, UITableViewDelegate {
    
    // 各个分区的单元(Cell)个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileSettingType.count
    }
    
    // 单元(cell)视图
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = ProfileSettingType(rawValue: indexPath.row)!
        switch type {
        case .version:
            let cell = tableView.dequeueReusableCell(withIdentifier: "kProfileDetailDescCell", for: indexPath) as! ProfileDetailDescCell
            // 当前版本号
            let version = "V " + (Bundle.main.infoDictionary![VERSION_STRING] as! String)
            cell.update(name: getLabelName(type: type), content: version)
            return cell
        case .quit:
            let cell = tableView.dequeueReusableCell(withIdentifier: "kProfileButtonCell", for: indexPath) as! ProfileButtonCell
            cell.titleLabel.text = LanguageKey.logout.value
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "kProfielSettingCell", for: indexPath) as! ProfielSettingCell
            cell.update(name: getLabelName(type: type))
            return cell
        }
    }
    
    // 单元(cell)的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch ProfileSettingType(rawValue: indexPath.row)! {
        case .quit:
            return quitCellHeight
        default:
            return cellHeight
        }
    }
    
    /// 单元点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch ProfileSettingType(rawValue: indexPath.row)! {
        case .pwd:
            let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "profile_setting_pwd")
            navigationController?.pushViewController(vc, animated: true)
        case .language:
            let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "setting_language")
            navigationController?.pushViewController(vc, animated: true)
        case .faq:
            let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "profile_setting_faq")
            navigationController?.pushViewController(vc, animated: true)
        case .about:
            let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "profile_setting_about")
            navigationController?.pushViewController(vc, animated: true)
        case .quit:
            NotificationCenter.default.post(name: NoticationUserLogout, object: nil)
        default:
            break
        }
    }
}
