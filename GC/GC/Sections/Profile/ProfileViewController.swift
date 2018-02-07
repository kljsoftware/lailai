//
//  ProfileViewController.swift
//  GC
//
//  Created by hzg on 2018/1/27.
//  Copyright © 2018年 demo. All rights reserved.
//


///  常量定义
private let profileHeight:CGFloat = 116, settingCellHeight:CGFloat = 50, quitCellHeight:CGFloat = 100

/// 单元类型
private enum ProfileCellType : Int {
    case profile
    case setting
    case business_link
    case quit
    
    static var count = 4
}

/// 个人详情设置界面
class ProfileViewController: UIViewController {

    /// 业务模块
    let viewModel = ProfileViewModel()
    
    /// 列表视图
    @IBOutlet weak var tableView: UITableView!
   
    // MARK: - override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViewModel()
    }
    
    // MARK: - private methods
    private func setup() {
        navigationItem.title = LanguageKey.tab_profile.value
        automaticallyAdjustsScrollViewInsets = false
        tableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "kProfileCell")
        tableView.register(UINib(nibName: "ProfielSettingCell", bundle: nil), forCellReuseIdentifier: "kProfielSettingCell")
        tableView.register(UINib(nibName: "ProfileQuitCell", bundle: nil), forCellReuseIdentifier: "kProfileQuitCell")
    }
    
    private func setupViewModel() {
        viewModel.getUserInfo()
        viewModel.setCompletion(onSuccess: { [weak self](resultModel) in
            self?.tableView.reloadData()
        }) { (error) in
            
        }
    }
}

// MARK:  UITableViewDataSource&UITableViewDelegate
extension ProfileViewController : UITableViewDataSource, UITableViewDelegate {
    
    // 各个分区的单元(Cell)个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileCellType.count
    }
    
    // 单元(cell)视图
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ProfileCellType(rawValue: indexPath.row)! {
        case .profile:
            let cell = tableView.dequeueReusableCell(withIdentifier: "kProfileCell", for: indexPath) as! ProfileCell
            cell.update(model: viewModel.userInfo)
            return cell
        case .setting:
            let cell = tableView.dequeueReusableCell(withIdentifier: "kProfielSettingCell", for: indexPath) as! ProfielSettingCell
            cell.update(name: LanguageKey.setting.value)
            return cell
        case .business_link:
            let cell = tableView.dequeueReusableCell(withIdentifier: "kProfielSettingCell", for: indexPath) as! ProfielSettingCell
            cell.update(name: LanguageKey.business_link.value)
            return cell
        case .quit:
            let cell = tableView.dequeueReusableCell(withIdentifier: "kProfileQuitCell", for: indexPath) as! ProfileQuitCell
            return cell
        }
    }
    
    // 单元(cell)的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch ProfileCellType(rawValue: indexPath.row)! {
        case .profile:
            return profileHeight
        case .setting:
            return settingCellHeight
        case .business_link:
            return settingCellHeight
        case .quit:
            return quitCellHeight
        }
    }
    
    /// 单元点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch ProfileCellType(rawValue: indexPath.row)! {
        case .profile:
            let vc = UIStoryboard.init(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileDetails")
            navigationController?.pushViewController(vc, animated: true)
        case .setting:
            let vc = UIStoryboard.init(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileSetting")
            navigationController?.pushViewController(vc, animated: true)
        case .business_link:
            let vc = UIStoryboard.init(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileBusiness")
            navigationController?.pushViewController(vc, animated: true)
        case .quit:
            NotificationCenter.default.post(name: NoticationUserLogout, object: nil)
        }
    }
}
