//
//  ProfileBusinessViewController.swift
//  GC
//
//  Created by hzg on 2018/2/4.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 常量定义
private let cellHeight:CGFloat = 50
private let businesses = ["滴滴", "摩拜", "京东", "星巴克"]

class ProfileBusinessViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = LanguageKey.business_link.value
        automaticallyAdjustsScrollViewInsets = false
        tableView.register(UINib(nibName: "ProfileBusinessCell", bundle: nil), forCellReuseIdentifier: "kProfileBusinessCell")
    }
}

// MARK:  UITableViewDataSource&UITableViewDelegate
extension ProfileBusinessViewController : UITableViewDataSource, UITableViewDelegate {
    
    // 各个分区的单元(Cell)个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    // 单元(cell)视图
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kProfileBusinessCell", for: indexPath) as! ProfileBusinessCell
        cell.update(name: businesses[indexPath.row], isAuthorized: indexPath.row == 0)
        return cell
    }
    
    // 单元(cell)的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    // 单元(cell)选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "business_auth") as! BusinessAuthViewController
        vc.businessname = businesses[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
