//
//  ProfileViewController.swift
//  GC
//
//  Created by hzg on 2018/1/27.
//  Copyright © 2018年 demo. All rights reserved.
//


///  常量定义
private let profileHeight: CGFloat = 104, settingCellHeight: CGFloat = 50, quitCellHeight: CGFloat = 100

/// 单元类型
private enum ProfileCellType: Int {
    case profile
    case setting
    case accept_busniss
    case secret_key_address
    case my_green_pudding
    case quit
    static var count = 6
}

/// 个人详情设置界面
class ProfileViewController: PortraitViewController {

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
        tableView.register(UINib(nibName: "ProfileButtonCell", bundle: nil), forCellReuseIdentifier: "kProfileButtonCell")
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
        case .setting:              // 设置
            labelName = LanguageKey.setting.value
        case .accept_busniss:       // 授权商家
            labelName = LanguageKey.accept_busniss.value
        case .secret_key_address:   // 我的密钥地址
            labelName = LanguageKey.secret_key_address.value
        case .my_green_pudding:     // 我的绿色布丁
            labelName = LanguageKey.my_green_pudding.value
        default:
            break
        }
        return labelName
    }
}

// MARK: UITableViewDataSource & UITableViewDelegate
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
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
            let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileDetails") as! ProfileDetailsViewController
            vc.userInfo = viewModel.userInfo
            navigationController?.pushViewController(vc, animated: true)
        case .setting:
            let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileSetting")
            navigationController?.pushViewController(vc, animated: true)
        case .accept_busniss:
            let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileBusiness")
            navigationController?.pushViewController(vc, animated: true)
        case .secret_key_address:
            let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "secretkey_address")
            navigationController?.pushViewController(vc, animated: true)
        case .my_green_pudding:
            let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "my_green_pudding")
            navigationController?.pushViewController(vc, animated: true)
        case .quit:
            AlertController.show(in: self, title: LanguageKey.logout_message.value, btns: [LanguageKey.cancel.value, LanguageKey.ok.value], handler: { (action, text) in
                if action.title != LanguageKey.cancel.value {
                    NotificationCenter.default.post(name: NoticationUserLogout, object: nil)
                }
            })
        }
    }
}
