//
//  SettingFAQViewController.swift
//  GC
//
//  Created by hzg on 2018/2/8.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 帮助与反馈
class SettingFAQViewController: BaseViewController {

    let viewModel = ProfileViewModel()
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = LanguageKey.faq.value
        viewModel.setCompletion(onSuccess: { [weak self](resultModel) in
            UIHelper.tip(message: "反馈成功")
            self?.navigationController?.popViewController(animated: true)
        }) { (error) in
            Log.e(error)
            UIHelper.tip(message: error)
        }
    }

    @IBAction func onFeedBackButtonClicked(_ sender: UIButton) {
        if !textView.text.isBlank() {
            viewModel.feedBack(info: textView.text)
        }
    }
}

