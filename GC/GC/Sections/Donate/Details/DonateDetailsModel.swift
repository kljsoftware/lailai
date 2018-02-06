//
//  DonateDetailsModel.swift
//  GC
//
//  Created by hzg on 2018/2/6.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 6.2 获取公益捐赠详情
class DonateDetailsRequestModel : BaseRequestModel {
    var id = 0
}

class DonateDetailsResultModel : BaseResultModel {
    var donationDetails = DonationDetailModel()
}

class DonationDetailModel : NSObject {
    var orgName = "" //组织名称
    var cover   = "" // 捐赠封面
    var title   = "" // 标题
    var content = "" // 项目详情
    var blockchain_id =  0  // 区块链id
    var create_date = "" // 开始时间
    var target =  40000 // 目标金额 单位元
    var completed =  2000 // 已捐赠金额 单位元
    var nums = 2000 // 捐赠人数
    var video_cover = "" // 视频封面
    var video_url = "" // 视频地址
    var audio_url = "" // 音频地址
}
