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
    
    // 反馈按钮
    @IBOutlet weak var faqBtn: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = LanguageKey.faq.value
        faqBtn.setTitle(LanguageKey.faq.value, for: .normal)
        
        viewModel.setCompletion(onSuccess: { [weak self](resultModel) in
            UIHelper.tip(message: LanguageKey.faq_success.value)
            self?.navigationController?.popViewController(animated: true)
        }) { (error) in
            Log.e(error)
            UIHelper.tip(message: error)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if textView.isFirstResponder {
            textView.resignFirstResponder()
        }
    }
    
    @IBAction func onFeedBackButtonClicked(_ sender: UIButton) {
        if !textView.text.isBlank() {
            viewModel.feedBack(info: textView.text)
        }
    }
}

