//
//  AlertController.swift
//  GC
//
//  Created by sunzhiwei on 2018/4/10.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class AlertController: UIAlertController {
    
    private var selectedIndex: ((Int) -> Void)?
    private var actionTitles: [String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static func show(in controller: UIViewController,
                     title: String?,
                     message: String? = nil,
                     text: String? = nil,
                     placeholder: String? = nil,
                     btns: [String],
                     handler:((UIAlertAction, String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for btnTitle in btns {
            let action = UIAlertAction(title: btnTitle, style: .default, handler: { (action) in
                handler?(action, alert.textFields?.first?.text)
            })
            alert.addAction(action)
        }
        if placeholder != nil {
            alert.addTextField { (textField) in
                textField.placeholder = placeholder
                textField.text = text
            }
        }
        controller.present(alert, animated: true, completion: nil)
    }
}
