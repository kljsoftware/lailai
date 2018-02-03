//
//  DonateRecordViewController.swift
//  GC
//
//  Created by hzg on 2018/2/3.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 常量定义
private let cellHeight:CGFloat = 80

class DonateRecordViewController: UIViewController {

    /// 列表
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = LanguageKey.donate_record.value
        automaticallyAdjustsScrollViewInsets = false
        tableView.register(UINib(nibName: "DonateRecordCell", bundle: nil), forCellReuseIdentifier: "kDonateRecordCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK:  UITableViewDataSource&UITableViewDelegate
extension DonateRecordViewController : UITableViewDataSource, UITableViewDelegate {
    
    // 各个分区的单元(Cell)个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // 单元(cell)视图
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kDonateRecordCell", for: indexPath) as! DonateRecordCell
        return cell
    }
    
    // 单元(cell)的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}
