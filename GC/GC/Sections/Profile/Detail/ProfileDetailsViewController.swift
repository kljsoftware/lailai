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
    
    /// 用户信息
    var userInfo = ProfileUserInfoModel() {
        didSet {
            tableView.reloadData()
        }
    }
    
    /// 选取头像
    var image:UIImage?
    
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
    
    // MARK: - private methods
    fileprivate func getLabelName(type:ProfileDetailsCellType) -> (labelName:String, content:String) {
        var tuple = ("", "")
        switch type {
        case .avatar:
            tuple.0 = LanguageKey.photo.value
            tuple.1 = NetworkImgOrWeb.getUrl(name: userInfo.logo)
        case .nick:
            tuple.0 = LanguageKey.nick.value
            tuple.1 = userInfo.short_name
        case .tel:    // 手机号
            tuple.0 = LanguageKey.phoneNum.value
            tuple.1 = userInfo.tel
        case .gender: // 性别
            tuple.0 = LanguageKey.gender.value
            tuple.1 = userInfo.sex == 2 ? LanguageKey.woman.value : LanguageKey.man.value
        case .region: // 地区
            tuple.0 = LanguageKey.region.value
            tuple.1 = userInfo.city
        case .email:  // 邮箱
            tuple.0 = LanguageKey.email.value
            tuple.1 = userInfo.email
        case .desc:   // 个人描述
            tuple.0 = LanguageKey.desc.value
            tuple.1 = userInfo.desc
        }
        return tuple
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
        let type = ProfileDetailsCellType(rawValue: indexPath.row)!
        let tuple = getLabelName(type: type)
        switch type {
        case .avatar:
            let cell = tableView.dequeueReusableCell(withIdentifier: "kProfileDetailAvatarCell", for: indexPath) as! ProfileDetailAvatarCell
            cell.update(name: tuple.labelName, content: tuple.content, image: image)
            return cell
        case .desc:
            let cell = tableView.dequeueReusableCell(withIdentifier: "kProfileDetailDescCell", for: indexPath) as! ProfileDetailDescCell
            cell.update(name: tuple.labelName, content: tuple.content)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "kProfileDetailOtherCell", for: indexPath) as! ProfileDetailOtherCell
            cell.update(name: tuple.labelName, content: tuple.content)
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
        let type = ProfileDetailsCellType(rawValue: indexPath.row)!
        switch type {
        case .avatar:
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.allowsEditing = true
                picker.sourceType = .savedPhotosAlbum
                self.present(picker, animated: true, completion:nil)
            }
        case .desc:
            break
        default:
            break
        }
    }
}

/// 图像选取委托事件
extension ProfileDetailsViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: false) { [weak self] in
            var image = info[UIImagePickerControllerEditedImage] as? UIImage
            if nil == image {
                image = info[UIImagePickerControllerOriginalImage] as? UIImage
            }
            self?.image = image
            self?.tableView.reloadData()
        }
    }
}
