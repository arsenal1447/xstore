/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50624
Source Host           : localhost:3306
Source Database       : xiaoego

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2016-04-20 16:04:24
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_address`
-- ----------------------------
DROP TABLE IF EXISTS `t_address`;
CREATE TABLE `t_address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `consignee` varchar(60) NOT NULL COMMENT '收货人',
  `cellphone` varchar(20) NOT NULL DEFAULT '' COMMENT '手机',
  `gender` enum('male','woman') NOT NULL DEFAULT 'male',
  `school_id` int(10) unsigned NOT NULL COMMENT '学校id',
  `building_id` int(10) unsigned NOT NULL COMMENT '建筑id',
  `room` varchar(60) NOT NULL COMMENT '门牌号',
  `user_id` int(10) unsigned NOT NULL COMMENT '用户id',
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否默认',
  `created_at` int(10) unsigned NOT NULL,
  `updated_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `school_id` (`school_id`),
  KEY `building_id` (`building_id`),
  KEY `user_id` (`user_id`),
  KEY `created_at` (`created_at`,`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='收货地址';

-- ----------------------------
-- Records of t_address
-- ----------------------------
INSERT INTO `t_address` VALUES ('1', '周星驰', '18212345678', 'male', '1', '1', '楼下', '1', '0', '1461139412', '1461139412');

-- ----------------------------
-- Table structure for `t_admin`
-- ----------------------------
DROP TABLE IF EXISTS `t_admin`;
CREATE TABLE `t_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `real_name` varchar(20) NOT NULL COMMENT '真实姓名',
  `auth_key` varchar(32) NOT NULL,
  `password_hash` varchar(255) NOT NULL COMMENT '密码',
  `access_token` varchar(255) DEFAULT NULL,
  `gender` enum('male','woman','other') NOT NULL DEFAULT 'male' COMMENT '性别',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机',
  `status` enum('active','blocked') NOT NULL DEFAULT 'active' COMMENT '状态',
  `created_at` int(10) unsigned NOT NULL COMMENT '创建时间',
  `updated_at` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='管理员';

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `t_admin` VALUES ('1', 'admin', '管理员', 'djzEmNQp6b82ZjedCfQZyF2NZNRKcfgz', '$2y$13$t8ei8oClEZiZwxdEvcaNKu.DeOJcX1xsYekv1rHcWoocVCfUhkZm2', null, 'male', 'admin@xiaoego.com', '18851510363', 'active', '1433420037', '1433652786');

-- ----------------------------
-- Table structure for `t_apply`
-- ----------------------------
DROP TABLE IF EXISTS `t_apply`;
CREATE TABLE `t_apply` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `apply_sn` char(12) NOT NULL COMMENT '申请单号',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺id',
  `fee` decimal(8,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '总价',
  `status` enum('pending','rejected','passed','cancelled','completed') NOT NULL COMMENT '状态',
  `remark` varchar(255) DEFAULT NULL,
  `created_at` int(10) unsigned NOT NULL,
  `updated_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `apply_sn_UNIQUE` (`apply_sn`),
  KEY `store_id` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购申请表';

-- ----------------------------
-- Records of t_apply
-- ----------------------------

-- ----------------------------
-- Table structure for `t_apply_goods`
-- ----------------------------
DROP TABLE IF EXISTS `t_apply_goods`;
CREATE TABLE `t_apply_goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `apply_id` int(10) unsigned NOT NULL COMMENT '采购申请id',
  `goods_id` int(10) unsigned NOT NULL COMMENT '商品id',
  `name` varchar(60) NOT NULL COMMENT '商品名称',
  `category` varchar(60) NOT NULL COMMENT '商品分类',
  `count` int(10) unsigned NOT NULL COMMENT '数量',
  `price` decimal(8,2) unsigned NOT NULL COMMENT '单价',
  `cover` varchar(20) NOT NULL COMMENT '封面',
  `unit` varchar(20) NOT NULL DEFAULT '' COMMENT '单位',
  PRIMARY KEY (`id`),
  KEY `apply_id` (`apply_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺采购商品表';

-- ----------------------------
-- Records of t_apply_goods
-- ----------------------------

