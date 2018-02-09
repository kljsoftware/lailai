//
//  SettingAboutViewController.swift
//  GC
//
//  Created by hzg on 2018/2/8.
//  Copyright © 2018年 demo. All rights reserved.
//

class SettingAboutViewController: BaseViewController {

    var viewModel = ProfileViewModel()
    
    @IBOutlet weak var aboutLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = LanguageKey.about.value
        viewModel.getAbout()
        viewModel.setCompletion(onSuccess: {[weak self] (resultModel) in
            guard let wself = self else {
                return
            }
            wself.aboutLabel.text = (resultModel as! AboutResultModel).content
        }) { (error) in
            UIHelper.tip(message: error)
        }
    }

}
