//
//  MapAroundView.swift
//  GC
//
//  Created by hzg on 2018/2/8.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class MapAroundView: UIView {
    
    var aroundButtonClosure:(()->Void)?

    @IBOutlet weak var aroundLabel: UILabel!

    @IBAction func onAroundButtonClicked(_ sender: UIButton) {
        aroundButtonClosure?()
    }
}
