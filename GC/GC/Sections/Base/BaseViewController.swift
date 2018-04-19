//
//  BaseViewController.swift
//  GC
//
//  Created by hzg on 2018/2/9.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class BaseViewController: PortraitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let backImage = UIImage(named:"common_back")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .done, target: self, action: #selector(onBackButtonClicked))
    }

    // MARK: - action methods
    func onBackButtonClicked(sender:UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