-- ----------------------------
-- Table structure for `t_apply_log`
-- ----------------------------
DROP TABLE IF EXISTS `t_apply_log`;
CREATE TABLE `t_apply_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `apply_id` int(10) unsigned NOT NULL COMMENT '采购申请id',
  `remark` varchar(255) NOT NULL COMMENT '备注',
  `created_at` int(10) unsigned NOT NULL,
  `updated_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `apply_id` (`apply_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺采购申请记录';

-- ----------------------------
-- Records of t_apply_log
-- ----------------------------

-- ----------------------------
-- Table structure for `t_building`
-- ----------------------------
DROP TABLE IF EXISTS `t_building`;
CREATE TABLE `t_building` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `school_id` int(10) unsigned NOT NULL,
  `status` enum('enabled','disabled') NOT NULL DEFAULT 'enabled',
  `created_at` int(10) unsigned NOT NULL,
  `updated_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `school_id` (`school_id`),
  KEY `status` (`status`),
  KEY `created_at` (`created_at`,`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='学校建筑';

-- ----------------------------
-- Records of t_building
-- ----------------------------
INSERT INTO `t_building` VALUES ('1', '和园食堂', '1', 'enabled', '1461132318', '1461132318');

-- ----------------------------
-- Table structure for `t_cart_goods`
-- ----------------------------
DROP TABLE IF EXISTS `t_cart_goods`;
CREATE TABLE `t_cart_goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL COMMENT '用户id',
  `goods_id` int(10) unsigned NOT NULL COMMENT '商品id',
  `store_id` int(10) unsigned NOT NULL COMMENT '营业点id',
  `price` decimal(8,2) unsigned NOT NULL COMMENT '加入购物车时的商品价格',
  `count` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '商品数量',
  `created_at` int(10) unsigned NOT NULL,
  `updated_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`goods_id`),
  KEY `created_at` (`created_at`,`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='购物车商品';

-- ----------------------------
-- Records of t_cart_goods
-- ----------------------------

-- ----------------------------
-- Table structure for `t_category`
-- ----------------------------
DROP TABLE IF EXISTS `t_category`;
CREATE TABLE `t_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL COMMENT '名称',
  `slug` varchar(60) NOT NULL COMMENT '唯一字符串',
  `sort` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='商品分类';

-- ----------------------------
-- Records of t_category
-- ----------------------------
INSERT INTO `t_category` VALUES ('1', '充饥', 'hunger', '1');
INSERT INTO `t_category` VALUES ('2', '解馋', 'glutton', '2');
INSERT INTO `t_category` VALUES ('3', '水饮', 'thirst', '3');
INSERT INTO `t_category` VALUES ('4', '用品', 'articles', '4');

-- ----------------------------
-- Table structure for `t_feedback`
-- ----------------------------
DROP TABLE IF EXISTS `t_feedback`;
CREATE TABLE `t_feedback` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(255) NOT NULL COMMENT '内容',
  `mobile` char(11) NOT NULL COMMENT '手机号',
  `created_at` int(10) unsigned NOT NULL,
  `updated_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户反馈';

-- ----------------------------
-- Records of t_feedback
-- ----------------------------

-- ----------------------------
-- Table structure for `t_goods`
-- ----------------------------
DROP TABLE IF EXISTS `t_goods`;
CREATE TABLE `t_goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL COMMENT '商品名称',
  `store_id` int(10) unsigned NOT NULL COMMENT '营业点id',
  `category_id` int(10) unsigned NOT NULL COMMENT '分类id',
  `cover` varchar(20) NOT NULL COMMENT '封面图片',
  `price` decimal(8,2) unsigned NOT NULL COMMENT '现价',
  `price_original` decimal(8,2) unsigned DEFAULT NULL COMMENT '原价',
  `cost` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '成本价',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `status` enum('normal','off_shelves','deleted') NOT NULL DEFAULT 'normal' COMMENT '商品状态',
  `surplus` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '库存',
  `sales` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '月销量',
  `unit` varchar(10) NOT NULL DEFAULT '' COMMENT '数量单位',
  `is_new` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否最新商品',
  `is_hot` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否热门商品',
  `is_promotion` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否促销品',
  `created_at` int(10) unsigned NOT NULL,
  `updated_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `store_id` (`store_id`),
  KEY `status` (`status`),
  KEY `created_at` (`created_at`,`updated_at`),
  KEY `is_new` (`is_new`,`is_hot`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_goods
-- ----------------------------
INSERT INTO `t_goods` VALUES ('1', '好吃的鱼', '1', '2', 'dq9oGbPaS8.jpg', '100.00', '119.00', '99.0000', '好吃', 'normal', '99', '1000', '锅', '1', '1', '1', '1461139321', '1461139422');

-- ----------------------------
-- Table structure for `t_goods_img`
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_img`;
CREATE TABLE `t_goods_img` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '图片名',
  `goods_id` int(10) unsigned NOT NULL COMMENT '商品id',
  PRIMARY KEY (`id`),
  KEY `name` (`name`,`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品图片';

-- ----------------------------
-- Records of t_goods_img
-- ----------------------------

-- ----------------------------
-- Table structure for `t_goods_surplus`
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_surplus`;
CREATE TABLE `t_goods_surplus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(10) unsigned NOT NULL COMMENT '商品id',
  `surplus_before` int(10) unsigned NOT NULL COMMENT '之前库存',
  `amount` int(10) NOT NULL COMMENT '变化库存',
  `surplus_after` int(10) unsigned NOT NULL COMMENT '之后库存',
  `remark` varchar(255) NOT NULL COMMENT '备注',
  `created_at` int(10) unsigned NOT NULL,
  `updated_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='商品库存变化记录';

-- ----------------------------
-- Records of t_goods_surplus
-- ----------------------------
INSERT INTO `t_goods_surplus` VALUES ('1', '1', '0', '100', '100', '初始化库存。', '1461139321', '1461139321');
INSERT INTO `t_goods_surplus` VALUES ('2', '1', '100', '-1', '99', '创建订单：X20160420C6C83。', '1461139422', '1461139422');

-- ----------------------------
-- Table structure for `t_member`
-- ----------------------------
DROP TABLE IF EXISTS `t_member`;
CREATE TABLE `t_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `store_id` int(10) unsigned NOT NULL COMMENT '营业点id',
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `real_name` varchar(20) NOT NULL COMMENT '真实姓名',
  `auth_key` varchar(32) NOT NULL,
  `password_hash` varchar(255) NOT NULL COMMENT '密码',
  `access_token` varchar(255) DEFAULT NULL,
  `gender` enum('male','woman','other') NOT NULL DEFAULT 'male' COMMENT '性别',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机',
  `status` enum('active','blocked') NOT NULL DEFAULT 'active' COMMENT '状态',
  `created_at` int(10) unsigned NOT NULL COMMENT '创建时间',
  `updated_at` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  KEY `status` (`status`),
  KEY `store_id` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='店铺人员';

-- ----------------------------
-- Records of t_member
-- ----------------------------
INSERT INTO `t_member` VALUES ('1', '1', 'huang', '黄记煌老板', 'YLzoRwoaPkgr8MqTJNUCxUAat_eYBDzG', '$2y$13$f0qKwNJJ8H54ASL9nLgJguM2f0NIM9z/Y1q75y.LAT0rj7f4sZUpq', null, 'male', 'huang@qq.com', '13012345678', 'active', '1461137248', '1461137248');

-- ----------------------------
-- Table structure for `t_migration`
-- ----------------------------
DROP TABLE IF EXISTS `t_migration`;
CREATE TABLE `t_migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_migration
-- ----------------------------

-- ----------------------------
-- Table structure for `t_order`
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_sn` char(14) NOT NULL COMMENT '订单编号',
  `user_id` int(10) unsigned NOT NULL COMMENT '用户id',
  `store_id` int(10) unsigned NOT NULL COMMENT '营业点id',
  `school_id` int(10) unsigned NOT NULL COMMENT '学校id',
  `status` enum('unshipped','shipped','unpaid','completed','cancelled','deleted') NOT NULL COMMENT '订单状态',
  `payment` enum('online','offline') NOT NULL COMMENT '支付方式',
  `fee` decimal(8,2) unsigned NOT NULL COMMENT '总价',
  `real_fee` decimal(8,2) unsigned NOT NULL COMMENT '实付款',
  `preferential` enum('down','gift','none') NOT NULL COMMENT '优惠类别',
  `down_val` decimal(4,2) unsigned DEFAULT NULL COMMENT '满减优惠金额',
  `gift_val` varchar(60) DEFAULT NULL COMMENT '满送优惠礼品',
  `new_down_val` decimal(4,2) unsigned DEFAULT NULL COMMENT '新用户立减优惠金额',
  `book_time` int(10) unsigned DEFAULT NULL COMMENT '预定时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `cancelled_msg` varchar(60) DEFAULT NULL COMMENT '取消说明',
  `created_at` int(10) unsigned NOT NULL,
  `updated_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_sn` (`order_sn`),
  KEY `user_id` (`user_id`,`store_id`,`status`,`created_at`,`updated_at`),
  KEY `payment` (`payment`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='订单表';

-- ----------------------------
-- Records of t_order
-- ----------------------------
INSERT INTO `t_order` VALUES ('1', 'X20160420C6C83', '1', '1', '1', 'unpaid', 'online', '100.00', '88.00', 'down', '10.00', null, '2.00', null, '不要太辣哦', null, '1461139422', '1461139422');

-- ----------------------------
-- Table structure for `t_order_address`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_address`;
CREATE TABLE `t_order_address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL COMMENT '订单id',
  `consignee` varchar(60) NOT NULL COMMENT '收货人',
  `cellphone` varchar(20) NOT NULL DEFAULT '' COMMENT '手机',
  `gender` enum('male','woman') NOT NULL,
  `school` varchar(60) NOT NULL COMMENT '学校',
  `building` varchar(60) NOT NULL COMMENT '建筑',
  `room` varchar(60) NOT NULL COMMENT '门牌号',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='订单收货地址表';

-- ----------------------------
-- Records of t_order_address
-- ----------------------------
INSERT INTO `t_order_address` VALUES ('1', '1', '周星驰', '18212345678', 'male', '中国农大西校区', '和园食堂', '楼下');

-- ----------------------------
-- Table structure for `t_order_goods`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_goods`;
CREATE TABLE `t_order_goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL COMMENT '订单id',
  `goods_id` int(10) unsigned NOT NULL COMMENT '商品id',
  `name` varchar(60) NOT NULL COMMENT '商品名称',
  `category` varchar(60) NOT NULL COMMENT '分类',
  `price` decimal(8,2) unsigned NOT NULL COMMENT '单价',
  `cost` decimal(10,4) unsigned NOT NULL COMMENT '成本价',
  `count` int(10) unsigned NOT NULL COMMENT '数量',
  `cover` varchar(20) NOT NULL COMMENT '封面图片',
  `unit` varchar(10) NOT NULL DEFAULT '' COMMENT '数量单位',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`,`goods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='订单商品表';

-- ----------------------------
-- Records of t_order_goods
-- ----------------------------
INSERT INTO `t_order_goods` VALUES ('1', '1', '1', '好吃的鱼', '解馋', '100.00', '99.0000', '1', 'dq9oGbPaS8.jpg', '锅');

-- ----------------------------
-- Table structure for `t_order_volume`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_volume`;
CREATE TABLE `t_order_volume` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `volume` decimal(8,2) unsigned NOT NULL COMMENT '交易额',
  `cost` decimal(10,4) unsigned NOT NULL COMMENT '成本',
  `profit` decimal(10,4) NOT NULL COMMENT '利润',
  `order_id` int(10) unsigned NOT NULL COMMENT '订单id',
  `payment` enum('online','offline') NOT NULL COMMENT '支付方式',
  `user_id` int(10) unsigned NOT NULL COMMENT '买家id',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺id',
  `created_at` int(10) unsigned NOT NULL,
  `updated_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `payment` (`payment`),
  KEY `created_at` (`created_at`),
  KEY `updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易记录';

-- ----------------------------
-- Records of t_order_volume
-- ----------------------------

-- ----------------------------
-- Table structure for `t_purchase`
-- ----------------------------
DROP TABLE IF EXISTS `t_purchase`;
CREATE TABLE `t_purchase` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(10) unsigned NOT NULL COMMENT '商品id',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺id',
  `count` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '采购数量',
  `created_at` int(10) unsigned NOT NULL,
  `updated_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `store_id` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺采购表';

-- ----------------------------
-- Records of t_purchase
-- ----------------------------

-- ----------------------------
-- Table structure for `t_school`
-- ----------------------------
DROP TABLE IF EXISTS `t_school`;
CREATE TABLE `t_school` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL COMMENT '学校名称',
  `created_at` int(10) unsigned NOT NULL,
  `updated_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='学校表';

-- ----------------------------
-- Records of t_school
-- ----------------------------
INSERT INTO `t_school` VALUES ('1', '中国农大西校区', '1461132290', '1461132290');

-- ----------------------------
-- Table structure for `t_store`
-- ----------------------------
DROP TABLE IF EXISTS `t_store`;
CREATE TABLE `t_store` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '商店名称',
  `school_id` int(10) unsigned NOT NULL COMMENT '学校id',
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '地址',
  `cellphone` varchar(20) NOT NULL DEFAULT '' COMMENT '手机',
  `telephone` varchar(20) NOT NULL DEFAULT '' COMMENT '电话',
  `notice` varchar(255) NOT NULL DEFAULT '' COMMENT '公告',
  `status` enum('active','rest','disabled') NOT NULL DEFAULT 'active' COMMENT '状态',
  `hours` varchar(60) NOT NULL DEFAULT '' COMMENT '营业时间',
  `has_book` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否支持预定',
  `has_down` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否支持满减优惠',
  `has_gift` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否支持满送优惠',
  `has_least` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有最低购买价',
  `down_upper` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '满减优惠价',
  `down_val` decimal(4,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '满减优惠金额',
  `gift_upper` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '满送优惠价',
  `gift_val` varchar(60) NOT NULL DEFAULT '' COMMENT '满送优惠礼品',
  `least_val` decimal(4,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '最低购买金额',
  `layout` enum('merger','open') NOT NULL DEFAULT 'merger' COMMENT '布局',
  `enable_sms` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否启用短信提醒',
  `auto_toggle` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否自动切换休息营业状态',
  `toggle_type` enum('active','rest','both') DEFAULT 'active' COMMENT '切换类型',
  `created_at` int(10) unsigned NOT NULL COMMENT '创建时间',
  `updated_at` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `auto_toggle` (`auto_toggle`),
  KEY `toggle_type` (`toggle_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='营业点';

-- ----------------------------
-- Records of t_store
-- ----------------------------
INSERT INTO `t_store` VALUES ('1', '黄记煌', '1', '中发百旺商城五楼', '18200000000', '010-82000000', '欢迎来尝试哦', 'active', '20', '1', '1', '1', '1', '100', '10.00', '200', '25', '10.00', 'merger', '0', '1', 'active', '1461132703', '1461137199');

-- ----------------------------
-- Table structure for `t_tag`
-- ----------------------------
DROP TABLE IF EXISTS `t_tag`;
CREATE TABLE `t_tag` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `store_id` int(10) unsigned NOT NULL COMMENT '营业点id',
  `name` varchar(8) NOT NULL COMMENT 'tag名称',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `created_at` int(10) unsigned NOT NULL COMMENT '创建时间',
  `updated_at` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='营业点tag';

-- ----------------------------
-- Records of t_tag
-- ----------------------------
INSERT INTO `t_tag` VALUES ('1', '1', '好吃 ', '1', '1461134441', '1461134441');

-- ----------------------------
-- Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mobile` char(11) NOT NULL COMMENT '手机号',
  `nickname` varchar(60) DEFAULT NULL COMMENT '昵称',
  `auth_key` varchar(32) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `password_reset_token` varchar(255) DEFAULT NULL,
  `access_token` varchar(255) DEFAULT NULL,
  `gender` enum('male','woman','other') NOT NULL DEFAULT 'male' COMMENT '性别',
  `email` varchar(60) DEFAULT NULL COMMENT '邮箱',
  `status` enum('active','blocked') NOT NULL DEFAULT 'active' COMMENT '状态',
  `has_new_down` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否还有新用户立减优惠资格',
  `created_at` int(10) unsigned NOT NULL COMMENT '创建时间',
  `updated_at` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`mobile`),
  UNIQUE KEY `email` (`email`),
  KEY `created_at` (`created_at`,`updated_at`),
  KEY `gender` (`gender`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', '18210137917', 'zhouxinxin', 'aYOOl2ZOT95Y2YlZ5ZwTON_y8jwgvdoc', '$2y$13$PEm7VNw5ApXrUbdT1OE/l..BbF.2zFxWJLBuC9ChYnsZ8zpFLL8ya', null, null, 'male', null, 'active', '0', '1461132114', '1461139422');

-- ----------------------------
-- Table structure for `t_user_account`
-- ----------------------------
DROP TABLE IF EXISTS `t_user_account`;
CREATE TABLE `t_user_account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `balance` decimal(8,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '余额',
  `password_hash` varchar(255) DEFAULT NULL COMMENT '支付密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户账户';

-- ----------------------------
-- Records of t_user_account
-- ----------------------------
