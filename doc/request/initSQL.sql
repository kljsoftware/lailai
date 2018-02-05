/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  steven_2
 * Created: 2018-1-17
 */

-- ----------------------------
-- Table structure for `operator`
-- ----------------------------
DROP TABLE IF EXISTS `operator`;
CREATE TABLE `operator` (
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '注册名',
  `password` varchar(20) DEFAULT NULL COMMENT '密码',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作员表';

-- ----------------------------
-- Records of operator
-- ----------------------------
INSERT INTO `operator` VALUES ('aaa', '123456');


-- ----------------------------
-- Table structure for `member`
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `tel` varchar(20) NOT NULL DEFAULT '' COMMENT '主键，唯一',
  `name` varchar(50) DEFAULT NULL COMMENT '姓名',
  `short_name` varchar(50) DEFAULT NULL COMMENT '昵称',
  `email` varchar(100) DEFAULT NULL COMMENT '邮件',
  `sex` tinyint(4) DEFAULT NULL COMMENT '性别 1:男 2:女',
  `birthday` char(8) DEFAULT NULL COMMENT '生日',
  `city` varchar(50) DEFAULT NULL COMMENT '城市',
  `level` int(11) DEFAULT NULL COMMENT '级别',
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `logo` varchar(100) DEFAULT NULL COMMENT '头像显示路径',
  `description` text COMMENT '简介',
  PRIMARY KEY (`tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES ('13683391111', '张三', '三', 'zhangsan@gmail。com', '1', '19970101', 'beijing', '0', '2018-01-18 11:19:53', null, '这里输入简介内容');

DROP TABLE IF EXISTS `dealer`;
CREATE TABLE `dealer` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) DEFAULT NULL COMMENT '商家名称',
  `description` text COMMENT '描述',
  `logo` varchar(256) DEFAULT '' COMMENT '图标路径',
  `color` varchar(30) DEFAULT NULL COMMENT '商家颜色', 
  `coordinate` varchar(100) DEFAULT NULL COMMENT '坐标',
  `address` varchar(100) DEFAULT NULL COMMENT '地址',
  `level` int(11) DEFAULT NULL COMMENT '绿色认证级别',
  `link` tinyint(4) DEFAULT NULL COMMENT '是否联通',
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建日期',
  `del` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除?0正常;1删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='积分商家表';


-- ----------------------------
-- Table structure for `member_dea_rel`
-- ----------------------------
DROP TABLE IF EXISTS `member_dea_rel`;
CREATE TABLE `member_dea_rel` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tel` varchar(20) NOT NULL COMMENT '手机号',
  `dealer_id` int(11) NOT NULL COMMENT '积分商家id',
  `member_dea_name` varchar(50) DEFAULT NULL COMMENT '积分商家用户名',
  `balance` decimal(13,2) DEFAULT NULL COMMENT '积分余额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='会员商家关联表';



-- ----------------------------
-- Table structure for `memcp`
-- ----------------------------
DROP TABLE IF EXISTS `memcp`;
CREATE TABLE `memcp` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dealer_id` int(11) NOT NULL COMMENT '积分商家id',
  `dealer_name` varchar(50) DEFAULT NULL COMMENT '商家名称',
  `tel` varchar(20) NOT NULL COMMENT '手机号',
  `member_dea_name` varchar(50) DEFAULT NULL COMMENT '积分商家用户名',
  `donate_num` decimal(13,2) NOT NULL COMMENT '积分导入(捐赠)额',
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='积分记录表';





-- ----------------------------
-- Table structure for `usertoken`
-- ----------------------------
DROP TABLE IF EXISTS `usertoken`;
CREATE TABLE `usertoken` (
  `tel` varchar(20) NOT NULL COMMENT '手机号',
  `password` varchar(50) NOT NULL COMMENT '密码',
  `token` varchar(100) NOT null COMMENT '用户token', 
  `last_vist_time` timestamp NULL COMMENT '上次访问时间',
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';




-- ----------------------------
-- Table structure for `help_feedback`
-- ----------------------------
DROP TABLE IF EXISTS `help_feedback`;
CREATE TABLE `help_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `member_tel` varchar(20) NOT NULL COMMENT '手机号',
  `member_name` varchar(50) DEFAULT NULL COMMENT '用户名',
  `member_feedback` text COMMENT '用户反馈',
  `admin_help` text COMMENT '平台帮助',
  `feedback_date` timestamp NULL COMMENT '反馈日期',
  `help_date` timestamp NULL COMMENT '帮助日期',
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='帮助反馈表';





-- ----------------------------
-- Table structure for `points_advertisement`
-- ----------------------------
DROP TABLE IF EXISTS `points_advertisement`;
CREATE TABLE `points_advertisement` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ad_name` varchar(20) NOT NULL COMMENT '广告名称',
  `ad_url` varchar(50) DEFAULT NULL COMMENT '广告图片地址',
  `ad_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '广告类型?0闪屏页;1积分页',
  `ad_remark` text COMMENT '备注',
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='积分广告表';





-- ----------------------------
-- Table structure for `points_rank`
-- ----------------------------
DROP TABLE IF EXISTS `points_rank`;
CREATE TABLE `points_rank` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `start_scope` int(11) NOT NULL COMMENT '开始积分范围',
  `end_scope` int(11) NOT NULL COMMENT '结束积分范围',
  `rank_name` text COMMENT '会员等级',
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='会员等级表';


INSERT INTO `points`.`points_rank` (`id`, `start_scope`, `end_scope`, `rank_name`, `created_date`) VALUES ('1', '0', '0', '普通会员', '2018-02-04 17:29:28');
INSERT INTO `points`.`points_rank` (`id`, `start_scope`, `end_scope`, `rank_name`, `created_date`) VALUES ('2', '100', '300', '中级会员', '2018-02-04 17:29:28');
INSERT INTO `points`.`points_rank` (`id`, `start_scope`, `end_scope`, `rank_name`, `created_date`) VALUES ('3', '300', '800', '高级会员', '2018-02-04 17:29:28');
INSERT INTO `points`.`points_rank` (`id`, `start_scope`, `end_scope`, `rank_name`, `created_date`) VALUES ('4', '800', '1500', '白金会员', '2018-02-04 17:29:28');
INSERT INTO `points`.`points_rank` (`id`, `start_scope`, `end_scope`, `rank_name`, `created_date`) VALUES ('5', '1500', '2500', '黄金会员', '2018-02-04 17:29:28');

-- ----------------------------
-- Table structure for `green_news`
-- ----------------------------
DROP TABLE IF EXISTS `green_news`;
CREATE TABLE `green_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `news` text COMMENT '新闻',
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='绿色新闻表';

