//
//  HomeTabBarController.swift
//  GC
//
//  Created by hzg on 2018/1/27.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVC(tabName: LanguageKey.tab_wallet.value, storyName: "Wallet", imageName: "wallet")
        addChildVC(tabName: LanguageKey.tab_business.value, storyName: "Business", imageName: "business")
        addChildVC(tabName: LanguageKey.tab_news.value, storyName: "News", imageName: "news")
        addChildVC(tabName: LanguageKey.tab_profile.value, storyName: "Profile", imageName: "profile")
    }

    // 禁止转屏
    override var shouldAutorotate : Bool {
        return false
    }
    
    // 只显示竖屏
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    /// 添加子控制器
    private func addChildVC(tabName:String, storyName:String, imageName:String) {
        let vc = UIStoryboard(name: storyName, bundle: nil).instantiateViewController(withIdentifier: storyName)
        vc.tabBarItem.image = UIImage(named:"tab_\(imageName)_nor")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named:"tab_\(imageName)_sel")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.title = tabName
        vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4)
        addChildViewController(vc)
    }
}
