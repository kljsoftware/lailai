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
    case accept_busniss
    case secret_key_address
    case quit
    
    static var count = 5
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
        registerNotification()
    }
    
    deinit {
        unregisterNotification()
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
        MBProgressHUD.showAdded(to: self.view, animated: true)
        viewModel.getUserInfo()
        viewModel.setCompletion(onSuccess: { [weak self](resultModel) in
            guard let wself = self else {
                return
            }
            wself.tableView.reloadData()
            MBProgressHUD.hide(for: wself.view, animated: true)
        }) { [weak self] (error) in
            guard let wself = self else {
                return
            }
            MBProgressHUD.hide(for: wself.view, animated: true)
        }
    }
    
    /// 注册通知
    fileprivate func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(notifyUserInfoUpdate(_:)), name: NoticationUserInfoUpdate, object: nil)
    }
    
    /// 销毁通知
    fileprivate func unregisterNotification() {
        NotificationCenter.default.removeObserver(self, name: NoticationUserInfoUpdate, object: nil)
    }
    
    /// 通知用户注册
    @objc private func notifyUserInfoUpdate(_ notify:Notification) {
        viewModel.getUserInfo()
    }
    
    // MARK: - private methods
    fileprivate func getLabelName(type:ProfileCellType) -> String {
        var labelName = ""
        switch type {
        case .setting:
            labelName = LanguageKey.setting.value
        case .accept_busniss:
            labelName = LanguageKey.accept_busniss.value
        case .secret_key_address:    // 手机号
            labelName = LanguageKey.secret_key_address.value
        default:
            break
        }
        return labelName
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
        let type = ProfileCellType(rawValue: indexPath.row)!
        switch type {
        case .profile:
            let cell = tableView.dequeueReusableCell(withIdentifier: "kProfileCell", for: indexPath) as! ProfileCell
            cell.update(model: viewModel.userInfo)
            return cell
        case .quit:
            let cell = tableView.dequeueReusableCell(withIdentifier: "kProfileQuitCell", for: indexPath) as! ProfileQuitCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "kProfielSettingCell", for: indexPath) as! ProfielSettingCell
            cell.update(name: getLabelName(type: type))
            return cell
        }
    }
    
    // 单元(cell)的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch ProfileCellType(rawValue: indexPath.row)! {
        case .profile:
            return profileHeight
        case .quit:
            return quitCellHeight
        default:
            return settingCellHeight
        }
    }
    
    /// 单元点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch ProfileCellType(rawValue: indexPath.row)! {
        case .profile:
            let vc = UIStoryboard.init(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileDetails") as! ProfileDetailsViewController
            vc.userInfo = viewModel.userInfo
            navigationController?.pushViewController(vc, animated: true)
        case .setting:
            let vc = UIStoryboard.init(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileSetting")
            navigationController?.pushViewController(vc, animated: true)
        case .accept_busniss:
            let vc = UIStoryboard.init(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileBusiness")
            navigationController?.pushViewController(vc, animated: true)
        case .secret_key_address:
            break
        case .quit:
            NotificationCenter.default.post(name: NoticationUserLogout, object: nil)
        }
    }
}
