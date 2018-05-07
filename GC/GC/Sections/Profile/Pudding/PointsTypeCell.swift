//
//  PointsTypeCell.swift
//  GC
//
//  Created by sunzhiwei on 2018/5/7.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class PointsTypeCell: UITableViewCell {

    /// 类型
    @IBOutlet weak var typeLabel: UILabel!
    /// 日期
    @IBOutlet weak var dateLabel: UILabel!
    /// 积分
    @IBOutlet weak var pointsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// 更新数据
    func update(model: PuddingRecordinfoModel) {
        typeLabel.text = model.puddingAddress
        dateLabel.text = Date.convert(from: model.createdDate, format: "yyyy-MM-dd")
        pointsLabel.text = (model.puddingType == 0 ? "+" : "-") + "\(model.puddingNum)"
    }
}
