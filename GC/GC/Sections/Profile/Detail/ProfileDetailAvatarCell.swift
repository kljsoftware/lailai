//
//  ProfileDetailAvatarCell.swift
//  GC
//
//  Created by hzg on 2018/2/3.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

class ProfileDetailAvatarCell: UITableViewCell {

    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    // MARK: - public methods
    func update(name:String, content:String, image:UIImage?)  {
        photoLabel.text = name
        if image != nil {
            avatarImageView.image = image
        } else {
            avatarImageView.setImage(urlStr: content, placeholderStr: "avatar", radius: 30)
        }
    }
}
