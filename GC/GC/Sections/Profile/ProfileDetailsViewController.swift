//
//  ProfileDetailsViewController.swift
//  GC
//
//  Created by hzg on 2018/1/29.
//  Copyright © 2018年 demo. All rights reserved.
//

///  常量定义
private let avatarHeight:CGFloat = 84, otherCellHeight:CGFloat = 50, descCellHeight:CGFloat = 50

/// 单元类型
private enum ProfileDetailsCellType : Int {
    case avatar // 头像
    case nick   // 昵称
    case tel    // 手机号
    case gender // 性别
    case region // 地区
    case email  // 邮箱
    case desc   // 个人描述
    static var count = 7
}

class ProfileDetailsViewController: UIViewController {
    
    /// 列表
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = LanguageKey.profile_setting.value
        let saveButtonItem = UIBarButtonItem(title: LanguageKey.save.value, style: UIBarButtonItemStyle.done, target: self, action: #selector(onSaveButtonClicked))
        navigationItem.rightBarButtonItem = saveButtonItem
        tableView.register(UINib(nibName: "ProfileDetailAvatarCell", bundle: nil), forCellReuseIdentifier: "kProfileDetailAvatarCell")
        tableView.register(UINib(nibName: "ProfileDetailOtherCell", bundle: nil), forCellReuseIdentifier: "kProfileDetailOtherCell")
        tableView.register(UINib(nibName: "ProfileDetailDescCell", bundle: nil), forCellReuseIdentifier: "kProfileDetailDescCell")
    }
    
    // MARK: - action methods
    func onSaveButtonClicked(sender:UIButton) {
        
    }
}

// MARK:  UITableViewDataSource&UITableViewDelegate
extension ProfileDetailsViewController : UITableViewDataSource, UITableViewDelegate {
    
    // 各个分区的单元(Cell)个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileDetailsCellType.count
    }
    
    // 单元(cell)视图
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ProfileDetailsCellType(rawValue: indexPath.row)! {
        case .avatar:
            let cell = tableView.dequeueReusableCell(withIdentifier: "kProfileDetailAvatarCell", for: indexPath) as! ProfileDetailAvatarCell
            return cell
        case .desc:
            let cell = tableView.dequeueReusableCell(withIdentifier: "kProfileDetailDescCell", for: indexPath) as! ProfileDetailDescCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "kProfileDetailOtherCell", for: indexPath) as! ProfileDetailOtherCell
            return cell
        }
    }
    
    // 单元(cell)的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch ProfileDetailsCellType(rawValue: indexPath.row)! {
        case .avatar:
            return avatarHeight
        case .desc:
            return descCellHeight
        default:
            return otherCellHeight
        }
    }
    
    /// 单元点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
