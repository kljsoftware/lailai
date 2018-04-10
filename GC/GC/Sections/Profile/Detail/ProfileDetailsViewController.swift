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
    case avatar     // 头像
    case nick       // 昵称
    case tel        // 手机号
    case gender     // 性别
    case region     // 地区
    case email      // 邮箱
    case birthday   // 生日
    case desc       // 个人描述
    static var count = 8
}

class ProfileDetailsViewController: BaseViewController {
    
    /// 用户信息
    var userInfo = ProfileUserInfoModel() {
        didSet {
            perform(#selector(delay), with: nil, afterDelay: 0.1)
        }
    }
    
    fileprivate let viewModel = ProfileDetailViewModel()
    
    /// 列表数据
    fileprivate var dict = [ProfileDetailsCellType:String]()
    
    /// 列表
    @IBOutlet weak var tableView: UITableView!
    
    /// 当前cell类型
    fileprivate var type = ProfileDetailsCellType.nick
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = LanguageKey.profile_setting.value
        let saveButtonItem = UIBarButtonItem(title: LanguageKey.save.value, style: UIBarButtonItemStyle.done, target: self, action: #selector(onSaveButtonClicked))
        navigationItem.rightBarButtonItem = saveButtonItem
        tableView.register(UINib(nibName: "ProfileDetailAvatarCell", bundle: nil), forCellReuseIdentifier: "kProfileDetailAvatarCell")
        tableView.register(UINib(nibName: "ProfileDetailOtherCell", bundle: nil), forCellReuseIdentifier: "kProfileDetailOtherCell")
        tableView.register(UINib(nibName: "ProfileDetailDescCell", bundle: nil), forCellReuseIdentifier: "kProfileDetailDescCell")
        viewModel.setCompletion(onSuccess: {[weak self] (resultModel) in
            guard let wself = self else {
                return
            }
            if resultModel.isKind(of: UploadFileResultModel.self) {
                let model = resultModel as! UploadFileResultModel
                wself.dict[.avatar] = model.data.name
                wself.tableView.reloadData()
            } else {
                UIHelper.tip(message: "保存成功")
                NotificationCenter.default.post(name: NoticationUserInfoUpdate, object: nil)
                wself.navigationController?.popViewController(animated: true)
            }
        }) { (error) in
            UIHelper.tip(message: error)
        }
    }
    
    // MARK: - action methods
    func onSaveButtonClicked(sender:UIButton) {
        let reqModel        = ModityUserInfoRequestModel()
        reqModel.name       = userInfo.name
        reqModel.shortName  = dict[.nick] ?? ""
        reqModel.email      = dict[.email] ?? ""
        reqModel.sex        = (dict[.gender] ?? "男") == "男" ? "1" : "2"
        reqModel.city       = dict[.region] ?? ""
        reqModel.tel        = dict[.tel] ?? ""
        reqModel.logo       = dict[.avatar] ?? ""
        reqModel.birthday   = dict[.birthday] ?? ""
        reqModel.desc       = dict[.desc] ?? ""
        viewModel.modityUserInfo(info: reqModel)
    }
    
    // MARK: - private methods
    @objc private func delay() {
        dict[.avatar]   = userInfo.logo
        dict[.nick]     = userInfo.shortName
        dict[.tel]      = userInfo.tel
        dict[.gender]   = userInfo.sex == 1 ? "男" : "女"
        dict[.region]   = userInfo.city
        dict[.email]    = userInfo.email
        dict[.birthday] = userInfo.birthday
        dict[.desc]     = userInfo.desc
        tableView.reloadData()
    }
    
    /// 获取标签名字
    fileprivate func getLabelName(type:ProfileDetailsCellType) -> String {
        var labelName = ""
        switch type {
        case .avatar:
            labelName = LanguageKey.photo.value
        case .nick:
            labelName = LanguageKey.nick.value
        case .tel:      // 手机号
            labelName = LanguageKey.phoneNum.value
        case .gender:   // 性别
            labelName = LanguageKey.gender.value
        case .region:   // 地区
            labelName = LanguageKey.region.value
        case .email:    // 邮箱
            labelName = LanguageKey.email.value
        case .birthday: // 生日
            labelName = LanguageKey.birthday.value
        case .desc:     // 个人描述
            labelName = LanguageKey.desc.value
        }
        return labelName
    }
    
    /// 获取提示语
    fileprivate func getPlaceholder(type:ProfileDetailsCellType) -> String {
        var placeholder = ""
        switch type {
        case .nick:
            placeholder = "昵称"
        case .email:  // 邮箱
            placeholder = "邮箱"
        case .desc:   // 个人描述
            placeholder = "个人描述"
        default:
            break
        }
        return placeholder
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
        let labelName = getLabelName(type: type)
        let content = dict[type] ?? ""
        if type == .avatar {
            let cell = tableView.dequeueReusableCell(withIdentifier: "kProfileDetailAvatarCell", for: indexPath) as! ProfileDetailAvatarCell
            cell.update(name: labelName, content: NetworkImgOrWeb.getUrl(name: content))
            return cell
            
        } else if type == .desc || type == .tel {
            let cell = tableView.dequeueReusableCell(withIdentifier: "kProfileDetailDescCell", for: indexPath) as! ProfileDetailDescCell
            cell.update(name: labelName, content: content)
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "kProfileDetailOtherCell", for: indexPath) as! ProfileDetailOtherCell
            cell.update(name: labelName, content: content)
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
        if type != .tel {
            switch type {
            case .avatar:
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let picker = UIImagePickerController()
                    picker.delegate = self
                    picker.allowsEditing = true
                    picker.sourceType = .savedPhotosAlbum
                    self.present(picker, animated: true, completion:nil)
                }
            case .gender:
                ActionSheet.show(items: [LanguageKey.man.value, LanguageKey.woman.value], selectedIndex: {[weak self] (index) in
                    guard let wself = self else {
                        return
                    }
                    wself.dict[wself.type] = index == 0 ? LanguageKey.man.value : LanguageKey.woman.value
                    wself.tableView.reloadData()
                })
            case .region:
                let arr         = (dict[type] ?? "").components(separatedBy: "-")
                let city        = arr.count > 1 ? arr[1] : ""
                let district    = arr.count > 2 ? arr[2] : ""
                AreaPickerView.show(province: arr.first, city: city, district: district) { [weak self](province, city, district) in
                    self?.dict[self!.type] = "\(province)-\(city)" + (district != nil ? "-\(district!)" : "")
                    self?.tableView.reloadData()
                }
            case .birthday:
                let curDate = Date.convert(from: dict[type] ?? "", format: "yyyy-MM-dd")
                DatePickerView.show(currentDate: curDate, dateStyle: .YearMonthDay, selectedDateClosure: { [weak self](date) in
                    self?.dict[self!.type] = date.convert(format: "yyyy-MM-dd")
                    self?.tableView.reloadData()
                })
            default:
                AlertController.show(in: self, title: getPlaceholder(type: type), text: dict[type], placeholder: getPlaceholder(type: type), btns: [LanguageKey.cancel.value, LanguageKey.ok.value], handler: { [weak self](action, text) in
                    if action.title != LanguageKey.cancel.value && text != nil {
                        self?.dict[self!.type] = text!
                        self?.tableView.reloadData()
                    }
                })
            }
            self.type = type
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
            if image != nil {
                let data = UIImageJPEGRepresentation(image!, 0.8)
                if data != nil {
                    self?.viewModel.upload(data: data!)
                }
            }
            self?.tableView.reloadData()
        }
    }
}
