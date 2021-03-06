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
        MBProgressHUD.showAdded(to: self.view, animated: true)
        viewModel.getAbout()
        viewModel.setCompletion(onSuccess: { [weak self](resultModel) in
            guard let wself = self else {
                return
            }
            MBProgressHUD.hide(for: self!.view, animated: true)
            wself.aboutLabel.text = (resultModel as! AboutResultModel).content
            
        }) { (error) in
            UIHelper.tip(message: error)
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }

}
