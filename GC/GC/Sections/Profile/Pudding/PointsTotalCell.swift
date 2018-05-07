//
//  PointsTotalCell.swift
//  GC
//
//  Created by sunzhiwei on 2018/5/7.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class PointsTotalCell: UITableViewCell {

    /// 总积分
    @IBOutlet weak var totalLabel: UILabel!
    /// 布丁说明书
    @IBOutlet weak var instructionsBtn: UIButton!
    /// 布丁说明书闭包
    var instructionsClosure: (() -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        instructionsBtn.setTitle(LanguageKey.pud_instructions.value, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// 布丁说明书点击事件
    @IBAction func instructionsClicked(_ sender: UIButton) {
        if instructionsClosure != nil {
            instructionsClosure!()
        }
    }
    
    /// 更新数据
    func update(model: PuddingResultModel) {
        totalLabel.text = "\(model.puddingSum)"
    }
}
