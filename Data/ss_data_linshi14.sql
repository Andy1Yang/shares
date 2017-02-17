/*
Navicat MySQL Data Transfer

Source Server         : phpstudy
Source Server Version : 50547
Source Host           : localhost:3306
Source Database       : shares

Target Server Type    : MYSQL
Target Server Version : 50547
File Encoding         : 65001

Date: 2017-01-21 22:03:31
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ss_action
-- ----------------------------
DROP TABLE IF EXISTS `ss_action`;
CREATE TABLE `ss_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '行为唯一标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '行为说明',
  `remark` char(140) NOT NULL DEFAULT '' COMMENT '行为描述',
  `rule` text COMMENT '行为规则',
  `log` text COMMENT '日志规则',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统行为表';

-- ----------------------------
-- Records of ss_action
-- ----------------------------
INSERT INTO `ss_action` VALUES ('1', 'user_login', '用户登录', '积分+10，每天一次', 'table:member|field:score|condition:uid={$self} AND status>-1|rule:score+10|cycle:24|max:1;', '[user|get_nickname]在[time|time_format]登录了后台', '1', '1', '1387181220');
INSERT INTO `ss_action` VALUES ('2', 'add_article', '发布文章', '积分+5，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:5', '', '2', '0', '1380173180');
INSERT INTO `ss_action` VALUES ('3', 'review', '评论', '评论积分+1，无限制', 'table:member|field:score|condition:uid={$self}|rule:score+1', '', '2', '1', '1383285646');
INSERT INTO `ss_action` VALUES ('4', 'add_document', '发表文档', '积分+10，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:24|max:5', '[user|get_nickname]在[time|time_format]发表了一篇文章。\r\n表[model]，记录编号[record]。', '2', '0', '1386139726');
INSERT INTO `ss_action` VALUES ('5', 'add_document_topic', '发表讨论', '积分+5，每天上限10次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:10', '', '2', '0', '1383285551');
INSERT INTO `ss_action` VALUES ('6', 'update_config', '更新配置', '新增或修改或删除配置', '', '', '1', '1', '1383294988');
INSERT INTO `ss_action` VALUES ('7', 'update_model', '更新模型', '新增或修改模型', '', '', '1', '1', '1383295057');
INSERT INTO `ss_action` VALUES ('8', 'update_attribute', '更新属性', '新增或更新或删除属性', '', '', '1', '1', '1383295963');
INSERT INTO `ss_action` VALUES ('9', 'update_channel', '更新导航', '新增或修改或删除导航', '', '', '1', '1', '1383296301');
INSERT INTO `ss_action` VALUES ('10', 'update_menu', '更新菜单', '新增或修改或删除菜单', '', '', '1', '1', '1383296392');
INSERT INTO `ss_action` VALUES ('11', 'update_category', '更新分类', '新增或修改或删除分类', '', '', '1', '1', '1383296765');

-- ----------------------------
-- Table structure for ss_action_log
-- ----------------------------
DROP TABLE IF EXISTS `ss_action_log`;
CREATE TABLE `ss_action_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `action_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '行为id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行用户id',
  `action_ip` bigint(20) NOT NULL COMMENT '执行行为者ip',
  `model` varchar(50) NOT NULL DEFAULT '' COMMENT '触发行为的表',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '触发行为的数据id',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '日志备注',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  PRIMARY KEY (`id`),
  KEY `action_ip_ix` (`action_ip`),
  KEY `action_id_ix` (`action_id`),
  KEY `user_id_ix` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=100 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='行为日志表';

-- ----------------------------
-- Records of ss_action_log
-- ----------------------------
INSERT INTO `ss_action_log` VALUES ('1', '1', '1', '2130706433', 'member', '1', 'admin在2017-01-08 14:53登录了后台', '1', '1483858400');
INSERT INTO `ss_action_log` VALUES ('2', '1', '1', '2130706433', 'member', '1', 'admin在2017-01-08 15:00登录了后台', '1', '1483858806');
INSERT INTO `ss_action_log` VALUES ('3', '10', '1', '2130706433', 'Menu', '16', '操作url：/admin.php?s=/Menu/edit.html', '1', '1483860912');
INSERT INTO `ss_action_log` VALUES ('4', '10', '1', '2130706433', 'Menu', '17', '操作url：/admin.php?s=/Menu/edit.html', '1', '1483861088');
INSERT INTO `ss_action_log` VALUES ('5', '10', '1', '2130706433', 'Menu', '124', '操作url：/admin.php?s=/Menu/add.html', '1', '1483861266');
INSERT INTO `ss_action_log` VALUES ('6', '10', '1', '2130706433', 'Menu', '125', '操作url：/admin.php?s=/Menu/add.html', '1', '1483861404');
INSERT INTO `ss_action_log` VALUES ('7', '10', '1', '2130706433', 'Menu', '17', '操作url：/admin.php?s=/Menu/edit.html', '1', '1483861550');
INSERT INTO `ss_action_log` VALUES ('8', '10', '1', '2130706433', 'Menu', '27', '操作url：/admin.php?s=/Menu/edit.html', '1', '1483861571');
INSERT INTO `ss_action_log` VALUES ('9', '10', '1', '2130706433', 'Menu', '106', '操作url：/admin.php?s=/Menu/edit.html', '1', '1483862159');
INSERT INTO `ss_action_log` VALUES ('10', '10', '1', '2130706433', 'Menu', '106', '操作url：/admin.php?s=/Menu/edit.html', '1', '1483862184');
INSERT INTO `ss_action_log` VALUES ('11', '10', '1', '2130706433', 'Menu', '128', '操作url：/admin.php?s=/Menu/add.html', '1', '1483862297');
INSERT INTO `ss_action_log` VALUES ('12', '10', '1', '2130706433', 'Menu', '128', '操作url：/admin.php?s=/Menu/edit.html', '1', '1483862339');
INSERT INTO `ss_action_log` VALUES ('13', '10', '1', '2130706433', 'Menu', '17', '操作url：/admin.php?s=/Menu/edit.html', '1', '1483862346');
INSERT INTO `ss_action_log` VALUES ('14', '10', '1', '2130706433', 'Menu', '27', '操作url：/admin.php?s=/Menu/edit.html', '1', '1483862355');
INSERT INTO `ss_action_log` VALUES ('15', '10', '1', '2130706433', 'Menu', '129', '操作url：/admin.php?s=/Menu/add.html', '1', '1483863037');
INSERT INTO `ss_action_log` VALUES ('16', '10', '1', '2130706433', 'Menu', '130', '操作url：/admin.php?s=/Menu/add.html', '1', '1483864243');
INSERT INTO `ss_action_log` VALUES ('17', '10', '1', '2130706433', 'Menu', '131', '操作url：/admin.php?s=/Menu/add.html', '1', '1483864412');
INSERT INTO `ss_action_log` VALUES ('18', '10', '1', '2130706433', 'Menu', '132', '操作url：/admin.php?s=/Menu/add.html', '1', '1483864452');
INSERT INTO `ss_action_log` VALUES ('19', '10', '1', '2130706433', 'Menu', '133', '操作url：/admin.php?s=/Menu/add.html', '1', '1483864925');
INSERT INTO `ss_action_log` VALUES ('20', '10', '1', '2130706433', 'Menu', '134', '操作url：/admin.php?s=/Menu/add.html', '1', '1483865319');
INSERT INTO `ss_action_log` VALUES ('21', '10', '1', '2130706433', 'Menu', '135', '操作url：/admin.php?s=/Menu/add.html', '1', '1483865410');
INSERT INTO `ss_action_log` VALUES ('22', '1', '2', '2130706433', 'member', '2', 'jack在2017-01-08 18:23登录了后台', '1', '1483871021');
INSERT INTO `ss_action_log` VALUES ('23', '1', '2', '2130706433', 'member', '2', 'jack在2017-01-08 18:25登录了后台', '1', '1483871113');
INSERT INTO `ss_action_log` VALUES ('24', '1', '2', '2130706433', 'member', '2', 'jack在2017-01-08 18:26登录了后台', '1', '1483871200');
INSERT INTO `ss_action_log` VALUES ('25', '1', '1', '2130706433', 'member', '1', 'admin在2017-01-08 19:15登录了后台', '1', '1483874115');
INSERT INTO `ss_action_log` VALUES ('26', '10', '1', '2130706433', 'Menu', '136', '操作url：/admin.php?s=/Menu/add.html', '1', '1483875788');
INSERT INTO `ss_action_log` VALUES ('27', '1', '1', '2130706433', 'member', '1', 'admin在2017-01-08 20:58登录了后台', '1', '1483880304');
INSERT INTO `ss_action_log` VALUES ('28', '1', '1', '2130706433', 'member', '1', 'admin在2017-01-09 20:13登录了后台', '1', '1483964008');
INSERT INTO `ss_action_log` VALUES ('29', '1', '1', '2130706433', 'member', '1', 'admin在2017-01-09 22:33登录了后台', '1', '1483972433');
INSERT INTO `ss_action_log` VALUES ('30', '1', '1', '2130706433', 'member', '1', 'admin在2017-01-10 09:18登录了后台', '1', '1484011122');
INSERT INTO `ss_action_log` VALUES ('31', '1', '1', '2130706433', 'member', '1', 'admin在2017-01-11 14:03登录了后台', '1', '1484114633');
INSERT INTO `ss_action_log` VALUES ('32', '10', '1', '2130706433', 'Menu', '137', '操作url：/admin.php?s=/Menu/add.html', '1', '1484145086');
INSERT INTO `ss_action_log` VALUES ('33', '1', '1', '2130706433', 'member', '1', 'admin在2017-01-12 10:14登录了后台', '1', '1484187281');
INSERT INTO `ss_action_log` VALUES ('34', '1', '1', '2130706433', 'member', '1', 'admin在2017-01-12 10:53登录了后台', '1', '1484189589');
INSERT INTO `ss_action_log` VALUES ('35', '1', '1', '2130706433', 'member', '1', 'admin在2017-01-12 11:01登录了后台', '1', '1484190060');
INSERT INTO `ss_action_log` VALUES ('36', '10', '1', '2130706433', 'Menu', '130', '操作url：/admin.php?s=/Menu/edit.html', '1', '1484191597');
INSERT INTO `ss_action_log` VALUES ('37', '1', '1', '2130706433', 'member', '1', 'admin在2017-01-12 15:58登录了后台', '1', '1484207896');
INSERT INTO `ss_action_log` VALUES ('38', '1', '1', '2130706433', 'member', '1', 'admin在2017-01-12 22:33登录了后台', '1', '1484231583');
INSERT INTO `ss_action_log` VALUES ('39', '1', '1', '2130706433', 'member', '1', 'admin在2017-01-14 12:12登录了后台', '1', '1484367164');
INSERT INTO `ss_action_log` VALUES ('40', '1', '1', '2130706433', 'member', '1', 'admin在2017-01-15 14:39登录了后台', '1', '1484462374');
INSERT INTO `ss_action_log` VALUES ('41', '1', '1', '2130706433', 'member', '1', 'admin在2017-01-16 19:58登录了后台', '1', '1484567931');
INSERT INTO `ss_action_log` VALUES ('42', '1', '1', '2130706433', 'member', '1', 'admin在2017-01-17 21:42登录了后台', '1', '1484660542');
INSERT INTO `ss_action_log` VALUES ('43', '6', '1', '2130706433', 'config', '39', '操作url：/admin.php?s=/Config/edit.html', '1', '1484815849');
INSERT INTO `ss_action_log` VALUES ('44', '6', '1', '2130706433', 'config', '41', '操作url：/admin.php?s=/Config/edit.html', '1', '1484817149');
INSERT INTO `ss_action_log` VALUES ('45', '6', '1', '2130706433', 'config', '40', '操作url：/admin.php?s=/Config/edit.html', '1', '1484817198');
INSERT INTO `ss_action_log` VALUES ('46', '6', '1', '2130706433', 'config', '39', '操作url：/admin.php?s=/Config/edit.html', '1', '1484817207');
INSERT INTO `ss_action_log` VALUES ('47', '6', '1', '2130706433', 'config', '38', '操作url：/admin.php?s=/Config/edit.html', '1', '1484817230');
INSERT INTO `ss_action_log` VALUES ('48', '6', '1', '2130706433', 'config', '42', '操作url：/admin.php?s=/Config/edit.html', '1', '1484817407');
INSERT INTO `ss_action_log` VALUES ('49', '6', '1', '2130706433', 'config', '42', '操作url：/admin.php?s=/Config/edit.html', '1', '1484817677');
INSERT INTO `ss_action_log` VALUES ('50', '10', '1', '2130706433', 'Menu', '138', '操作url：/admin.php?s=/Menu/add.html', '1', '1484817827');
INSERT INTO `ss_action_log` VALUES ('51', '1', '1', '2130706433', 'member', '1', 'admin在2017-01-20 17:04登录了后台', '1', '1484903069');
INSERT INTO `ss_action_log` VALUES ('52', '10', '1', '2130706433', 'Menu', '0', '操作url：/admin.php?s=/Menu/del/id/2.html', '1', '1484903118');
INSERT INTO `ss_action_log` VALUES ('53', '10', '1', '2130706433', 'Menu', '0', '操作url：/admin.php?s=/Menu/del/id/93.html', '1', '1484903124');
INSERT INTO `ss_action_log` VALUES ('54', '10', '1', '2130706433', 'Menu', '0', '操作url：/admin.php?s=/Menu/del/id/43.html', '1', '1484903133');
INSERT INTO `ss_action_log` VALUES ('55', '10', '1', '2130706433', 'Menu', '139', '操作url：/admin.php?s=/Menu/add.html', '1', '1484903257');
INSERT INTO `ss_action_log` VALUES ('56', '10', '1', '2130706433', 'Menu', '140', '操作url：/admin.php?s=/Menu/add.html', '1', '1484903299');
INSERT INTO `ss_action_log` VALUES ('57', '1', '1', '2130706433', 'member', '1', 'admin在2017-01-20 17:09登录了后台', '1', '1484903340');
INSERT INTO `ss_action_log` VALUES ('58', '10', '1', '2130706433', 'Menu', '141', '操作url：/admin.php?s=/Menu/add.html', '1', '1484903394');
INSERT INTO `ss_action_log` VALUES ('59', '10', '1', '2130706433', 'Menu', '0', '操作url：/admin.php?s=/Menu/del/id/141.html', '1', '1484903404');
INSERT INTO `ss_action_log` VALUES ('60', '10', '1', '2130706433', 'Menu', '136', '操作url：/admin.php?s=/Menu/edit.html', '1', '1484903447');
INSERT INTO `ss_action_log` VALUES ('61', '10', '1', '2130706433', 'Menu', '142', '操作url：/admin.php?s=/Menu/add.html', '1', '1484904512');
INSERT INTO `ss_action_log` VALUES ('62', '10', '1', '2130706433', 'Menu', '143', '操作url：/admin.php?s=/Menu/add.html', '1', '1484906563');
INSERT INTO `ss_action_log` VALUES ('63', '10', '1', '2130706433', 'Menu', '144', '操作url：/admin.php?s=/Menu/add.html', '1', '1484906607');
INSERT INTO `ss_action_log` VALUES ('64', '10', '1', '2130706433', 'Menu', '143', '操作url：/admin.php?s=/Menu/edit.html', '1', '1484906674');
INSERT INTO `ss_action_log` VALUES ('65', '10', '1', '2130706433', 'Menu', '145', '操作url：/admin.php?s=/Menu/add.html', '1', '1484907160');
INSERT INTO `ss_action_log` VALUES ('66', '10', '1', '2130706433', 'Menu', '146', '操作url：/admin.php?s=/Menu/add.html', '1', '1484907361');
INSERT INTO `ss_action_log` VALUES ('67', '10', '1', '2130706433', 'Menu', '146', '操作url：/admin.php?s=/Menu/edit.html', '1', '1484907377');
INSERT INTO `ss_action_log` VALUES ('68', '10', '1', '2130706433', 'Menu', '147', '操作url：/admin.php?s=/Menu/add.html', '1', '1484908411');
INSERT INTO `ss_action_log` VALUES ('69', '10', '1', '2130706433', 'Menu', '148', '操作url：/admin.php?s=/Menu/add.html', '1', '1484908444');
INSERT INTO `ss_action_log` VALUES ('70', '10', '1', '2130706433', 'Menu', '149', '操作url：/admin.php?s=/Menu/add.html', '1', '1484909255');
INSERT INTO `ss_action_log` VALUES ('71', '10', '1', '2130706433', 'Menu', '150', '操作url：/admin.php?s=/Menu/add.html', '1', '1484909281');
INSERT INTO `ss_action_log` VALUES ('72', '10', '1', '2130706433', 'Menu', '151', '操作url：/admin.php?s=/Menu/add.html', '1', '1484916661');
INSERT INTO `ss_action_log` VALUES ('73', '10', '1', '2130706433', 'Menu', '152', '操作url：/admin.php?s=/Menu/add.html', '1', '1484916799');
INSERT INTO `ss_action_log` VALUES ('74', '10', '1', '2130706433', 'Menu', '153', '操作url：/admin.php?s=/Menu/add.html', '1', '1484916852');
INSERT INTO `ss_action_log` VALUES ('75', '10', '1', '2130706433', 'Menu', '154', '操作url：/admin.php?s=/Menu/add.html', '1', '1484916884');
INSERT INTO `ss_action_log` VALUES ('76', '10', '1', '2130706433', 'Menu', '155', '操作url：/admin.php?s=/Menu/add.html', '1', '1484916925');
INSERT INTO `ss_action_log` VALUES ('77', '1', '1', '2130706433', 'member', '1', 'admin在2017-01-20 21:16登录了后台', '1', '1484918183');
INSERT INTO `ss_action_log` VALUES ('78', '1', '2', '2130706433', 'member', '2', 'jack在2017-01-20 21:17登录了后台', '1', '1484918258');
INSERT INTO `ss_action_log` VALUES ('79', '1', '5', '2130706433', 'member', '5', 'test在2017-01-20 21:22登录了后台', '1', '1484918574');
INSERT INTO `ss_action_log` VALUES ('80', '1', '5', '2130706433', 'member', '5', 'test在2017-01-20 21:23登录了后台', '1', '1484918605');
INSERT INTO `ss_action_log` VALUES ('81', '10', '1', '2130706433', 'Menu', '150', '操作url：/admin.php?s=/Menu/edit.html', '1', '1484920794');
INSERT INTO `ss_action_log` VALUES ('82', '10', '1', '2130706433', 'Menu', '156', '操作url：/admin.php?s=/Menu/add.html', '1', '1484920928');
INSERT INTO `ss_action_log` VALUES ('83', '1', '7', '2130706433', 'member', '7', '颐和园在2017-01-20 23:24登录了后台', '1', '1484925858');
INSERT INTO `ss_action_log` VALUES ('84', '1', '7', '2130706433', 'member', '7', '颐和园在2017-01-20 23:25登录了后台', '1', '1484925902');
INSERT INTO `ss_action_log` VALUES ('85', '10', '1', '2130706433', 'Menu', '147', '操作url：/admin.php?s=/Menu/edit.html', '1', '1484926219');
INSERT INTO `ss_action_log` VALUES ('86', '10', '1', '2130706433', 'Menu', '147', '操作url：/admin.php?s=/Menu/edit.html', '1', '1484926280');
INSERT INTO `ss_action_log` VALUES ('87', '1', '7', '2130706433', 'member', '7', '颐和园在2017-01-20 23:32登录了后台', '1', '1484926344');
INSERT INTO `ss_action_log` VALUES ('88', '10', '1', '2130706433', 'Menu', '146', '操作url：/admin.php?s=/Menu/edit.html', '1', '1484926815');
INSERT INTO `ss_action_log` VALUES ('89', '10', '1', '2130706433', 'Menu', '147', '操作url：/admin.php?s=/Menu/edit.html', '1', '1484926821');
INSERT INTO `ss_action_log` VALUES ('90', '10', '1', '2130706433', 'Menu', '148', '操作url：/admin.php?s=/Menu/edit.html', '1', '1484926828');
INSERT INTO `ss_action_log` VALUES ('91', '1', '7', '2130706433', 'member', '7', '颐和园在2017-01-20 23:41登录了后台', '1', '1484926871');
INSERT INTO `ss_action_log` VALUES ('92', '1', '7', '2130706433', 'member', '7', '颐和园在2017-01-20 23:42登录了后台', '1', '1484926979');
INSERT INTO `ss_action_log` VALUES ('93', '1', '7', '2130706433', 'member', '7', '颐和园在2017-01-20 23:44登录了后台', '1', '1484927082');
INSERT INTO `ss_action_log` VALUES ('94', '1', '7', '2130706433', 'member', '7', '颐和园在2017-01-20 23:46登录了后台', '1', '1484927176');
INSERT INTO `ss_action_log` VALUES ('95', '1', '1', '2130706433', 'member', '1', 'admin在2017-01-21 18:26登录了后台', '1', '1484994411');
INSERT INTO `ss_action_log` VALUES ('96', '1', '7', '2130706433', 'member', '7', '颐和园在2017-01-21 18:31登录了后台', '1', '1484994687');
INSERT INTO `ss_action_log` VALUES ('97', '1', '2', '2130706433', 'member', '2', 'jack在2017-01-21 18:32登录了后台', '1', '1484994754');
INSERT INTO `ss_action_log` VALUES ('98', '1', '7', '2130706433', 'member', '7', '颐和园在2017-01-21 20:13登录了后台', '1', '1485000803');
INSERT INTO `ss_action_log` VALUES ('99', '1', '7', '2130706433', 'member', '7', '颐和园在2017-01-21 20:17登录了后台', '1', '1485001068');

-- ----------------------------
-- Table structure for ss_addons
-- ----------------------------
DROP TABLE IF EXISTS `ss_addons`;
CREATE TABLE `ss_addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL COMMENT '插件名或标识',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '中文名',
  `description` text COMMENT '插件描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `config` text COMMENT '配置',
  `author` varchar(40) DEFAULT '' COMMENT '作者',
  `version` varchar(20) DEFAULT '' COMMENT '版本号',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `has_adminlist` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台列表',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='插件表';

-- ----------------------------
-- Records of ss_addons
-- ----------------------------
INSERT INTO `ss_addons` VALUES ('15', 'EditorForAdmin', '后台编辑器', '用于增强整站长文本的输入和显示', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"1\",\"editor_height\":\"500px\",\"editor_resize_type\":\"1\"}', 'thinkphp', '0.1', '1383126253', '0');
INSERT INTO `ss_addons` VALUES ('2', 'SiteStat', '站点统计信息', '统计站点的基础信息', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"1\",\"display\":\"1\",\"status\":\"0\"}', 'thinkphp', '0.1', '1379512015', '0');
INSERT INTO `ss_addons` VALUES ('3', 'DevTeam', '开发团队信息', '开发团队成员信息', '1', '{\"title\":\"OneThink\\u5f00\\u53d1\\u56e2\\u961f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1379512022', '0');
INSERT INTO `ss_addons` VALUES ('4', 'SystemInfo', '系统环境信息', '用于显示一些服务器的信息', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1379512036', '0');
INSERT INTO `ss_addons` VALUES ('5', 'Editor', '前台编辑器', '用于增强整站长文本的输入和显示', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"1\",\"editor_height\":\"300px\",\"editor_resize_type\":\"1\"}', 'thinkphp', '0.1', '1379830910', '0');
INSERT INTO `ss_addons` VALUES ('6', 'Attachment', '附件', '用于文档模型上传附件', '1', 'null', 'thinkphp', '0.1', '1379842319', '1');
INSERT INTO `ss_addons` VALUES ('9', 'SocialComment', '通用社交化评论', '集成了各种社交化评论插件，轻松集成到系统中。', '1', '{\"comment_type\":\"1\",\"comment_uid_youyan\":\"\",\"comment_short_name_duoshuo\":\"\",\"comment_data_list_duoshuo\":\"\"}', 'thinkphp', '0.1', '1380273962', '0');

-- ----------------------------
-- Table structure for ss_attachment
-- ----------------------------
DROP TABLE IF EXISTS `ss_attachment`;
CREATE TABLE `ss_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '附件显示名',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件类型',
  `source` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '资源ID',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联记录ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '附件大小',
  `dir` int(12) unsigned NOT NULL DEFAULT '0' COMMENT '上级目录ID',
  `sort` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_record_status` (`record_id`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='附件表';

-- ----------------------------
-- Records of ss_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for ss_attribute
-- ----------------------------
DROP TABLE IF EXISTS `ss_attribute`;
CREATE TABLE `ss_attribute` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '字段名',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '字段注释',
  `field` varchar(100) NOT NULL DEFAULT '' COMMENT '字段定义',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '数据类型',
  `value` varchar(100) NOT NULL DEFAULT '' COMMENT '字段默认值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '参数',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模型id',
  `is_must` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否必填',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `validate_rule` varchar(255) NOT NULL DEFAULT '',
  `validate_time` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `error_info` varchar(100) NOT NULL DEFAULT '',
  `validate_type` varchar(25) NOT NULL DEFAULT '',
  `auto_rule` varchar(100) NOT NULL DEFAULT '',
  `auto_time` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `auto_type` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `model_id` (`model_id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='模型属性表';

-- ----------------------------
-- Records of ss_attribute
-- ----------------------------
INSERT INTO `ss_attribute` VALUES ('1', 'uid', '用户ID', 'int(10) unsigned NOT NULL ', 'num', '0', '', '0', '', '1', '0', '1', '1384508362', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('2', 'name', '标识', 'char(40) NOT NULL ', 'string', '', '同一根节点下标识不重复', '1', '', '1', '0', '1', '1383894743', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('3', 'title', '标题', 'char(80) NOT NULL ', 'string', '', '文档标题', '1', '', '1', '0', '1', '1383894778', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('4', 'category_id', '所属分类', 'int(10) unsigned NOT NULL ', 'string', '', '', '0', '', '1', '0', '1', '1384508336', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('5', 'description', '描述', 'char(140) NOT NULL ', 'textarea', '', '', '1', '', '1', '0', '1', '1383894927', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('6', 'root', '根节点', 'int(10) unsigned NOT NULL ', 'num', '0', '该文档的顶级文档编号', '0', '', '1', '0', '1', '1384508323', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('7', 'pid', '所属ID', 'int(10) unsigned NOT NULL ', 'num', '0', '父文档编号', '0', '', '1', '0', '1', '1384508543', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('8', 'model_id', '内容模型ID', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '该文档所对应的模型', '0', '', '1', '0', '1', '1384508350', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('9', 'type', '内容类型', 'tinyint(3) unsigned NOT NULL ', 'select', '2', '', '1', '1:目录\r\n2:主题\r\n3:段落', '1', '0', '1', '1384511157', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('10', 'position', '推荐位', 'smallint(5) unsigned NOT NULL ', 'checkbox', '0', '多个推荐则将其推荐值相加', '1', '[DOCUMENT_POSITION]', '1', '0', '1', '1383895640', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('11', 'link_id', '外链', 'int(10) unsigned NOT NULL ', 'num', '0', '0-非外链，大于0-外链ID,需要函数进行链接与编号的转换', '1', '', '1', '0', '1', '1383895757', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('12', 'cover_id', '封面', 'int(10) unsigned NOT NULL ', 'picture', '0', '0-无封面，大于0-封面图片ID，需要函数处理', '1', '', '1', '0', '1', '1384147827', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('13', 'display', '可见性', 'tinyint(3) unsigned NOT NULL ', 'radio', '1', '', '1', '0:不可见\r\n1:所有人可见', '1', '0', '1', '1386662271', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `ss_attribute` VALUES ('14', 'deadline', '截至时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '0-永久有效', '1', '', '1', '0', '1', '1387163248', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `ss_attribute` VALUES ('15', 'attach', '附件数量', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '', '0', '', '1', '0', '1', '1387260355', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `ss_attribute` VALUES ('16', 'view', '浏览量', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '1', '0', '1', '1383895835', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('17', 'comment', '评论数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '1', '0', '1', '1383895846', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('18', 'extend', '扩展统计字段', 'int(10) unsigned NOT NULL ', 'num', '0', '根据需求自行使用', '0', '', '1', '0', '1', '1384508264', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('19', 'level', '优先级', 'int(10) unsigned NOT NULL ', 'num', '0', '越高排序越靠前', '1', '', '1', '0', '1', '1383895894', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('20', 'create_time', '创建时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '1', '', '1', '0', '1', '1383895903', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('21', 'update_time', '更新时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '0', '', '1', '0', '1', '1384508277', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('22', 'status', '数据状态', 'tinyint(4) NOT NULL ', 'radio', '0', '', '0', '-1:删除\r\n0:禁用\r\n1:正常\r\n2:待审核\r\n3:草稿', '1', '0', '1', '1384508496', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('23', 'parse', '内容解析类型', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', '0', '0:html\r\n1:ubb\r\n2:markdown', '2', '0', '1', '1384511049', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('24', 'content', '文章内容', 'text NOT NULL ', 'editor', '', '', '1', '', '2', '0', '1', '1383896225', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('25', 'template', '详情页显示模板', 'varchar(100) NOT NULL ', 'string', '', '参照display方法参数的定义', '1', '', '2', '0', '1', '1383896190', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('26', 'bookmark', '收藏数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '2', '0', '1', '1383896103', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('27', 'parse', '内容解析类型', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', '0', '0:html\r\n1:ubb\r\n2:markdown', '3', '0', '1', '1387260461', '1383891252', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `ss_attribute` VALUES ('28', 'content', '下载详细描述', 'text NOT NULL ', 'editor', '', '', '1', '', '3', '0', '1', '1383896438', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('29', 'template', '详情页显示模板', 'varchar(100) NOT NULL ', 'string', '', '', '1', '', '3', '0', '1', '1383896429', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('30', 'file_id', '文件ID', 'int(10) unsigned NOT NULL ', 'file', '0', '需要函数处理', '1', '', '3', '0', '1', '1383896415', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('31', 'download', '下载次数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '3', '0', '1', '1383896380', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `ss_attribute` VALUES ('32', 'size', '文件大小', 'bigint(20) unsigned NOT NULL ', 'num', '0', '单位bit', '1', '', '3', '0', '1', '1383896371', '1383891252', '', '0', '', '', '', '0', '');

-- ----------------------------
-- Table structure for ss_auth_extend
-- ----------------------------
DROP TABLE IF EXISTS `ss_auth_extend`;
CREATE TABLE `ss_auth_extend` (
  `group_id` mediumint(10) unsigned NOT NULL COMMENT '用户id',
  `extend_id` mediumint(8) unsigned NOT NULL COMMENT '扩展表中数据的id',
  `type` tinyint(1) unsigned NOT NULL COMMENT '扩展类型标识 1:栏目分类权限;2:模型权限',
  UNIQUE KEY `group_extend_type` (`group_id`,`extend_id`,`type`),
  KEY `uid` (`group_id`),
  KEY `group_id` (`extend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组与分类的对应关系表';

-- ----------------------------
-- Records of ss_auth_extend
-- ----------------------------
INSERT INTO `ss_auth_extend` VALUES ('1', '1', '1');
INSERT INTO `ss_auth_extend` VALUES ('1', '1', '2');
INSERT INTO `ss_auth_extend` VALUES ('1', '2', '1');
INSERT INTO `ss_auth_extend` VALUES ('1', '2', '2');
INSERT INTO `ss_auth_extend` VALUES ('1', '3', '1');
INSERT INTO `ss_auth_extend` VALUES ('1', '3', '2');
INSERT INTO `ss_auth_extend` VALUES ('1', '4', '1');
INSERT INTO `ss_auth_extend` VALUES ('1', '37', '1');

-- ----------------------------
-- Table structure for ss_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `ss_auth_group`;
CREATE TABLE `ss_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `module` varchar(20) NOT NULL DEFAULT '' COMMENT '用户组所属模块',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '组类型',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `description` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ss_auth_group
-- ----------------------------
INSERT INTO `ss_auth_group` VALUES ('1', 'admin', '1', '默认用户组', '', '1', '1,2,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,81,82,83,84,86,87,88,89,90,91,92,93,94,95,96,97,100,102,103,105,106');
INSERT INTO `ss_auth_group` VALUES ('2', 'admin', '1', '测试用户', '测试用户', '1', '1,2,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,82,83,84,88,89,90,91,92,93,96,97,100,102,103,195');
INSERT INTO `ss_auth_group` VALUES ('3', 'admin', '1', '营业一部', '一号门店', '1', '1,3,26,108,109,220,221,222,223,224,225,226,227,228');
INSERT INTO `ss_auth_group` VALUES ('4', 'admin', '1', '营业二部', '', '1', '1,3,26,108,109,219,223,224,225,226,227,231,232,237,238,240,241,243,244,245,246,247,248,249,250');

-- ----------------------------
-- Table structure for ss_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `ss_auth_group_access`;
CREATE TABLE `ss_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ss_auth_group_access
-- ----------------------------
INSERT INTO `ss_auth_group_access` VALUES ('2', '3');
INSERT INTO `ss_auth_group_access` VALUES ('5', '3');
INSERT INTO `ss_auth_group_access` VALUES ('7', '4');

-- ----------------------------
-- Table structure for ss_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `ss_auth_rule`;
CREATE TABLE `ss_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1-url;2-主菜单',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=251 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ss_auth_rule
-- ----------------------------
INSERT INTO `ss_auth_rule` VALUES ('1', 'admin', '2', 'Admin/Index/index', '首页', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('2', 'admin', '2', 'Admin/Article/index', '内容', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('3', 'admin', '2', 'Admin/User/index', '账户', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('4', 'admin', '2', 'Admin/Addons/index', '扩展', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('5', 'admin', '2', 'Admin/Config/group', '系统', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('7', 'admin', '1', 'Admin/article/add', '新增', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('8', 'admin', '1', 'Admin/article/edit', '编辑', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('9', 'admin', '1', 'Admin/article/setStatus', '改变状态', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('10', 'admin', '1', 'Admin/article/update', '保存', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('11', 'admin', '1', 'Admin/article/autoSave', '保存草稿', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('12', 'admin', '1', 'Admin/article/move', '移动', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('13', 'admin', '1', 'Admin/article/copy', '复制', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('14', 'admin', '1', 'Admin/article/paste', '粘贴', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('15', 'admin', '1', 'Admin/article/permit', '还原', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('16', 'admin', '1', 'Admin/article/clear', '清空', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('17', 'admin', '1', 'Admin/Article/examine', '审核列表', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('18', 'admin', '1', 'Admin/article/recycle', '回收站', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('19', 'admin', '1', 'Admin/User/addaction', '新增用户行为', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('20', 'admin', '1', 'Admin/User/editaction', '编辑用户行为', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('21', 'admin', '1', 'Admin/User/saveAction', '保存用户行为', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('22', 'admin', '1', 'Admin/User/setStatus', '变更行为状态', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('23', 'admin', '1', 'Admin/User/changeStatus?method=forbidUser', '禁用会员', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('24', 'admin', '1', 'Admin/User/changeStatus?method=resumeUser', '启用会员', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('25', 'admin', '1', 'Admin/User/changeStatus?method=deleteUser', '删除会员', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('26', 'admin', '1', 'Admin/User/index', '业务员信息', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('27', 'admin', '1', 'Admin/User/action', '用户行为', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('28', 'admin', '1', 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('29', 'admin', '1', 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('30', 'admin', '1', 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('31', 'admin', '1', 'Admin/AuthManager/createGroup', '新增', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('32', 'admin', '1', 'Admin/AuthManager/editGroup', '编辑', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('33', 'admin', '1', 'Admin/AuthManager/writeGroup', '保存用户组', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('34', 'admin', '1', 'Admin/AuthManager/group', '授权', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('35', 'admin', '1', 'Admin/AuthManager/access', '访问授权', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('36', 'admin', '1', 'Admin/AuthManager/user', '成员授权', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('37', 'admin', '1', 'Admin/AuthManager/removeFromGroup', '解除授权', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('38', 'admin', '1', 'Admin/AuthManager/addToGroup', '保存成员授权', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('39', 'admin', '1', 'Admin/AuthManager/category', '分类授权', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('40', 'admin', '1', 'Admin/AuthManager/addToCategory', '保存分类授权', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('41', 'admin', '1', 'Admin/AuthManager/index', '权限管理', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('42', 'admin', '1', 'Admin/Addons/create', '创建', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('43', 'admin', '1', 'Admin/Addons/checkForm', '检测创建', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('44', 'admin', '1', 'Admin/Addons/preview', '预览', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('45', 'admin', '1', 'Admin/Addons/build', '快速生成插件', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('46', 'admin', '1', 'Admin/Addons/config', '设置', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('47', 'admin', '1', 'Admin/Addons/disable', '禁用', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('48', 'admin', '1', 'Admin/Addons/enable', '启用', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('49', 'admin', '1', 'Admin/Addons/install', '安装', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('50', 'admin', '1', 'Admin/Addons/uninstall', '卸载', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('51', 'admin', '1', 'Admin/Addons/saveconfig', '更新配置', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('52', 'admin', '1', 'Admin/Addons/adminList', '插件后台列表', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('53', 'admin', '1', 'Admin/Addons/execute', 'URL方式访问插件', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('54', 'admin', '1', 'Admin/Addons/index', '插件管理', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('55', 'admin', '1', 'Admin/Addons/hooks', '钩子管理', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('56', 'admin', '1', 'Admin/model/add', '新增', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('57', 'admin', '1', 'Admin/model/edit', '编辑', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('58', 'admin', '1', 'Admin/model/setStatus', '改变状态', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('59', 'admin', '1', 'Admin/model/update', '保存数据', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('60', 'admin', '1', 'Admin/Model/index', '模型管理', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('61', 'admin', '1', 'Admin/Config/edit', '编辑', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('62', 'admin', '1', 'Admin/Config/del', '删除', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('63', 'admin', '1', 'Admin/Config/add', '新增', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('64', 'admin', '1', 'Admin/Config/save', '保存', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('65', 'admin', '1', 'Admin/Config/group', '网站设置', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('66', 'admin', '1', 'Admin/Config/index', '配置管理', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('67', 'admin', '1', 'Admin/Channel/add', '新增', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('68', 'admin', '1', 'Admin/Channel/edit', '编辑', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('69', 'admin', '1', 'Admin/Channel/del', '删除', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('70', 'admin', '1', 'Admin/Channel/index', '导航管理', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('71', 'admin', '1', 'Admin/Category/edit', '编辑', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('72', 'admin', '1', 'Admin/Category/add', '新增', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('73', 'admin', '1', 'Admin/Category/remove', '删除', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('74', 'admin', '1', 'Admin/Category/index', '分类管理', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('75', 'admin', '1', 'Admin/file/upload', '上传控件', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('76', 'admin', '1', 'Admin/file/uploadPicture', '上传图片', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('77', 'admin', '1', 'Admin/file/download', '下载', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('94', 'admin', '1', 'Admin/AuthManager/modelauth', '模型授权', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('79', 'admin', '1', 'Admin/article/batchOperate', '导入', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('80', 'admin', '1', 'Admin/Database/index?type=export', '备份数据库', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('81', 'admin', '1', 'Admin/Database/index?type=import', '还原数据库', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('82', 'admin', '1', 'Admin/Database/export', '备份', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('83', 'admin', '1', 'Admin/Database/optimize', '优化表', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('84', 'admin', '1', 'Admin/Database/repair', '修复表', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('86', 'admin', '1', 'Admin/Database/import', '恢复', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('87', 'admin', '1', 'Admin/Database/del', '删除', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('88', 'admin', '1', 'Admin/User/add', '新增用户', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('89', 'admin', '1', 'Admin/Attribute/index', '属性管理', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('90', 'admin', '1', 'Admin/Attribute/add', '新增', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('91', 'admin', '1', 'Admin/Attribute/edit', '编辑', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('92', 'admin', '1', 'Admin/Attribute/setStatus', '改变状态', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('93', 'admin', '1', 'Admin/Attribute/update', '保存数据', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('95', 'admin', '1', 'Admin/AuthManager/addToModel', '保存模型授权', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('96', 'admin', '1', 'Admin/Category/move', '移动', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('97', 'admin', '1', 'Admin/Category/merge', '合并', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('98', 'admin', '1', 'Admin/Config/menu', '后台菜单管理', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('99', 'admin', '1', 'Admin/Article/mydocument', '内容', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('100', 'admin', '1', 'Admin/Menu/index', '菜单管理', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('101', 'admin', '1', 'Admin/other', '其他', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('102', 'admin', '1', 'Admin/Menu/add', '新增', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('103', 'admin', '1', 'Admin/Menu/edit', '编辑', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('104', 'admin', '1', 'Admin/Think/lists?model=article', '文章管理', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('105', 'admin', '1', 'Admin/Think/lists?model=download', '下载管理', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('106', 'admin', '1', 'Admin/Think/lists?model=config', '配置管理', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('107', 'admin', '1', 'Admin/Action/actionlog', '行为日志', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('108', 'admin', '1', 'Admin/User/updatePassword', '修改密码', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('109', 'admin', '1', 'Admin/User/updateNickname', '修改昵称', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('110', 'admin', '1', 'Admin/action/edit', '查看行为日志', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('205', 'admin', '1', 'Admin/think/add', '新增数据', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('111', 'admin', '2', 'Admin/article/index', '文档列表', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('112', 'admin', '2', 'Admin/article/add', '新增', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('113', 'admin', '2', 'Admin/article/edit', '编辑', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('114', 'admin', '2', 'Admin/article/setStatus', '改变状态', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('115', 'admin', '2', 'Admin/article/update', '保存', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('116', 'admin', '2', 'Admin/article/autoSave', '保存草稿', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('117', 'admin', '2', 'Admin/article/move', '移动', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('118', 'admin', '2', 'Admin/article/copy', '复制', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('119', 'admin', '2', 'Admin/article/paste', '粘贴', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('120', 'admin', '2', 'Admin/article/batchOperate', '导入', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('121', 'admin', '2', 'Admin/article/recycle', '回收站', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('122', 'admin', '2', 'Admin/article/permit', '还原', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('123', 'admin', '2', 'Admin/article/clear', '清空', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('124', 'admin', '2', 'Admin/User/add', '新增用户', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('125', 'admin', '2', 'Admin/User/action', '用户行为', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('126', 'admin', '2', 'Admin/User/addAction', '新增用户行为', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('127', 'admin', '2', 'Admin/User/editAction', '编辑用户行为', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('128', 'admin', '2', 'Admin/User/saveAction', '保存用户行为', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('129', 'admin', '2', 'Admin/User/setStatus', '变更行为状态', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('130', 'admin', '2', 'Admin/User/changeStatus?method=forbidUser', '禁用会员', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('131', 'admin', '2', 'Admin/User/changeStatus?method=resumeUser', '启用会员', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('132', 'admin', '2', 'Admin/User/changeStatus?method=deleteUser', '删除会员', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('133', 'admin', '2', 'Admin/AuthManager/index', '权限管理', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('134', 'admin', '2', 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('135', 'admin', '2', 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('136', 'admin', '2', 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('137', 'admin', '2', 'Admin/AuthManager/createGroup', '新增', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('138', 'admin', '2', 'Admin/AuthManager/editGroup', '编辑', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('139', 'admin', '2', 'Admin/AuthManager/writeGroup', '保存用户组', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('140', 'admin', '2', 'Admin/AuthManager/group', '授权', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('141', 'admin', '2', 'Admin/AuthManager/access', '访问授权', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('142', 'admin', '2', 'Admin/AuthManager/user', '成员授权', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('143', 'admin', '2', 'Admin/AuthManager/removeFromGroup', '解除授权', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('144', 'admin', '2', 'Admin/AuthManager/addToGroup', '保存成员授权', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('145', 'admin', '2', 'Admin/AuthManager/category', '分类授权', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('146', 'admin', '2', 'Admin/AuthManager/addToCategory', '保存分类授权', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('147', 'admin', '2', 'Admin/AuthManager/modelauth', '模型授权', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('148', 'admin', '2', 'Admin/AuthManager/addToModel', '保存模型授权', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('149', 'admin', '2', 'Admin/Addons/create', '创建', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('150', 'admin', '2', 'Admin/Addons/checkForm', '检测创建', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('151', 'admin', '2', 'Admin/Addons/preview', '预览', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('152', 'admin', '2', 'Admin/Addons/build', '快速生成插件', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('153', 'admin', '2', 'Admin/Addons/config', '设置', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('154', 'admin', '2', 'Admin/Addons/disable', '禁用', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('155', 'admin', '2', 'Admin/Addons/enable', '启用', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('156', 'admin', '2', 'Admin/Addons/install', '安装', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('157', 'admin', '2', 'Admin/Addons/uninstall', '卸载', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('158', 'admin', '2', 'Admin/Addons/saveconfig', '更新配置', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('159', 'admin', '2', 'Admin/Addons/adminList', '插件后台列表', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('160', 'admin', '2', 'Admin/Addons/execute', 'URL方式访问插件', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('161', 'admin', '2', 'Admin/Addons/hooks', '钩子管理', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('162', 'admin', '2', 'Admin/Model/index', '模型管理', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('163', 'admin', '2', 'Admin/model/add', '新增', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('164', 'admin', '2', 'Admin/model/edit', '编辑', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('165', 'admin', '2', 'Admin/model/setStatus', '改变状态', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('166', 'admin', '2', 'Admin/model/update', '保存数据', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('167', 'admin', '2', 'Admin/Attribute/index', '属性管理', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('168', 'admin', '2', 'Admin/Attribute/add', '新增', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('169', 'admin', '2', 'Admin/Attribute/edit', '编辑', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('170', 'admin', '2', 'Admin/Attribute/setStatus', '改变状态', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('171', 'admin', '2', 'Admin/Attribute/update', '保存数据', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('172', 'admin', '2', 'Admin/Config/index', '配置管理', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('173', 'admin', '2', 'Admin/Config/edit', '编辑', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('174', 'admin', '2', 'Admin/Config/del', '删除', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('175', 'admin', '2', 'Admin/Config/add', '新增', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('176', 'admin', '2', 'Admin/Config/save', '保存', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('177', 'admin', '2', 'Admin/Menu/index', '菜单管理', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('178', 'admin', '2', 'Admin/Channel/index', '导航管理', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('179', 'admin', '2', 'Admin/Channel/add', '新增', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('180', 'admin', '2', 'Admin/Channel/edit', '编辑', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('181', 'admin', '2', 'Admin/Channel/del', '删除', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('182', 'admin', '2', 'Admin/Category/index', '分类管理', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('183', 'admin', '2', 'Admin/Category/edit', '编辑', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('184', 'admin', '2', 'Admin/Category/add', '新增', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('185', 'admin', '2', 'Admin/Category/remove', '删除', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('186', 'admin', '2', 'Admin/Category/move', '移动', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('187', 'admin', '2', 'Admin/Category/merge', '合并', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('188', 'admin', '2', 'Admin/Database/index?type=export', '备份数据库', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('189', 'admin', '2', 'Admin/Database/export', '备份', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('190', 'admin', '2', 'Admin/Database/optimize', '优化表', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('191', 'admin', '2', 'Admin/Database/repair', '修复表', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('192', 'admin', '2', 'Admin/Database/index?type=import', '还原数据库', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('193', 'admin', '2', 'Admin/Database/import', '恢复', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('194', 'admin', '2', 'Admin/Database/del', '删除', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('195', 'admin', '2', 'Admin/other', '其他', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('196', 'admin', '2', 'Admin/Menu/add', '新增', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('197', 'admin', '2', 'Admin/Menu/edit', '编辑', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('198', 'admin', '2', 'Admin/Think/lists?model=article', '应用', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('199', 'admin', '2', 'Admin/Think/lists?model=download', '下载管理', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('200', 'admin', '2', 'Admin/Think/lists?model=config', '应用', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('201', 'admin', '2', 'Admin/Action/actionlog', '行为日志', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('202', 'admin', '2', 'Admin/User/updatePassword', '修改密码', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('203', 'admin', '2', 'Admin/User/updateNickname', '修改昵称', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('204', 'admin', '2', 'Admin/action/edit', '查看行为日志', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('206', 'admin', '1', 'Admin/think/edit', '编辑数据', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('207', 'admin', '1', 'Admin/Menu/import', '导入', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('208', 'admin', '1', 'Admin/Model/generate', '生成', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('209', 'admin', '1', 'Admin/Addons/addHook', '新增钩子', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('210', 'admin', '1', 'Admin/Addons/edithook', '编辑钩子', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('211', 'admin', '1', 'Admin/Article/sort', '文档排序', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('212', 'admin', '1', 'Admin/Config/sort', '排序', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('213', 'admin', '1', 'Admin/Menu/sort', '排序', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('214', 'admin', '1', 'Admin/Channel/sort', '排序', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('215', 'admin', '1', 'Admin/Category/operate/type/move', '移动', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('216', 'admin', '1', 'Admin/Category/operate/type/merge', '合并', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('217', 'admin', '1', 'Admin/article/index', '文档列表', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('218', 'admin', '1', 'Admin/think/lists', '数据列表', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('219', 'admin', '1', 'Admin/User/sales_list', '营业部列表', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('220', 'admin', '1', 'Admin/Report/index', '盈亏汇总', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('221', 'admin', '1', 'Admin/Report/deal', '交易结算清单', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('222', 'admin', '1', 'Admin/Report/layer', '业务员提成', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('223', 'admin', '1', 'Admin/User/user_add', '账户登记', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('224', 'admin', '1', 'Admin/User/user_list', '账户列表', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('225', 'admin', '2', 'Admin/Capital/index', '资金', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('226', 'admin', '2', 'Admin/Operate/index', '交易', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('227', 'admin', '2', 'Admin/Account/index', '结算', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('228', 'admin', '2', 'Admin/Report/index', '报表', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('229', 'admin', '1', 'Admin/User/sales_add', '添加营业部', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('230', 'admin', '1', 'Admin//User/sales_edit/', '营业部修改', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('231', 'admin', '1', 'Admin/Capital/edit', '修改资金流水', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('232', 'admin', '1', 'Admin//User/user_edit/', '账户修改', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('233', 'admin', '1', 'Admin//User/sales_del/', '营业部删除', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('234', 'admin', '1', 'Admin//User/edit/', '业务员修改', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('235', 'admin', '1', 'Admin//User/changeStatus/', '业务员状态修改或删除', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('236', 'admin', '1', 'Admin//AuthManager/group/', '业务员授权', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('237', 'admin', '1', 'Admin//User/user_del/', '账户删除', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('238', 'admin', '1', 'Admin//Capital/changeStatus/', '资金流水删除', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('239', 'admin', '1', 'Admin//Capital/doposit', '增加保证金', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('240', 'admin', '1', 'Admin//Capital/trim/', '减少保证金', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('241', 'admin', '1', 'Admin//Operate/buy', '买入', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('242', 'admin', '1', 'Admin//AuthManager/group', '修改', '-1', '');
INSERT INTO `ss_auth_rule` VALUES ('243', 'admin', '1', 'Admin//Operate/sell', '卖出', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('244', 'admin', '1', 'Admin//Account/un_deal_list', '未交易的', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('245', 'admin', '1', 'Admin//Account/edit/', '修改', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('246', 'admin', '1', 'Admin//Account/detail/', '明细', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('247', 'admin', '1', 'Admin//Account/winLoss_to_ensure/', '盈亏转本金', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('248', 'admin', '1', 'Admin//Operate/edit/', '修改', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('249', 'admin', '1', 'Admin//Operate/del/', '删除', '1', '');
INSERT INTO `ss_auth_rule` VALUES ('250', 'admin', '1', 'Admin/Capital/doposit/', '增加保证金', '1', '');

-- ----------------------------
-- Table structure for ss_capital_log
-- ----------------------------
DROP TABLE IF EXISTS `ss_capital_log`;
CREATE TABLE `ss_capital_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `ensure_money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '保证金',
  `able_money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '可用资金',
  `happen_money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '发生金额',
  `do_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作时间',
  `deal_code` varchar(255) NOT NULL DEFAULT '' COMMENT '交易编码',
  `member_id` int(10) NOT NULL DEFAULT '0' COMMENT '管理员id',
  `summary_id` int(10) NOT NULL DEFAULT '0' COMMENT '结算流水_id',
  `remarks` varchar(255) NOT NULL DEFAULT '' COMMENT '操作备注',
  `type` tinyint(4) DEFAULT '0' COMMENT '类型  1存入资金 2资金调整  3账户结算  4月底返息',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态  1开启 3删除',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=71 DEFAULT CHARSET=utf8 COMMENT='资金流水表';

-- ----------------------------
-- Records of ss_capital_log
-- ----------------------------
INSERT INTO `ss_capital_log` VALUES ('1', '1', '12.00', '1222.00', '222.00', '21312', '3243254', '1', '0', '', '1', '3');
INSERT INTO `ss_capital_log` VALUES ('2', '1', '2324.00', '423432.00', '234.00', '234234', '4235t45', '1', '0', '', '1', '1');
INSERT INTO `ss_capital_log` VALUES ('7', '1', '111.00', '0.00', '0.00', '0', '', '0', '0', '', '0', '0');
INSERT INTO `ss_capital_log` VALUES ('8', '1', '0.00', '0.00', '0.00', '0', '', '0', '0', '', '0', '0');
INSERT INTO `ss_capital_log` VALUES ('9', '1', '2222.00', '0.00', '0.00', '0', '', '0', '0', '', '0', '0');
INSERT INTO `ss_capital_log` VALUES ('10', '1', '101.00', '101.00', '100.00', '1484137800', 'JY201701112042', '1', '0', 'ww', '1', '1');
INSERT INTO `ss_capital_log` VALUES ('11', '1', '101.00', '101.00', '100.00', '1484137800', 'JY201701112046', '1', '0', 'ss', '1', '1');
INSERT INTO `ss_capital_log` VALUES ('12', '1', '201.00', '10101.00', '100.00', '1484137800', 'JY201701112051', '1', '0', 'ee', '1', '1');
INSERT INTO `ss_capital_log` VALUES ('13', '1', '301.00', '20101.00', '100.00', '1484137860', 'JY201701112052', '1', '0', 'ff', '1', '1');
INSERT INTO `ss_capital_log` VALUES ('14', '1', '201.00', '10101.00', '100.00', '1484141400', 'JY201701112155', '1', '0', 'test', '2', '1');
INSERT INTO `ss_capital_log` VALUES ('15', '1', '101.00', '101.00', '100.00', '1484143532', 'JY201701112206', '1', '0', '33', '2', '1');
INSERT INTO `ss_capital_log` VALUES ('16', '1', '101.10', '0.00', '0.00', '0', '', '1', '0', '', '1', '3');
INSERT INTO `ss_capital_log` VALUES ('17', '1', '201.10', '10111.00', '100.00', '1484228787', 'JY201701122146', '1', '0', '3334', '1', '1');
INSERT INTO `ss_capital_log` VALUES ('18', '1', '201.10', '10000.00', '101.00', '1484228814', 'JY201701122149', '1', '0', '的', '5', '1');
INSERT INTO `ss_capital_log` VALUES ('19', '1', '251.10', '15000.00', '50.00', '1484228948', 'JY201701122150', '1', '0', '元', '1', '1');
INSERT INTO `ss_capital_log` VALUES ('20', '1', '250.00', '14890.00', '1.10', '1484229047', 'JY201701122152', '1', '0', '3334', '2', '1');
INSERT INTO `ss_capital_log` VALUES ('21', '1', '250.00', '14320.00', '570.00', '1484229275', 'JY201701122156', '1', '0', '收', '5', '1');
INSERT INTO `ss_capital_log` VALUES ('22', '2', '100.00', '10000.00', '100.00', '1484465503', 'JY201701151531', '1', '0', '1', '1', '1');
INSERT INTO `ss_capital_log` VALUES ('23', '2', '100.00', '9760.00', '-120.00', '1484465836', 'JY201701151538', '1', '1', '1', '5', '1');
INSERT INTO `ss_capital_log` VALUES ('24', '2', '100.00', '9535.00', '-225.00', '1484467996', 'JY201701151613', '1', '2', '2', '5', '1');
INSERT INTO `ss_capital_log` VALUES ('25', '2', '100.00', '8515.00', '-1020.00', '1484468737', 'JY201701151625', '1', '3', '', '5', '1');
INSERT INTO `ss_capital_log` VALUES ('26', '2', '100.00', '6515.00', '-2000.00', '1484469082', 'JY201701151631', '1', '4', '4', '5', '1');
INSERT INTO `ss_capital_log` VALUES ('27', '2', '100.00', '-16745.00', '-23260.00', '1484479154', 'JY201701151920', '1', '5', '真', '5', '1');
INSERT INTO `ss_capital_log` VALUES ('28', '2', '100.00', '148.20', '148.20', '1484493751', 'JY201701152322', '1', '0', '', '6', '1');
INSERT INTO `ss_capital_log` VALUES ('29', '2', '100.00', '200.00', '200.00', '1484493874', 'JY201701152324', '1', '0', '', '6', '1');
INSERT INTO `ss_capital_log` VALUES ('30', '2', '100.00', '298.80', '98.80', '1484494081', 'JY201701152328', '1', '0', '', '6', '1');
INSERT INTO `ss_capital_log` VALUES ('31', '2', '100.00', '373.80', '75.00', '1484497503', 'JY201701160025', '1', '0', '', '6', '1');
INSERT INTO `ss_capital_log` VALUES ('32', '2', '100.00', '24623.80', '24250.00', '1484570482', 'JY201701162041', '1', '0', '', '6', '1');
INSERT INTO `ss_capital_log` VALUES ('33', '2', '100.00', '21620.80', '-3003.00', '1484570664', 'JY201701162058', '1', '0', '9', '5', '1');
INSERT INTO `ss_capital_log` VALUES ('34', '2', '100.00', '19590.80', '-2030.00', '1484571671', 'JY201701162103', '1', '0', '5', '5', '1');
INSERT INTO `ss_capital_log` VALUES ('35', '2', '100.00', '23590.80', '3963.96', '1484571863', 'JY201701162104', '1', '0', '', '6', '1');
INSERT INTO `ss_capital_log` VALUES ('36', '2', '100.00', '-70339.20', '-93930.00', '1484572518', 'JY201701162119', '1', '0', '正式', '5', '1');
INSERT INTO `ss_capital_log` VALUES ('37', '2', '2060.96', '29660.80', '1000.00', '1484576487', 'JY201701162221', '1', '0', '', '3', '1');
INSERT INTO `ss_capital_log` VALUES ('38', '2', '2160.96', '39660.80', '100.00', '1484576552', 'JY201701162222', '1', '0', '', '1', '1');
INSERT INTO `ss_capital_log` VALUES ('39', '2', '2160.96', '37660.80', '2000.00', '1484643697', 'JY201701171701', '1', '0', '', '7', '1');
INSERT INTO `ss_capital_log` VALUES ('40', '2', '2224.76', '43977.00', '63.80', '1484646783', 'JY201701171753', '1', '0', '', '3', '1');
INSERT INTO `ss_capital_log` VALUES ('41', '4', '10000.00', '100000.00', '10000.00', '1484927470', 'JY201701202351', '7', '0', '', '1', '1');
INSERT INTO `ss_capital_log` VALUES ('42', '4', '10100.00', '101000.00', '100.00', '1484927475', 'JY201701202351', '7', '0', '', '1', '1');
INSERT INTO `ss_capital_log` VALUES ('43', '4', '10000.00', '100000.00', '100.00', '1484927509', 'JY201701202356', '7', '0', '1', '2', '1');
INSERT INTO `ss_capital_log` VALUES ('44', '4', '10000.00', '91979.00', '-8021.00', '1484927854', 'JY201701202359', '7', '0', '', '5', '1');
INSERT INTO `ss_capital_log` VALUES ('45', '4', '10000.00', '81957.00', '-10022.00', '1484928113', 'JY201701210002', '7', '0', '测试', '5', '1');
INSERT INTO `ss_capital_log` VALUES ('46', '4', '10000.00', '91968.32', '10011.32', '1484928183', 'JY201701210003', '7', '0', '', '6', '1');
INSERT INTO `ss_capital_log` VALUES ('47', '4', '10000.00', '112491.87', '20403.29', '1484928286', 'JY201701210004', '7', '0', '', '6', '1');
INSERT INTO `ss_capital_log` VALUES ('48', '4', '20381.29', '205923.48', '10381.29', '1484928318', 'JY201701210005', '7', '0', '', '3', '1');
INSERT INTO `ss_capital_log` VALUES ('49', '4', '20381.29', '236685.58', '30809.87', '1484928396', 'JY201701210006', '7', '0', '', '6', '1');
INSERT INTO `ss_capital_log` VALUES ('50', '4', '53181.48', '531887.29', '32800.19', '1484928403', 'JY201701210006', '7', '0', '', '3', '1');
INSERT INTO `ss_capital_log` VALUES ('51', '4', '0.00', '0.00', '53181.48', '1484996277', 'JY201701211858', '7', '0', '', '2', '1');
INSERT INTO `ss_capital_log` VALUES ('52', '4', '10000.00', '100000.00', '10000.00', '1484996493', 'JY201701211901', '7', '0', '', '1', '1');
INSERT INTO `ss_capital_log` VALUES ('53', '4', '10000.00', '19835.00', '-80165.00', '1484996518', 'JY201701211902', '7', '0', '', '5', '1');
INSERT INTO `ss_capital_log` VALUES ('54', '4', '10000.00', '98650.00', '78815.00', '1484996666', 'JY201701211904', '7', '0', '', '6', '1');
INSERT INTO `ss_capital_log` VALUES ('55', '4', '10000.00', '178130.50', '79464.30', '1484996988', 'JY201701211909', '7', '0', '', '6', '1');
INSERT INTO `ss_capital_log` VALUES ('56', '4', '88114.30', '881159.20', '78114.30', '1484997001', 'JY201701211910', '7', '0', '', '3', '1');
INSERT INTO `ss_capital_log` VALUES ('57', '4', '0.00', '0.00', '88114.30', '1484998834', 'JY201701211940', '7', '0', '', '2', '1');
INSERT INTO `ss_capital_log` VALUES ('58', '4', '100.00', '1000.00', '100.00', '1484998934', 'JY201701211942', '7', '0', '', '1', '1');
INSERT INTO `ss_capital_log` VALUES ('59', '4', '1000.00', '10000.00', '900.00', '1484998947', 'JY201701211942', '7', '0', '', '1', '1');
INSERT INTO `ss_capital_log` VALUES ('60', '4', '1000.00', '-10039.00', '-20039.00', '1484998972', 'JY201701211943', '7', '0', '', '5', '1');
INSERT INTO `ss_capital_log` VALUES ('61', '4', '1000.00', '1780.00', '11819.00', '1485000021', 'JY201701212000', '7', '0', '', '6', '1');
INSERT INTO `ss_capital_log` VALUES ('62', '4', '1000.00', '13624.91', '11844.91', '1485000093', 'JY201701212001', '7', '0', '', '6', '1');
INSERT INTO `ss_capital_log` VALUES ('63', '4', '4624.91', '46249.10', '3624.91', '1485000137', 'JY201701212002', '7', '0', '', '3', '1');
INSERT INTO `ss_capital_log` VALUES ('64', '4', '4624.91', '-304330.90', '-350580.00', '1485006165', 'JY201701212143', '7', '0', '', '5', '1');
INSERT INTO `ss_capital_log` VALUES ('65', '4', '4624.91', '-312349.90', '-8019.00', '1485006190', 'JY201701212143', '7', '0', '', '5', '1');
INSERT INTO `ss_capital_log` VALUES ('66', '4', '4624.91', '-66004.90', '246345.00', '1485006406', 'JY201701212146', '7', '0', '', '6', '1');
INSERT INTO `ss_capital_log` VALUES ('67', '4', '4624.91', '136786.00', '202790.90', '1485007105', 'JY201701212158', '7', '0', '', '6', '1');
INSERT INTO `ss_capital_log` VALUES ('68', '4', '4624.91', '56651.00', '-80135.00', '1485007106', 'JY201701212159', '7', '0', '', '5', '1');
INSERT INTO `ss_capital_log` VALUES ('69', '4', '4624.91', '53640.00', '-3011.00', '1485007197', 'JY201701212201', '7', '0', '', '5', '1');
INSERT INTO `ss_capital_log` VALUES ('70', '4', '4624.91', '63573.14', '9933.14', '1485007354', 'JY201701212202', '7', '0', '', '6', '1');

-- ----------------------------
-- Table structure for ss_category
-- ----------------------------
DROP TABLE IF EXISTS `ss_category`;
CREATE TABLE `ss_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(30) NOT NULL COMMENT '标志',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `list_row` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '列表每页行数',
  `meta_title` varchar(50) NOT NULL DEFAULT '' COMMENT 'SEO的网页标题',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `template_index` varchar(100) NOT NULL DEFAULT '' COMMENT '频道页模板',
  `template_lists` varchar(100) NOT NULL DEFAULT '' COMMENT '列表页模板',
  `template_detail` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑页模板',
  `model` varchar(100) NOT NULL DEFAULT '' COMMENT '列表绑定模型',
  `model_sub` varchar(100) NOT NULL DEFAULT '' COMMENT '子文档绑定模型',
  `type` varchar(100) NOT NULL DEFAULT '' COMMENT '允许发布的内容类型',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `allow_publish` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布内容',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `reply` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许回复',
  `check` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发布的文章是否需要审核',
  `reply_model` varchar(100) NOT NULL DEFAULT '',
  `extend` text COMMENT '扩展设置',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类图标',
  `groups` varchar(255) NOT NULL DEFAULT '' COMMENT '分组定义',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='分类表';

-- ----------------------------
-- Records of ss_category
-- ----------------------------
INSERT INTO `ss_category` VALUES ('1', 'blog', '博客', '0', '0', '10', '', '', '', '', '', '', '', '2,3', '2', '2,1', '0', '0', '1', '0', '0', '1', '', '1379474947', '1382701539', '1', '0', '');
INSERT INTO `ss_category` VALUES ('2', 'default_blog', '默认分类', '1', '1', '10', '', '', '', '', '', '', '', '2,3', '2', '2,1,3', '0', '1', '1', '0', '1', '1', '', '1379475028', '1386839751', '1', '0', '');

-- ----------------------------
-- Table structure for ss_channel
-- ----------------------------
DROP TABLE IF EXISTS `ss_channel`;
CREATE TABLE `ss_channel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '频道ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级频道ID',
  `title` char(30) NOT NULL COMMENT '频道标题',
  `url` char(100) NOT NULL COMMENT '频道连接',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '导航排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `target` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '新窗口打开',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ss_channel
-- ----------------------------
INSERT INTO `ss_channel` VALUES ('1', '0', '首页', 'Index/index', '1', '1379475111', '1379923177', '1', '0');
INSERT INTO `ss_channel` VALUES ('2', '0', '博客', 'Article/index?category=blog', '2', '1379475131', '1379483713', '1', '0');
INSERT INTO `ss_channel` VALUES ('3', '0', '官网', 'http://www.onethink.cn', '3', '1379475154', '1387163458', '1', '0');

-- ----------------------------
-- Table structure for ss_config
-- ----------------------------
DROP TABLE IF EXISTS `ss_config`;
CREATE TABLE `ss_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` text COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ss_config
-- ----------------------------
INSERT INTO `ss_config` VALUES ('1', 'WEB_SITE_TITLE', '1', '网站标题', '1', '', '网站标题前台显示标题', '1378898976', '1379235274', '1', 'OneThink内容管理框架', '0');
INSERT INTO `ss_config` VALUES ('2', 'WEB_SITE_DESCRIPTION', '2', '网站描述', '1', '', '网站搜索引擎描述', '1378898976', '1379235841', '1', 'OneThink内容管理框架', '1');
INSERT INTO `ss_config` VALUES ('3', 'WEB_SITE_KEYWORD', '2', '网站关键字', '1', '', '网站搜索引擎关键字', '1378898976', '1381390100', '1', 'ThinkPHP,OneThink', '8');
INSERT INTO `ss_config` VALUES ('4', 'WEB_SITE_CLOSE', '4', '关闭站点', '1', '0:关闭,1:开启', '站点关闭后其他用户不能访问，管理员可以正常访问', '1378898976', '1379235296', '1', '1', '1');
INSERT INTO `ss_config` VALUES ('9', 'CONFIG_TYPE_LIST', '3', '配置类型列表', '4', '', '主要用于数据解析和页面表单的生成', '1378898976', '1379235348', '1', '0:数字\r\n1:字符\r\n2:文本\r\n3:数组\r\n4:枚举', '2');
INSERT INTO `ss_config` VALUES ('10', 'WEB_SITE_ICP', '1', '网站备案号', '1', '', '设置在网站底部显示的备案号，如“沪ICP备12007941号-2', '1378900335', '1379235859', '1', '', '9');
INSERT INTO `ss_config` VALUES ('11', 'DOCUMENT_POSITION', '3', '文档推荐位', '2', '', '文档推荐位，推荐到多个位置KEY值相加即可', '1379053380', '1379235329', '1', '1:列表推荐\r\n2:频道推荐\r\n4:首页推荐', '3');
INSERT INTO `ss_config` VALUES ('12', 'DOCUMENT_DISPLAY', '3', '文档可见性', '2', '', '文章可见性仅影响前台显示，后台不收影响', '1379056370', '1379235322', '1', '0:所有人可见\r\n1:仅注册会员可见\r\n2:仅管理员可见', '4');
INSERT INTO `ss_config` VALUES ('13', 'COLOR_STYLE', '4', '后台色系', '1', 'default_color:默认\r\nblue_color:紫罗兰', '后台颜色风格', '1379122533', '1379235904', '1', 'default_color', '10');
INSERT INTO `ss_config` VALUES ('20', 'CONFIG_GROUP_LIST', '3', '配置分组', '4', '', '配置分组', '1379228036', '1384418383', '1', '1:基本\r\n2:内容\r\n3:用户\r\n4:系统', '4');
INSERT INTO `ss_config` VALUES ('21', 'HOOKS_TYPE', '3', '钩子的类型', '4', '', '类型 1-用于扩展显示内容，2-用于扩展业务处理', '1379313397', '1379313407', '1', '1:视图\r\n2:控制器', '6');
INSERT INTO `ss_config` VALUES ('22', 'AUTH_CONFIG', '3', 'Auth配置', '4', '', '自定义Auth.class.php类配置', '1379409310', '1379409564', '1', 'AUTH_ON:1\r\nAUTH_TYPE:2', '8');
INSERT INTO `ss_config` VALUES ('23', 'OPEN_DRAFTBOX', '4', '是否开启草稿功能', '2', '0:关闭草稿功能\r\n1:开启草稿功能\r\n', '新增文章时的草稿功能配置', '1379484332', '1379484591', '1', '1', '1');
INSERT INTO `ss_config` VALUES ('24', 'DRAFT_AOTOSAVE_INTERVAL', '0', '自动保存草稿时间', '2', '', '自动保存草稿的时间间隔，单位：秒', '1379484574', '1386143323', '1', '60', '2');
INSERT INTO `ss_config` VALUES ('25', 'LIST_ROWS', '0', '后台每页记录数', '2', '', '后台数据每页显示记录数', '1379503896', '1380427745', '1', '10', '10');
INSERT INTO `ss_config` VALUES ('26', 'USER_ALLOW_REGISTER', '4', '是否允许用户注册', '3', '0:关闭注册\r\n1:允许注册', '是否开放用户注册', '1379504487', '1379504580', '1', '1', '3');
INSERT INTO `ss_config` VALUES ('27', 'CODEMIRROR_THEME', '4', '预览插件的CodeMirror主题', '4', '3024-day:3024 day\r\n3024-night:3024 night\r\nambiance:ambiance\r\nbase16-dark:base16 dark\r\nbase16-light:base16 light\r\nblackboard:blackboard\r\ncobalt:cobalt\r\neclipse:eclipse\r\nelegant:elegant\r\nerlang-dark:erlang-dark\r\nlesser-dark:lesser-dark\r\nmidnight:midnight', '详情见CodeMirror官网', '1379814385', '1384740813', '1', 'ambiance', '3');
INSERT INTO `ss_config` VALUES ('28', 'DATA_BACKUP_PATH', '1', '数据库备份根路径', '4', '', '路径必须以 / 结尾', '1381482411', '1381482411', '1', './Data/', '5');
INSERT INTO `ss_config` VALUES ('29', 'DATA_BACKUP_PART_SIZE', '0', '数据库备份卷大小', '4', '', '该值用于限制压缩后的分卷最大长度。单位：B；建议设置20M', '1381482488', '1381729564', '1', '20971520', '7');
INSERT INTO `ss_config` VALUES ('30', 'DATA_BACKUP_COMPRESS', '4', '数据库备份文件是否启用压缩', '4', '0:不压缩\r\n1:启用压缩', '压缩备份文件需要PHP环境支持gzopen,gzwrite函数', '1381713345', '1381729544', '1', '1', '9');
INSERT INTO `ss_config` VALUES ('31', 'DATA_BACKUP_COMPRESS_LEVEL', '4', '数据库备份文件压缩级别', '4', '1:普通\r\n4:一般\r\n9:最高', '数据库备份文件的压缩级别，该配置在开启压缩时生效', '1381713408', '1381713408', '1', '9', '10');
INSERT INTO `ss_config` VALUES ('32', 'DEVELOP_MODE', '4', '开启开发者模式', '4', '0:关闭\r\n1:开启', '是否开启开发者模式', '1383105995', '1383291877', '1', '1', '11');
INSERT INTO `ss_config` VALUES ('33', 'ALLOW_VISIT', '3', '不受限控制器方法', '0', '', '', '1386644047', '1386644741', '1', '0:article/draftbox\r\n1:article/mydocument\r\n2:Category/tree\r\n3:Index/verify\r\n4:file/upload\r\n5:file/download\r\n6:user/updatePassword\r\n7:user/updateNickname\r\n8:user/submitPassword\r\n9:user/submitNickname\r\n10:file/uploadpicture', '0');
INSERT INTO `ss_config` VALUES ('34', 'DENY_VISIT', '3', '超管专限控制器方法', '0', '', '仅超级管理员可访问的控制器方法', '1386644141', '1386644659', '1', '0:Addons/addhook\r\n1:Addons/edithook\r\n2:Addons/delhook\r\n3:Addons/updateHook\r\n4:Admin/getMenus\r\n5:Admin/recordList\r\n6:AuthManager/updateRules\r\n7:AuthManager/tree', '0');
INSERT INTO `ss_config` VALUES ('35', 'REPLY_LIST_ROWS', '0', '回复列表每页条数', '2', '', '', '1386645376', '1387178083', '1', '10', '0');
INSERT INTO `ss_config` VALUES ('36', 'ADMIN_ALLOW_IP', '2', '后台允许访问IP', '4', '', '多个用逗号分隔，如果不配置表示不限制IP访问', '1387165454', '1387165553', '1', '', '12');
INSERT INTO `ss_config` VALUES ('37', 'SHOW_PAGE_TRACE', '4', '是否显示页面Trace', '4', '0:关闭\r\n1:开启', '是否显示页面Trace信息', '1387165685', '1387165685', '1', '0', '1');
INSERT INTO `ss_config` VALUES ('38', 'STAMP_DUTY_RATE', '0', '印花税税率', '0', '卖出采收，成交金额*印花税税率', '', '1484813310', '1484817230', '1', '0.001', '0');
INSERT INTO `ss_config` VALUES ('39', 'STAMP_DUTY_MIN', '0', '印花税最低额度', '0', '', '印花税最低额度', '1484813385', '1484817207', '1', '5', '0');
INSERT INTO `ss_config` VALUES ('40', 'TRANSFER_FEE_RATE', '0', '过户费费率', '0', '', '没一千股1元。交易数量*0.001就行', '1484815787', '1484817198', '1', '0.001', '0');
INSERT INTO `ss_config` VALUES ('41', 'TRANSFER_FEE_MIN', '0', '过户费最低额度', '0', '过户费最低额度', '', '1484815840', '1484817149', '1', '1', '0');
INSERT INTO `ss_config` VALUES ('42', 'ENTRUST_FEE_RATE', '3', '委托费费率', '0', '', '上交每笔委托费5元，深交每笔1元', '1484817131', '1484817677', '1', '5\r\n1', '0');
INSERT INTO `ss_config` VALUES ('43', 'COMMISSION_MIN', '0', '佣金最低金额', '0', '', '', '1484818280', '1484818280', '1', '5', '0');

-- ----------------------------
-- Table structure for ss_deal_log
-- ----------------------------
DROP TABLE IF EXISTS `ss_deal_log`;
CREATE TABLE `ss_deal_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `shares_code` varchar(255) NOT NULL DEFAULT '0' COMMENT '股票代码',
  `shares_name` varchar(255) NOT NULL DEFAULT '0' COMMENT '股票名称',
  `do_type` tinyint(4) DEFAULT '0' COMMENT '类型  0未知  1买入  2卖出',
  `market_type` tinyint(4) DEFAULT '0' COMMENT '类型 0未知   1深市  2沪市',
  `deal_amount` int(11) NOT NULL DEFAULT '0' COMMENT '成交数量',
  `able_sell_amount` int(11) NOT NULL DEFAULT '0' COMMENT '可卖数量',
  `deal_price` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '成交均价',
  `stamp_duty` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '印花税',
  `transfer_fee` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '过户费',
  `entrust_fee` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '委托费',
  `commission` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '佣金',
  `deal_money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '成交金额',
  `deal_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '交易时间',
  `occupy_money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '占用资金',
  `member_id` int(10) NOT NULL DEFAULT '0' COMMENT '管理员id',
  `summary_id` int(10) NOT NULL DEFAULT '0' COMMENT '结算流水_id',
  `sell_status` int(10) NOT NULL DEFAULT '1' COMMENT '是否卖出  1未卖出 2已卖出   3卖出登记',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态  1开启 3删除',
  `remarks` varchar(255) NOT NULL DEFAULT '' COMMENT '操作备注',
  `is_account` tinyint(4) NOT NULL DEFAULT '2' COMMENT '证券账户 1有 2无',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='交易流水表';

-- ----------------------------
-- Records of ss_deal_log
-- ----------------------------
INSERT INTO `ss_deal_log` VALUES ('1', '1', '0323', '林南科技', '1', '1', '1', '1', '12.00', '23.00', '11.00', '1.00', '2.00', '2.00', '1294967295', '0.00', '2', '0', '1', '1', '', '2');
INSERT INTO `ss_deal_log` VALUES ('7', '1', '123456', '中石化', '1', '2', '10', '10', '10.10', '5.00', '3.00', '1.00', '1.00', '101.00', '1484228814', '0.00', '1', '0', '1', '1', '的', '2');
INSERT INTO `ss_deal_log` VALUES ('8', '1', '123456', '中石化', '1', '2', '4800', '4800', '0.10', '30.00', '40.00', '10.00', '10.00', '480.00', '1484229275', '0.00', '1', '0', '1', '1', '收', '2');
INSERT INTO `ss_deal_log` VALUES ('9', '2', '123456', '银豆', '1', '1', '100', '0', '1.10', '0.00', '0.00', '10.00', '0.00', '110.00', '1484465836', '0.00', '1', '1', '2', '1', '1', '2');
INSERT INTO `ss_deal_log` VALUES ('10', '2', '123456', '银豆', '1', '1', '200', '0', '1.00', '12.00', '0.00', '13.00', '0.00', '200.00', '1484467996', '0.00', '1', '2', '2', '1', '2', '2');
INSERT INTO `ss_deal_log` VALUES ('11', '2', '123456', '银豆', '1', '1', '100', '0', '10.10', '0.00', '0.00', '10.00', '0.00', '1010.00', '1484468737', '0.00', '1', '3', '2', '1', '', '2');
INSERT INTO `ss_deal_log` VALUES ('12', '2', '1234567', '中石化', '1', '1', '2000', '0', '1.00', '0.00', '0.00', '0.00', '0.00', '2000.00', '1484469082', '0.00', '1', '4', '2', '1', '4', '2');
INSERT INTO `ss_deal_log` VALUES ('13', '2', '000411', '英特集团', '1', '1', '1000', '0', '23.25', '0.00', '0.00', '10.00', '0.00', '23250.00', '1484479154', '0.00', '1', '5', '2', '1', '真', '2');
INSERT INTO `ss_deal_log` VALUES ('20', '2', '000411', '英特集团', '2', '1', '1000', '1000', '24.25', '0.00', '0.00', '0.00', '0.00', '24250.00', '1484570467', '0.00', '1', '5', '3', '1', '真', '2');
INSERT INTO `ss_deal_log` VALUES ('14', '2', '1234567', '中石化', '2', '1', '2000', '2000', '2.00', '0.00', '0.00', '0.00', '0.00', '4000.00', '1484492589', '0.00', '1', '4', '3', '1', '4', '2');
INSERT INTO `ss_deal_log` VALUES ('15', '2', '123456', '银豆', '2', '1', '100', '100', '2.00', '0.00', '0.00', '0.00', '0.00', '200.00', '1484492649', '0.00', '1', '3', '3', '1', '', '2');
INSERT INTO `ss_deal_log` VALUES ('17', '2', '123456', '银豆', '2', '1', '100', '100', '2.00', '0.00', '0.00', '0.00', '0.00', '200.00', '1484493851', '0.00', '1', '2', '3', '1', '2', '2');
INSERT INTO `ss_deal_log` VALUES ('19', '2', '123456', '银豆', '2', '1', '50', '50', '1.50', '0.00', '0.00', '0.00', '0.00', '75.00', '1484497487', '0.00', '1', '1', '3', '1', '1', '2');
INSERT INTO `ss_deal_log` VALUES ('16', '2', '123456', '银豆', '2', '1', '100', '200', '1.50', '0.00', '0.00', '0.00', '0.00', '150.00', '1484493712', '0.00', '1', '2', '3', '1', '2', '2');
INSERT INTO `ss_deal_log` VALUES ('18', '2', '123456', '银豆', '2', '1', '50', '100', '2.00', '0.00', '0.00', '0.00', '0.00', '100.00', '1484494071', '0.00', '1', '1', '3', '1', '1', '2');
INSERT INTO `ss_deal_log` VALUES ('21', '2', '000511', '大疆无人机', '1', '1', '1000', '0', '3.00', '0.00', '0.00', '3.00', '0.00', '3000.00', '1484570664', '0.00', '1', '6', '2', '1', '9', '2');
INSERT INTO `ss_deal_log` VALUES ('23', '2', '000511', '大疆无人机', '2', '1', '1000', '1000', '4.00', '0.00', '0.00', '0.00', '0.00', '4000.00', '1484571829', '0.00', '1', '6', '3', '1', '9', '2');
INSERT INTO `ss_deal_log` VALUES ('22', '2', '000611', '阿里', '1', '1', '2000', '2000', '1.00', '0.00', '0.00', '30.00', '0.00', '2000.00', '1484571671', '0.00', '1', '7', '1', '1', '5', '2');
INSERT INTO `ss_deal_log` VALUES ('24', '2', '300219', '鸿利智汇', '1', '1', '8000', '8000', '11.74', '0.00', '0.00', '10.00', '0.00', '93920.00', '1484572518', '0.00', '1', '8', '1', '1', '正式', '2');
INSERT INTO `ss_deal_log` VALUES ('25', '4', '600712', '南宁百货', '1', '2', '4000', '0', '2.00', '0.00', '4.00', '5.00', '12.00', '8000.00', '1484927855', '0.00', '7', '9', '2', '1', '', '2');
INSERT INTO `ss_deal_log` VALUES ('26', '4', '600712', '南宁百货', '1', '2', '2000', '0', '5.00', '0.00', '2.00', '5.00', '15.00', '10000.00', '1484928113', '0.00', '7', '10', '2', '1', '测试', '2');
INSERT INTO `ss_deal_log` VALUES ('27', '4', '600712', '南宁百货', '2', '2', '1000', '4000', '10.29', '10.29', '1.00', '5.00', '15.44', '10290.00', '1484928159', '8021.00', '7', '9', '3', '1', '', '2');
INSERT INTO `ss_deal_log` VALUES ('28', '4', '600712', '南宁百货', '2', '2', '2000', '2000', '10.29', '20.58', '2.00', '5.00', '30.87', '20580.00', '1484928206', '10022.00', '7', '10', '3', '1', '测试', '2');
INSERT INTO `ss_deal_log` VALUES ('29', '4', '600712', '南宁百货', '2', '2', '3000', '3000', '10.29', '41.16', '4.00', '5.00', '61.74', '30870.00', '1484928375', '-1990.32', '7', '9', '3', '1', '', '2');
INSERT INTO `ss_deal_log` VALUES ('30', '4', '600712', '南宁百货	2', '1', '2', '40000', '0', '2.00', '0.00', '40.00', '5.00', '120.00', '80000.00', '1484996518', '0.00', '7', '11', '2', '1', '', '2');
INSERT INTO `ss_deal_log` VALUES ('31', '4', '600712', '南宁百货	2', '2', '2', '20000', '40000', '4.00', '80.00', '20.00', '5.00', '120.00', '80000.00', '1484996554', '80165.00', '7', '11', '3', '1', '', '2');
INSERT INTO `ss_deal_log` VALUES ('32', '4', '600712', '南宁百货	2', '2', '2', '20000', '20000', '4.00', '160.00', '40.00', '5.00', '240.00', '80000.00', '1484996798', '1350.00', '7', '11', '3', '1', '', '2');
INSERT INTO `ss_deal_log` VALUES ('33', '4', '600712', '南宁百货3', '1', '2', '4000', '0', '5.00', '0.00', '4.00', '5.00', '30.00', '20000.00', '1484998972', '0.00', '7', '12', '2', '1', '', '2');
INSERT INTO `ss_deal_log` VALUES ('34', '4', '600712', '南宁百货3', '2', '2', '2000', '4000', '6.00', '12.00', '2.00', '5.00', '18.00', '12000.00', '1485000007', '20039.00', '7', '12', '3', '1', '', '2');
INSERT INTO `ss_deal_log` VALUES ('35', '4', '600712', '南宁百货3', '2', '2', '2000', '2000', '6.00', '12.00', '4.00', '5.00', '36.00', '12000.00', '1485000082', '8220.00', '7', '12', '3', '1', '', '2');
INSERT INTO `ss_deal_log` VALUES ('36', '4', '600712', '南宁百货4', '1', '2', '50000', '5000', '7.00', '0.00', '50.00', '5.00', '525.00', '350000.00', '1485006165', '0.00', '7', '13', '1', '1', '', '2');
INSERT INTO `ss_deal_log` VALUES ('37', '4', '600712', '南宁百货5', '1', '2', '2000', '2000', '4.00', '0.00', '2.00', '5.00', '12.00', '8000.00', '1485006190', '8019.00', '7', '14', '1', '1', '', '2');
INSERT INTO `ss_deal_log` VALUES ('38', '4', '600712', '南宁百货4', '2', '2', '25000', '50000', '10.00', '250.00', '25.00', '5.00', '375.00', '250000.00', '1485006233', '350580.00', '7', '13', '3', '1', '', '2');
INSERT INTO `ss_deal_log` VALUES ('39', '4', '600712', '南宁百货4', '2', '2', '20000', '25000', '10.29', '205.80', '20.00', '5.00', '308.70', '205800.00', '1485007021', '104235.00', '7', '13', '3', '1', '', '2');
INSERT INTO `ss_deal_log` VALUES ('40', '4', '600712', '南宁百货6', '1', '2', '10000', '10000', '8.00', '0.00', '10.00', '5.00', '120.00', '80000.00', '1485007106', '80135.00', '7', '15', '1', '1', '', '2');
INSERT INTO `ss_deal_log` VALUES ('41', '4', '600712', '南宁百货7', '1', '2', '1000', '0', '3.00', '0.00', '1.00', '5.00', '5.00', '3000.00', '1485007197', '0.00', '7', '16', '2', '1', '', '2');
INSERT INTO `ss_deal_log` VALUES ('42', '4', '600712', '南宁百货7', '2', '2', '1000', '1000', '10.00', '10.00', '1.00', '5.00', '15.00', '10000.00', '1485007314', '3011.00', '7', '16', '3', '1', '', '2');

-- ----------------------------
-- Table structure for ss_document
-- ----------------------------
DROP TABLE IF EXISTS `ss_document`;
CREATE TABLE `ss_document` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `name` char(40) NOT NULL DEFAULT '' COMMENT '标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '标题',
  `category_id` int(10) unsigned NOT NULL COMMENT '所属分类',
  `group_id` smallint(3) unsigned NOT NULL COMMENT '所属分组',
  `description` char(140) NOT NULL DEFAULT '' COMMENT '描述',
  `root` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '根节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属ID',
  `model_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容模型ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '2' COMMENT '内容类型',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '推荐位',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '封面',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '可见性',
  `deadline` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '截至时间',
  `attach` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件数量',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `comment` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '扩展统计字段',
  `level` int(10) NOT NULL DEFAULT '0' COMMENT '优先级',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  PRIMARY KEY (`id`),
  KEY `idx_category_status` (`category_id`,`status`),
  KEY `idx_status_type_pid` (`status`,`uid`,`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='文档模型基础表';

-- ----------------------------
-- Records of ss_document
-- ----------------------------
INSERT INTO `ss_document` VALUES ('1', '1', '', 'OneThink1.1开发版发布', '2', '0', '期待已久的OneThink最新版发布', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '8', '0', '0', '0', '1406001413', '1406001413', '1');

-- ----------------------------
-- Table structure for ss_document_article
-- ----------------------------
DROP TABLE IF EXISTS `ss_document_article`;
CREATE TABLE `ss_document_article` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '文章内容',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `bookmark` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型文章表';

-- ----------------------------
-- Records of ss_document_article
-- ----------------------------
INSERT INTO `ss_document_article` VALUES ('1', '0', '<h1>\r\n	OneThink1.1开发版发布&nbsp;\r\n</h1>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	主要特性：\r\n</h2>\r\n<p>\r\n	1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n	2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n	3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n	4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n	5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n	6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n	7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n	8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n	9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	后台主要功能：\r\n</h2>\r\n<p>\r\n	1. 用户Passport系统\r\n</p>\r\n<p>\r\n	2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n	3. 权限控制系统\r\n</p>\r\n<p>\r\n	4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n	5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n	6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n	7. 钩子和插件系统\r\n</p>\r\n<p>\r\n	8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n	9. 数据备份和还原\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ 官方下载：&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink开发团队 2013~2014</strong> \r\n</p>', '', '0');

-- ----------------------------
-- Table structure for ss_document_download
-- ----------------------------
DROP TABLE IF EXISTS `ss_document_download`;
CREATE TABLE `ss_document_download` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '下载详细描述',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `file_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型下载表';

-- ----------------------------
-- Records of ss_document_download
-- ----------------------------

-- ----------------------------
-- Table structure for ss_file
-- ----------------------------
DROP TABLE IF EXISTS `ss_file`;
CREATE TABLE `ss_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '原始文件名',
  `savename` char(20) NOT NULL DEFAULT '' COMMENT '保存名称',
  `savepath` char(30) NOT NULL DEFAULT '' COMMENT '文件保存路径',
  `ext` char(5) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `mime` char(40) NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `location` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文件保存位置',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '远程地址',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_md5` (`md5`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文件表';

-- ----------------------------
-- Records of ss_file
-- ----------------------------

-- ----------------------------
-- Table structure for ss_hooks
-- ----------------------------
DROP TABLE IF EXISTS `ss_hooks`;
CREATE TABLE `ss_hooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` text COMMENT '描述',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `addons` varchar(255) NOT NULL DEFAULT '' COMMENT '钩子挂载的插件 ''，''分割',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ss_hooks
-- ----------------------------
INSERT INTO `ss_hooks` VALUES ('1', 'pageHeader', '页面header钩子，一般用于加载插件CSS文件和代码', '1', '0', '', '1');
INSERT INTO `ss_hooks` VALUES ('2', 'pageFooter', '页面footer钩子，一般用于加载插件JS文件和JS代码', '1', '0', 'ReturnTop', '1');
INSERT INTO `ss_hooks` VALUES ('3', 'documentEditForm', '添加编辑表单的 扩展内容钩子', '1', '0', 'Attachment', '1');
INSERT INTO `ss_hooks` VALUES ('4', 'documentDetailAfter', '文档末尾显示', '1', '0', 'Attachment,SocialComment', '1');
INSERT INTO `ss_hooks` VALUES ('5', 'documentDetailBefore', '页面内容前显示用钩子', '1', '0', '', '1');
INSERT INTO `ss_hooks` VALUES ('6', 'documentSaveComplete', '保存文档数据后的扩展钩子', '2', '0', 'Attachment', '1');
INSERT INTO `ss_hooks` VALUES ('7', 'documentEditFormContent', '添加编辑表单的内容显示钩子', '1', '0', 'Editor', '1');
INSERT INTO `ss_hooks` VALUES ('8', 'adminArticleEdit', '后台内容编辑页编辑器', '1', '1378982734', 'EditorForAdmin', '1');
INSERT INTO `ss_hooks` VALUES ('13', 'AdminIndex', '首页小格子个性化显示', '1', '1382596073', 'SiteStat,SystemInfo,DevTeam', '1');
INSERT INTO `ss_hooks` VALUES ('14', 'topicComment', '评论提交方式扩展钩子。', '1', '1380163518', 'Editor', '1');
INSERT INTO `ss_hooks` VALUES ('16', 'app_begin', '应用开始', '2', '1384481614', '', '1');

-- ----------------------------
-- Table structure for ss_member
-- ----------------------------
DROP TABLE IF EXISTS `ss_member`;
CREATE TABLE `ss_member` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `nickname` char(16) NOT NULL DEFAULT '' COMMENT '昵称',
  `sales_id` int(10) NOT NULL DEFAULT '0' COMMENT '营业部id',
  `yonjin_rate` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '佣金提成比例(%)',
  `lixi_rate` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '利息提成比例（%）',
  `yonjin_money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '佣金收入',
  `lixi_money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '利息收入',
  `total_money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '总收入',
  `telephone` char(11) NOT NULL DEFAULT '1' COMMENT '手机号',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `login` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `sort` int(11) NOT NULL DEFAULT '1' COMMENT '排序',
  `level` tinyint(2) NOT NULL DEFAULT '3' COMMENT '级别  1为超级管理员   2为营业部主管  3普通业务员',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '会员状态 0禁用  1开启',
  PRIMARY KEY (`uid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of ss_member
-- ----------------------------
INSERT INTO `ss_member` VALUES ('1', 'admin', '1', '2.00', '2.00', '0.00', '0.00', '0.00', '2', '1', '22', '0', '1483858373', '2130706433', '1484994411', '666', '1', '1');
INSERT INTO `ss_member` VALUES ('2', 'jack', '1', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '0', '5', '0', '0', '2130706433', '1484994754', '1', '2', '1');
INSERT INTO `ss_member` VALUES ('5', 'test', '1', '1.00', '2.00', '0.00', '0.00', '0.00', '3', '1', '2', '0', '0', '2130706433', '1484918605', '0', '3', '1');
INSERT INTO `ss_member` VALUES ('6', 'test24', '8', '2.00', '24.03', '0.00', '0.00', '0.00', '2', '1', '0', '0', '0', '0', '0', '0', '3', '0');
INSERT INTO `ss_member` VALUES ('7', '颐和园', '8', '1.00', '1.00', '0.00', '0.00', '0.00', '18064516571', '1', '10', '0', '0', '2130706433', '1485001068', '1', '3', '1');

-- ----------------------------
-- Table structure for ss_menu
-- ----------------------------
DROP TABLE IF EXISTS `ss_menu`;
CREATE TABLE `ss_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `is_dev` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否仅开发者模式可见',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=157 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ss_menu
-- ----------------------------
INSERT INTO `ss_menu` VALUES ('1', '首页', '0', '1', 'Index/index', '1', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('3', '文档列表', '2', '0', 'article/index', '1', '', '内容', '0', '1');
INSERT INTO `ss_menu` VALUES ('4', '新增', '3', '0', 'article/add', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('5', '编辑', '3', '0', 'article/edit', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('6', '改变状态', '3', '0', 'article/setStatus', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('7', '保存', '3', '0', 'article/update', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('8', '保存草稿', '3', '0', 'article/autoSave', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('9', '移动', '3', '0', 'article/move', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('10', '复制', '3', '0', 'article/copy', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('11', '粘贴', '3', '0', 'article/paste', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('12', '导入', '3', '0', 'article/batchOperate', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('13', '回收站', '2', '0', 'article/recycle', '1', '', '内容', '0', '1');
INSERT INTO `ss_menu` VALUES ('14', '还原', '13', '0', 'article/permit', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('15', '清空', '13', '0', 'article/clear', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('16', '账户', '0', '2', 'User/index', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('17', '业务员信息', '16', '3', 'User/index', '0', '', '营业管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('18', '新增用户', '17', '0', 'User/add', '0', '添加新用户', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('19', '用户行为', '16', '5', 'User/action', '1', '', '行为管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('20', '新增用户行为', '19', '0', 'User/addaction', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('21', '编辑用户行为', '19', '0', 'User/editaction', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('22', '保存用户行为', '19', '0', 'User/saveAction', '0', '\"用户->用户行为\"保存编辑和新增的用户行为', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('23', '变更行为状态', '19', '0', 'User/setStatus', '0', '\"用户->用户行为\"中的启用,禁用和删除权限', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('24', '禁用会员', '19', '0', 'User/changeStatus?method=forbidUser', '0', '\"用户->用户信息\"中的禁用', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('25', '启用会员', '19', '0', 'User/changeStatus?method=resumeUser', '0', '\"用户->用户信息\"中的启用', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('26', '删除会员', '19', '0', 'User/changeStatus?method=deleteUser', '0', '\"用户->用户信息\"中的删除', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('27', '权限管理', '16', '4', 'AuthManager/index', '0', '', '营业管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('28', '删除', '27', '0', 'AuthManager/changeStatus?method=deleteGroup', '0', '删除用户组', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('29', '禁用', '27', '0', 'AuthManager/changeStatus?method=forbidGroup', '0', '禁用用户组', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('30', '恢复', '27', '0', 'AuthManager/changeStatus?method=resumeGroup', '0', '恢复已禁用的用户组', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('31', '新增', '27', '0', 'AuthManager/createGroup', '0', '创建新的用户组', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('32', '编辑', '27', '0', 'AuthManager/editGroup', '0', '编辑用户组名称和描述', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('33', '保存用户组', '27', '0', 'AuthManager/writeGroup', '0', '新增和编辑用户组的\"保存\"按钮', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('34', '授权', '27', '0', 'AuthManager/group', '0', '\"后台 \\ 用户 \\ 用户信息\"列表页的\"授权\"操作按钮,用于设置用户所属用户组', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('35', '访问授权', '27', '0', 'AuthManager/access', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"访问授权\"操作按钮', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('36', '成员授权', '27', '0', 'AuthManager/user', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"成员授权\"操作按钮', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('37', '解除授权', '27', '0', 'AuthManager/removeFromGroup', '0', '\"成员授权\"列表页内的解除授权操作按钮', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('38', '保存成员授权', '27', '0', 'AuthManager/addToGroup', '0', '\"用户信息\"列表页\"授权\"时的\"保存\"按钮和\"成员授权\"里右上角的\"添加\"按钮)', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('39', '分类授权', '27', '0', 'AuthManager/category', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"分类授权\"操作按钮', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('40', '保存分类授权', '27', '0', 'AuthManager/addToCategory', '0', '\"分类授权\"页面的\"保存\"按钮', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('41', '模型授权', '27', '0', 'AuthManager/modelauth', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"模型授权\"操作按钮', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('42', '保存模型授权', '27', '0', 'AuthManager/addToModel', '0', '\"分类授权\"页面的\"保存\"按钮', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('139', '营业部修改', '128', '0', '/User/sales_edit/', '1', '', '营业部管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('44', '插件管理', '43', '1', 'Addons/index', '0', '', '扩展', '0', '1');
INSERT INTO `ss_menu` VALUES ('45', '创建', '44', '0', 'Addons/create', '0', '服务器上创建插件结构向导', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('46', '检测创建', '44', '0', 'Addons/checkForm', '0', '检测插件是否可以创建', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('47', '预览', '44', '0', 'Addons/preview', '0', '预览插件定义类文件', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('48', '快速生成插件', '44', '0', 'Addons/build', '0', '开始生成插件结构', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('49', '设置', '44', '0', 'Addons/config', '0', '设置插件配置', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('50', '禁用', '44', '0', 'Addons/disable', '0', '禁用插件', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('51', '启用', '44', '0', 'Addons/enable', '0', '启用插件', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('52', '安装', '44', '0', 'Addons/install', '0', '安装插件', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('53', '卸载', '44', '0', 'Addons/uninstall', '0', '卸载插件', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('54', '更新配置', '44', '0', 'Addons/saveconfig', '0', '更新插件配置处理', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('55', '插件后台列表', '44', '0', 'Addons/adminList', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('56', 'URL方式访问插件', '44', '0', 'Addons/execute', '0', '控制是否有权限通过url访问插件控制器方法', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('57', '钩子管理', '43', '2', 'Addons/hooks', '0', '', '扩展', '0', '1');
INSERT INTO `ss_menu` VALUES ('58', '模型管理', '68', '3', 'Model/index', '0', '', '系统设置', '0', '1');
INSERT INTO `ss_menu` VALUES ('59', '新增', '58', '0', 'model/add', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('60', '编辑', '58', '0', 'model/edit', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('61', '改变状态', '58', '0', 'model/setStatus', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('62', '保存数据', '58', '0', 'model/update', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('63', '属性管理', '68', '0', 'Attribute/index', '1', '网站属性配置。', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('64', '新增', '63', '0', 'Attribute/add', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('65', '编辑', '63', '0', 'Attribute/edit', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('66', '改变状态', '63', '0', 'Attribute/setStatus', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('67', '保存数据', '63', '0', 'Attribute/update', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('68', '系统', '0', '8', 'Config/group', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('69', '网站设置', '68', '1', 'Config/group', '0', '', '系统设置', '0', '1');
INSERT INTO `ss_menu` VALUES ('70', '配置管理', '68', '4', 'Config/index', '0', '', '系统设置', '0', '1');
INSERT INTO `ss_menu` VALUES ('71', '编辑', '70', '0', 'Config/edit', '0', '新增编辑和保存配置', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('72', '删除', '70', '0', 'Config/del', '0', '删除配置', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('73', '新增', '70', '0', 'Config/add', '0', '新增配置', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('74', '保存', '70', '0', 'Config/save', '0', '保存配置', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('75', '菜单管理', '68', '5', 'Menu/index', '0', '', '系统设置', '0', '1');
INSERT INTO `ss_menu` VALUES ('76', '导航管理', '68', '6', 'Channel/index', '0', '', '系统设置', '0', '1');
INSERT INTO `ss_menu` VALUES ('77', '新增', '76', '0', 'Channel/add', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('78', '编辑', '76', '0', 'Channel/edit', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('79', '删除', '76', '0', 'Channel/del', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('80', '分类管理', '68', '2', 'Category/index', '0', '', '系统设置', '0', '1');
INSERT INTO `ss_menu` VALUES ('81', '编辑', '80', '0', 'Category/edit', '0', '编辑和保存栏目分类', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('82', '新增', '80', '0', 'Category/add', '0', '新增栏目分类', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('83', '删除', '80', '0', 'Category/remove', '0', '删除栏目分类', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('84', '移动', '80', '0', 'Category/operate/type/move', '0', '移动栏目分类', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('85', '合并', '80', '0', 'Category/operate/type/merge', '0', '合并栏目分类', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('86', '备份数据库', '68', '0', 'Database/index?type=export', '0', '', '数据备份', '0', '1');
INSERT INTO `ss_menu` VALUES ('87', '备份', '86', '0', 'Database/export', '0', '备份数据库', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('88', '优化表', '86', '0', 'Database/optimize', '0', '优化数据表', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('89', '修复表', '86', '0', 'Database/repair', '0', '修复数据表', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('90', '还原数据库', '68', '0', 'Database/index?type=import', '0', '', '数据备份', '0', '1');
INSERT INTO `ss_menu` VALUES ('91', '恢复', '90', '0', 'Database/import', '0', '数据库恢复', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('92', '删除', '90', '0', 'Database/del', '0', '删除备份文件', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('96', '新增', '75', '0', 'Menu/add', '0', '', '系统设置', '0', '1');
INSERT INTO `ss_menu` VALUES ('98', '编辑', '75', '0', 'Menu/edit', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('106', '行为日志', '16', '6', 'Action/actionlog', '1', '', '行为管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('108', '修改密码', '16', '7', 'User/updatePassword', '1', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('109', '修改昵称', '16', '8', 'User/updateNickname', '1', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('110', '查看行为日志', '106', '0', 'action/edit', '1', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('112', '新增数据', '58', '0', 'think/add', '1', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('113', '编辑数据', '58', '0', 'think/edit', '1', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('114', '导入', '75', '0', 'Menu/import', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('115', '生成', '58', '0', 'Model/generate', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('116', '新增钩子', '57', '0', 'Addons/addHook', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('117', '编辑钩子', '57', '0', 'Addons/edithook', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('118', '文档排序', '3', '0', 'Article/sort', '1', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('119', '排序', '70', '0', 'Config/sort', '1', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('120', '排序', '75', '0', 'Menu/sort', '1', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('121', '排序', '76', '0', 'Channel/sort', '1', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('122', '数据列表', '58', '0', 'think/lists', '1', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('123', '审核列表', '3', '0', 'Article/examine', '1', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('124', '账户登记', '16', '1', 'User/user_add', '0', '', '用户管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('125', '账户列表', '16', '2', 'User/user_list', '0', '', '用户管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('128', '营业部列表', '16', '0', 'User/sales_list', '0', '', '营业管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('129', '资金', '0', '3', 'Capital/index', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('130', '交易', '0', '4', 'Operate/index', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('131', '结算', '0', '5', 'Account/index', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('132', '报表', '0', '6', 'Report/index', '0', '', '', '0', '1');
INSERT INTO `ss_menu` VALUES ('133', '盈亏汇总', '132', '0', 'Report/index', '0', '', '报表管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('134', '交易结算清单', '132', '0', 'Report/deal', '0', '', '报表管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('135', '业务员提成', '132', '0', 'Report/layer', '0', '', '报表管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('136', '添加营业部', '128', '0', 'User/sales_add', '1', '', '营业管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('137', '修改资金流水', '129', '0', 'Capital/edit', '0', '', '资金管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('138', '账户修改', '125', '0', '/User/user_edit/', '0', '', '用户管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('140', '营业部删除', '128', '0', '/User/sales_del/', '1', '', '营业部管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('142', '业务员修改', '17', '0', '/User/edit/', '1', '', '业务员信息', '0', '1');
INSERT INTO `ss_menu` VALUES ('143', '业务员状态修改或删除', '17', '0', '/User/changeStatus/', '1', '', '业务员信息', '0', '1');
INSERT INTO `ss_menu` VALUES ('144', '业务员授权', '17', '0', '/AuthManager/group/', '1', '', '业务员信息', '0', '1');
INSERT INTO `ss_menu` VALUES ('145', '账户删除', '125', '0', '/User/user_del/', '1', '', '账户列表', '0', '1');
INSERT INTO `ss_menu` VALUES ('146', '资金流水删除', '129', '0', 'Capital/changeStatus', '0', '', '资金管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('147', '增加保证金', '129', '0', 'Capital/doposit', '1', '', '资金管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('148', '减少保证金', '129', '0', 'Capital/trim', '1', '', '资金管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('149', '买入', '130', '0', '/Operate/buy', '1', '', '交易管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('150', '修改', '130', '0', '/Operate/edit/', '1', '', '交易管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('151', '卖出', '130', '0', '/Operate/sell', '1', '', '交易管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('152', '未交易的', '131', '0', '/Account/un_deal_list', '1', '', '结算管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('153', '修改', '131', '0', '/Account/edit/', '1', '', '结算管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('154', '明细', '131', '0', '/Account/detail/', '1', '', '结算管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('155', '盈亏转本金', '131', '0', '/Account/winLoss_to_ensure/', '1', '', '结算管理', '0', '1');
INSERT INTO `ss_menu` VALUES ('156', '删除', '130', '0', '/Operate/del/', '1', '', '交易管理', '0', '1');

-- ----------------------------
-- Table structure for ss_model
-- ----------------------------
DROP TABLE IF EXISTS `ss_model`;
CREATE TABLE `ss_model` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '模型标识',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '模型名称',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '继承的模型',
  `relation` varchar(30) NOT NULL DEFAULT '' COMMENT '继承与被继承模型的关联字段',
  `need_pk` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '新建表时是否需要主键字段',
  `field_sort` text COMMENT '表单字段排序',
  `field_group` varchar(255) NOT NULL DEFAULT '1:基础' COMMENT '字段分组',
  `attribute_list` text COMMENT '属性列表（表的字段）',
  `attribute_alias` varchar(255) NOT NULL DEFAULT '' COMMENT '属性别名定义',
  `template_list` varchar(100) NOT NULL DEFAULT '' COMMENT '列表模板',
  `template_add` varchar(100) NOT NULL DEFAULT '' COMMENT '新增模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑模板',
  `list_grid` text COMMENT '列表定义',
  `list_row` smallint(2) unsigned NOT NULL DEFAULT '10' COMMENT '列表数据长度',
  `search_key` varchar(50) NOT NULL DEFAULT '' COMMENT '默认搜索字段',
  `search_list` varchar(255) NOT NULL DEFAULT '' COMMENT '高级搜索的字段',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `engine_type` varchar(25) NOT NULL DEFAULT 'MyISAM' COMMENT '数据库引擎',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='文档模型表';

-- ----------------------------
-- Records of ss_model
-- ----------------------------
INSERT INTO `ss_model` VALUES ('1', 'document', '基础文档', '0', '', '1', '{\"1\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"12\",\"13\",\"14\",\"15\",\"16\",\"17\",\"18\",\"19\",\"20\",\"21\",\"22\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\ntitle:标题:[EDIT]\r\ntype:类型\r\nupdate_time:最后更新\r\nstatus:状态\r\nview:浏览\r\nid:操作:[EDIT]|编辑,[DELETE]|删除', '0', '', '', '1383891233', '1384507827', '1', 'MyISAM');
INSERT INTO `ss_model` VALUES ('2', 'article', '文章', '1', '', '1', '{\"1\":[\"3\",\"24\",\"2\",\"5\"],\"2\":[\"9\",\"13\",\"19\",\"10\",\"12\",\"16\",\"17\",\"26\",\"20\",\"14\",\"11\",\"25\"]}', '1:基础,2:扩展', '', '', '', '', '', '', '0', '', '', '1383891243', '1387260622', '1', 'MyISAM');
INSERT INTO `ss_model` VALUES ('3', 'download', '下载', '1', '', '1', '{\"1\":[\"3\",\"28\",\"30\",\"32\",\"2\",\"5\",\"31\"],\"2\":[\"13\",\"10\",\"27\",\"9\",\"12\",\"16\",\"17\",\"19\",\"11\",\"20\",\"14\",\"29\"]}', '1:基础,2:扩展', '', '', '', '', '', '', '0', '', '', '1383891252', '1387260449', '1', 'MyISAM');

-- ----------------------------
-- Table structure for ss_picture
-- ----------------------------
DROP TABLE IF EXISTS `ss_picture`;
CREATE TABLE `ss_picture` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ss_picture
-- ----------------------------

-- ----------------------------
-- Table structure for ss_profit_log
-- ----------------------------
DROP TABLE IF EXISTS `ss_profit_log`;
CREATE TABLE `ss_profit_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `member_id` int(10) NOT NULL DEFAULT '0' COMMENT '业务员id',
  `total_interest` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '利息总额',
  `sales_interest` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '营业部利息收益',
  `ticheng_interest` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '业务员利息收益',
  `total_yongjin` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '利息总额',
  `sales_yongjin` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '营业部利息收益',
  `ticheng_yongjin` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '业务员利息收益',
  `add_time` date NOT NULL COMMENT '插入时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1正常  2禁用',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='利息佣金流水表';

-- ----------------------------
-- Records of ss_profit_log
-- ----------------------------
INSERT INTO `ss_profit_log` VALUES ('1', '4', '7', '2505.73', '0.00', '0.00', '140.00', '0.00', '0.00', '2017-01-21', '1');

-- ----------------------------
-- Table structure for ss_sales
-- ----------------------------
DROP TABLE IF EXISTS `ss_sales`;
CREATE TABLE `ss_sales` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '营业部ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '营业部名称',
  `dali_rate` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '代理利率（单位：毫/天）',
  `yongjin_rate` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '代理佣金费率（单位：%。）',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '负责人',
  `telephone` char(12) NOT NULL DEFAULT '' COMMENT '联系电话',
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '营业部地址',
  `sort` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '排序（同级有效）',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ss_sales
-- ----------------------------
INSERT INTO `ss_sales` VALUES ('1', '营业一部', '8.00', '0.50', '小龙', '13524247685', '厦门湖里区万达写字楼c栋', '4', '2');
INSERT INTO `ss_sales` VALUES ('8', '营业二部', '8.00', '0.50', '小钱', '0596-7254756', '厦门湖里万达', '1', '1');

-- ----------------------------
-- Table structure for ss_summary_log
-- ----------------------------
DROP TABLE IF EXISTS `ss_summary_log`;
CREATE TABLE `ss_summary_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `do_type` tinyint(4) DEFAULT '0' COMMENT '结算方式 0未知 1盈亏转本金  2 盈亏结现',
  `shares_code` varchar(255) NOT NULL DEFAULT '0' COMMENT '股票代码',
  `shares_name` varchar(255) NOT NULL DEFAULT '0' COMMENT '股票名称',
  `buy_money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '买入金额',
  `buy_cost` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '买入费用',
  `sell_money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '卖出金额',
  `sell_cost` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '卖出费用',
  `interest` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '利息',
  `win_loss` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '盈亏金额',
  `sell_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '卖出时间',
  `do_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作时间',
  `member_id` int(10) NOT NULL DEFAULT '0' COMMENT '管理员id',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态  1未结清  2已结清',
  `sell_amount` int(11) NOT NULL DEFAULT '0' COMMENT '卖出数量',
  `sell_deal_price` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '卖出均价',
  `sell_transfer_fee` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '卖出过户费',
  `sell_stamp_duty` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '卖出印花税',
  `sell_entrust_fee` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '卖出委托费',
  `sell_commission` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '卖出佣金',
  `buy_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '买入时间',
  `buy_deal_price` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '买入均价',
  `buy_transfer_fee` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '买入过户费',
  `buy_entrust_fee` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '买入委托费',
  `buy_commission` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '买入佣金',
  `buy_amount` int(11) NOT NULL DEFAULT '0' COMMENT '买入数量',
  `occupy_money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '占用资金',
  `occupy_day` int(5) NOT NULL DEFAULT '0' COMMENT '占用天数',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='结算流水表';

-- ----------------------------
-- Records of ss_summary_log
-- ----------------------------
INSERT INTO `ss_summary_log` VALUES ('1', '2', '1', '123456', '银豆', '110.00', '10.00', '175.00', '0.00', '1.20', '63.80', '2018', '1484646783', '1', '3', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0', '0.00', '0');
INSERT INTO `ss_summary_log` VALUES ('2', '2', '0', '123456', '银豆', '200.00', '25.00', '350.00', '0.00', '1.80', '148.20', '2017', '1484468037', '1', '2', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0', '0.00', '0');
INSERT INTO `ss_summary_log` VALUES ('3', '2', '0', '123456', '银豆', '1010.00', '10.00', '200.00', '0.00', '0.00', '-810.00', '2017', '1484468751', '1', '2', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0', '0.00', '0');
INSERT INTO `ss_summary_log` VALUES ('4', '2', '2', '1234567', '中石化', '2000.00', '0.00', '4000.00', '0.00', '0.00', '2000.00', '2017', '1484643697', '1', '3', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0', '0.00', '0');
INSERT INTO `ss_summary_log` VALUES ('5', '2', '1', '000411', '英特集团', '23250.00', '10.00', '24250.00', '0.00', '0.00', '1000.00', '2017', '1484479215', '1', '3', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0', '0.00', '0');
INSERT INTO `ss_summary_log` VALUES ('6', '2', '1', '000511', '大疆无人机', '3000.00', '3.00', '4000.00', '0.00', '36.04', '960.96', '1484571829', '1484571522', '1', '3', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0', '0.00', '0');
INSERT INTO `ss_summary_log` VALUES ('7', '2', '0', '000611', '阿里', '2000.00', '30.00', '0.00', '0.00', '0.00', '0.00', '0', '1484571828', '1', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0', '0.00', '0');
INSERT INTO `ss_summary_log` VALUES ('8', '2', '0', '300219', '鸿利智汇', '93920.00', '10.00', '0.00', '0.00', '0.00', '0.00', '0', '1484572749', '1', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0', '0.00', '0');
INSERT INTO `ss_summary_log` VALUES ('9', '4', '1', '600712', '南宁百货', '8000.00', '21.00', '41160.00', '139.63', '199.19', '32800.19', '1484928375', '1484928403', '7', '3', '4000', '10.29', '5.00', '51.45', '10.00', '77.18', '1484927854', '2.00', '4.00', '5.00', '12.00', '4000', '8021.00', '0');
INSERT INTO `ss_summary_log` VALUES ('10', '4', '1', '600712', '南宁百货', '10000.00', '22.00', '20580.00', '56.45', '120.26', '10381.29', '1484928206', '1484928318', '7', '3', '2000', '10.29', '2.00', '20.58', '5.00', '30.87', '1484928113', '5.00', '2.00', '5.00', '15.00', '2000', '10022.00', '0');
INSERT INTO `ss_summary_log` VALUES ('11', '4', '1', '600712', '南宁百货	2', '80000.00', '165.00', '160000.00', '744.50', '976.20', '78114.30', '1484996798', '1484997001', '7', '3', '40000', '4.00', '60.00', '240.00', '10.00', '360.00', '1484996518', '2.00', '40.00', '5.00', '120.00', '40000', '80165.00', '0');
INSERT INTO `ss_summary_log` VALUES ('12', '4', '1', '600712', '南宁百货3', '20000.00', '39.00', '24000.00', '93.45', '242.64', '3624.91', '1485000082', '1485000137', '7', '3', '4000', '6.00', '6.00', '24.00', '10.00', '54.00', '1484998972', '5.00', '4.00', '5.00', '30.00', '4000', '20039.00', '0');
INSERT INTO `ss_summary_log` VALUES ('13', '4', '0', '600712', '南宁百货4', '350000.00', '580.00', '455800.00', '1194.50', '5469.60', '134135.90', '1485007021', '1485006188', '7', '1', '45000', '10.29', '45.00', '455.80', '10.00', '683.70', '1485006165', '7.00', '50.00', '5.00', '525.00', '50000', '350580.00', '0');
INSERT INTO `ss_summary_log` VALUES ('14', '4', '0', '600712', '南宁百货5', '8000.00', '19.00', '0.00', '0.00', '0.00', '0.00', '0', '1485006232', '7', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '1485006190', '4.00', '2.00', '5.00', '12.00', '2000', '8019.00', '0');
INSERT INTO `ss_summary_log` VALUES ('15', '4', '0', '600712', '南宁百货6', '80000.00', '135.00', '0.00', '0.00', '0.00', '0.00', '0', '1485007195', '7', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '1485007106', '8.00', '10.00', '5.00', '120.00', '10000', '80135.00', '0');
INSERT INTO `ss_summary_log` VALUES ('16', '4', '0', '600712', '南宁百货7', '3000.00', '11.00', '10000.00', '30.73', '36.13', '6922.14', '1485007314', '1485007354', '7', '2', '1000', '10.00', '1.00', '10.00', '5.00', '15.00', '1485007197', '3.00', '1.00', '5.00', '5.00', '1000', '3011.00', '0');

-- ----------------------------
-- Table structure for ss_ucenter_admin
-- ----------------------------
DROP TABLE IF EXISTS `ss_ucenter_admin`;
CREATE TABLE `ss_ucenter_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `member_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员用户ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '管理员状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of ss_ucenter_admin
-- ----------------------------

-- ----------------------------
-- Table structure for ss_ucenter_app
-- ----------------------------
DROP TABLE IF EXISTS `ss_ucenter_app`;
CREATE TABLE `ss_ucenter_app` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '应用ID',
  `title` varchar(30) NOT NULL COMMENT '应用名称',
  `url` varchar(100) NOT NULL COMMENT '应用URL',
  `ip` char(15) NOT NULL DEFAULT '' COMMENT '应用IP',
  `auth_key` varchar(100) NOT NULL DEFAULT '' COMMENT '加密KEY',
  `sys_login` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '同步登陆',
  `allow_ip` varchar(255) NOT NULL DEFAULT '' COMMENT '允许访问的IP',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '应用状态',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='应用表';

-- ----------------------------
-- Records of ss_ucenter_app
-- ----------------------------

-- ----------------------------
-- Table structure for ss_ucenter_member
-- ----------------------------
DROP TABLE IF EXISTS `ss_ucenter_member`;
CREATE TABLE `ss_ucenter_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(16) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `mobile` char(15) NOT NULL DEFAULT '' COMMENT '用户手机',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) DEFAULT '0' COMMENT '用户状态   0禁用  1开启',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of ss_ucenter_member
-- ----------------------------
INSERT INTO `ss_ucenter_member` VALUES ('1', 'admin', '781cd47811175f59257e48e39888236b', '494044011@qq.com', '2', '1483858373', '2130706433', '1484994411', '2130706433', '1483858373', '1');
INSERT INTO `ss_ucenter_member` VALUES ('2', 'jack', '6ec54e53f6f2f8bdbddd32179d123d4b', '123456@qq.com', '', '1483870797', '2130706433', '1484994754', '2130706433', '1483870797', '1');
INSERT INTO `ss_ucenter_member` VALUES ('5', 'test', '6ec54e53f6f2f8bdbddd32179d123d4b', '', '3', '0', '0', '1484918605', '2130706433', '0', '1');
INSERT INTO `ss_ucenter_member` VALUES ('6', 'test24', '6ec54e53f6f2f8bdbddd32179d123d4b', '', '2', '0', '0', '0', '0', '0', '0');
INSERT INTO `ss_ucenter_member` VALUES ('7', '颐和园', '6ec54e53f6f2f8bdbddd32179d123d4b', '', '18064516571', '0', '0', '1485001068', '2130706433', '0', '1');

-- ----------------------------
-- Table structure for ss_ucenter_setting
-- ----------------------------
DROP TABLE IF EXISTS `ss_ucenter_setting`;
CREATE TABLE `ss_ucenter_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '设置ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型（1-用户配置）',
  `value` text NOT NULL COMMENT '配置数据',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='设置表';

-- ----------------------------
-- Records of ss_ucenter_setting
-- ----------------------------

-- ----------------------------
-- Table structure for ss_url
-- ----------------------------
DROP TABLE IF EXISTS `ss_url`;
CREATE TABLE `ss_url` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '链接唯一标识',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `short` char(100) NOT NULL DEFAULT '' COMMENT '短网址',
  `status` tinyint(2) NOT NULL DEFAULT '2' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_url` (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='链接表';

-- ----------------------------
-- Records of ss_url
-- ----------------------------

-- ----------------------------
-- Table structure for ss_user
-- ----------------------------
DROP TABLE IF EXISTS `ss_user`;
CREATE TABLE `ss_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '账户ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '姓名',
  `ensure_money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '保证金',
  `able_money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '可用资金',
  `pledge` varchar(50) NOT NULL DEFAULT '' COMMENT '质押比例',
  `rate` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '利率',
  `yongjin_rate` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '佣金费率',
  `capital_waring` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '资金预警',
  `flat` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '账户平仓',
  `transfer` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '过户费',
  `return_rate` tinyint(1) NOT NULL DEFAULT '2' COMMENT '月底返息（1 是 2 否）',
  `hand_cost` tinyint(1) NOT NULL DEFAULT '2' COMMENT '手续费用（1 是 2 否）',
  `sales_id` int(10) NOT NULL DEFAULT '0' COMMENT '营业部id',
  `member_id` int(10) NOT NULL DEFAULT '0' COMMENT '业务员id',
  `body_card` char(20) NOT NULL DEFAULT '' COMMENT '身份证',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT '会员邮件',
  `telephone` char(11) NOT NULL DEFAULT '' COMMENT '手机号',
  `birthday` int(11) NOT NULL DEFAULT '0' COMMENT '出生日期',
  `sex` tinyint(1) NOT NULL DEFAULT '1' COMMENT '性别  1 男  2 女',
  `child` tinyint(1) NOT NULL DEFAULT '1' COMMENT '有无子女  1 有  2 无',
  `jiguan` varchar(255) NOT NULL DEFAULT '' COMMENT '籍贯',
  `hukou` varchar(255) NOT NULL DEFAULT '' COMMENT '户口所在地',
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '居住地址',
  `phone` char(12) NOT NULL DEFAULT '' COMMENT '电话',
  `sort` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '排序（同级有效）',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ss_user
-- ----------------------------
INSERT INTO `ss_user` VALUES ('1', 'test', '250.00', '14320.00', '100', '12.00', '1.50', '5.00', '3.00', '1.00', '1', '1', '1', '1', '352648955612487659', '', '18064516574', '0', '1', '1', '##', '##', '', '', '1', '0', '0');
INSERT INTO `ss_user` VALUES ('2', '小龙', '2224.76', '43977.00', '100', '12.00', '1.50', '5.00', '3.00', '1.00', '1', '1', '1', '2', '352619499416584875', '234345@qq.com', '19864598731', '0', '2', '2', '上海市#上海市#黄浦区', '江西省#南昌市#市辖区', '福建华南地区', '19864598731', '1', '0', '1');
INSERT INTO `ss_user` VALUES ('3', '余峰', '0.00', '0.00', '2', '2.00', '3.00', '488888.00', '324789.00', '230.00', '2', '2', '1', '5', '', '', '', '0', '0', '0', '##', '##', '', '', '1', '1484118752', '1');
INSERT INTO `ss_user` VALUES ('4', '王中磊', '4624.91', '63573.14', '10', '12.00', '1.50', '5.00', '3.00', '1.00', '1', '1', '8', '7', '', '', '', '0', '0', '0', '##', '##', '', '', '1', '1484926061', '0');

-- ----------------------------
-- Table structure for ss_userdata
-- ----------------------------
DROP TABLE IF EXISTS `ss_userdata`;
CREATE TABLE `ss_userdata` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `type` tinyint(3) unsigned NOT NULL COMMENT '类型标识',
  `target_id` int(10) unsigned NOT NULL COMMENT '目标id',
  UNIQUE KEY `uid` (`uid`,`type`,`target_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ss_userdata
-- ----------------------------
