//
//  BaseNavigationController.swift
//  GC
//
//  Created by hzg on 2018/2/3.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 栈顶控制器，控制是否转屏
    override var shouldAutorotate : Bool {
        return self.viewControllers.last!.shouldAutorotate
    }
    
    // 栈顶控制器，控制转屏方式
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return self.viewControllers.last!.supportedInterfaceOrientations
    }
}
