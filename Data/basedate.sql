-- 营业部表
CREATE TABLE `ss_sales` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '营业部ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '营业部名称',
  `dali_rate` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '代理利率（单位：毫/天）',
  `yongjin_rate` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '代理佣金费率（单位：%。）',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '负责人',
  `telephone` char(11) NOT NULL DEFAULT '' COMMENT '联系电话',
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '营业部地址',
  `sort` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '排序（同级有效）',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 账户表（用户表）
CREATE TABLE `ss_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '账户ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '姓名',
  `ensure_money` decimal(11,2) not null default 0 comment '保证金',
  `able_money` decimal(11,2) not null default 0 comment '可用资金',
  `pledge` varchar(50) NOT NULL DEFAULT '' COMMENT '质押比例',
  `rate` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '利率',
  `yongjin_rate` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '佣金费率',
  `capital_waring` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '资金预警',
  `flat` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '账户平仓',
  `transfer` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '过户费',
  `return_rate` tinyint(1) NOT NULL DEFAULT 2  COMMENT '月底返息（1 是 2 否）',
  `hand_cost` tinyint(1) NOT NULL DEFAULT 2  COMMENT '手续费用（1 是 2 否）',
  `sales_id` int(10) NOT NULL DEFAULT '0' COMMENT '营业部id',
  `member_id` int(10) NOT NULL DEFAULT  '0' COMMENT '业务员id',
  `body_card` CHAR(20) NOT NULL DEFAULT '' COMMENT '身份证',
  `email` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '会员邮件',
  `telephone` char(11) NOT NULL DEFAULT '' COMMENT '手机号',
  `telephone2` char(11) NOT NULL DEFAULT '' COMMENT '手机号',
  `birthday` int(11) NOT NULL DEFAULT  0  COMMENT '出生日期',
  `sex` tinyint(1)   NOT NULL DEFAULT  1  COMMENT '性别  1 男  2 女',
  `child` tinyint(1)   NOT NULL DEFAULT  1  COMMENT '有无子女  1 有  2 无',
  `jiguan` varchar(255) NOT NULL DEFAULT '' COMMENT '籍贯',
  `hukou` varchar(255) NOT NULL DEFAULT '' COMMENT '户口所在地',
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '居住地址',
  `phone` CHAR(12)  NOT NULL DEFAULT '' COMMENT '电话',
  `sort` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '排序（同级有效）',
  `add_time` int(11) not null default  0 comment '创建时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 营业员表
CREATE TABLE `ss_member` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `nickname` char(16) NOT NULL DEFAULT '' COMMENT '昵称',
  `sales_id` int(10) NOT NULL DEFAULT '0' COMMENT '营业部id',
  `yonjin_rate` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '佣金提成比例(%)',
  `lixi_rate` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '利息提成比例（%）',
  `yonjin_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '佣金收入',
  `lixi_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '利息收入',
  `total_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '总收入',
  `telephone` char(11) NOT NULL DEFAULT '1' COMMENT '手机号',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `login` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `sort` int(10) NOT NULL DEFAULT '1' COMMENT '排序',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '会员状态',
  PRIMARY KEY (`uid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='会员表';
-- 营业员登录表
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
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- 资金流水表
CREATE TABLE `ss_capital_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `ensure_money` decimal(11,2) not null default 0 comment '保证金',
  `able_money` decimal(11,2) not null default 0 comment '可用资金',
  `happen_money` decimal(11,2) not null default 0 comment '发生金额',
  `do_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作时间',
  `deal_code` VARCHAR(255) not null default '' comment '交易编码',
  `member_id` int(10) NOT NULL DEFAULT '0' COMMENT '管理员id',
  `remarks` VARCHAR(255) not null default '' comment '操作备注',
  `type` tinyint(4) DEFAULT '0' COMMENT '类型  1存入资金 2资金调整  3盈亏转本金  4月底返息 5买入  6卖出 7盈亏结现',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态  1开启 3删除',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='资金流水表';

-- 交易流水表
CREATE TABLE `ss_deal_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `shares_code` varchar(255) not null default 0 comment '股票代码',
  `shares_name` varchar(255) not null default 0 comment '股票名称',
  `do_type` tinyint(4) DEFAULT '0' COMMENT '类型 0未知 1买入  2卖出',
  `market_type` tinyint(4) DEFAULT '0' COMMENT '类型 0未知 1深市  2沪市',
  `deal_amount` int(11) not null default 0 comment '成交数量',
  `able_sell_amount` int(11) not null default 0 comment '可卖数量',
  `deal_price` decimal(11,2) not null default 0 comment '成交均价',
  `stamp_duty` decimal(11,2) not null default 0 comment '印花税',
  `transfer_fee` decimal(11,2) not null default 0 comment '过户费',
  `entrust_fee` decimal(11,2) not null default 0 comment '委托费',
  `commission` decimal(11,2) not null default 0 comment '佣金',
  `deal_money` decimal(11,2) not null default 0 comment '成交金额',
  `deal_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '交易时间',
  `occupy_money` decimal(11,2) not null default 0 comment '占用资金',
  `member_id` int(10) NOT NULL DEFAULT '0' COMMENT '管理员id',
  `summary_id` int(10) NOT NULL DEFAULT '0' COMMENT '结算流水_id',
  `capital_id` int(10) NOT NULL DEFAULT '0' COMMENT '资金流水_id',
  `remarks` VARCHAR(255) not null default '' comment '操作备注',
  `is_account` tinyint(4) not null default 2 comment '证券账户 1有 2无',
  `sell_status` tinyint(4) DEFAULT 1 COMMENT '是否卖出  1未卖出 2已卖出  3卖出登记',
  `status` tinyint(4) DEFAULT 1 COMMENT '状态 0禁用  1开启 3删除',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='交易流水表';

-- 结算流水表
CREATE TABLE `ss_summary_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `summary_id` int(10) NOT NULL DEFAULT '0' COMMENT '结算流水id',
  `do_type` tinyint(4) DEFAULT '0' COMMENT '结算方式 0未知 1盈亏转本金  2 盈亏结现',
  `shares_code` varchar(255) not null default 0 comment '股票代码',
  `shares_name` varchar(255) not null default 0 comment '股票名称',
  `buy_money` decimal(11,2) not null default 0 comment '买入金额',
  `buy_cost` decimal(11,2) not null default 0 comment '买入费用',
  `sell_money` decimal(11,2) not null default 0 comment '卖出金额',
  `sell_cost` decimal(11,2) not null default 0 comment '卖出费用',
  `interest` decimal(11,3) not null default 0 comment '利息',
  `win_loss` decimal(11,2) not null default 0 comment '盈亏金额',
  `sell_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '卖出时间',
  `do_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作时间',
  `member_id` int(10) NOT NULL DEFAULT '0' COMMENT '管理员id',
  `status` tinyint(4) DEFAULT 1 COMMENT '状态  1不可结清 2可结算 5已结算 6可结清 3已结清  4撤销 ',
  `sell_amount` int(11) not null default 0 comment '卖出数量',
  `sell_deal_price` decimal(11,2) not null default 0 comment '卖出均价',
  `sell_transfer_fee` decimal(11,2) not null default 0 comment '卖出过户费',
  `sell_stamp_duty` decimal(11,2) not null default 0 comment '卖出印花税',
  `sell_entrust_fee` decimal(11,2) not null default 0 comment '卖出委托费',
  `sell_commission` decimal(11,2) not null default 0 comment '卖出佣金',
  `buy_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '买入时间',
  `buy_amount` int(11) not null default 0 comment '买入数量',
  `buy_deal_price` decimal(11,2) not null default 0 comment '买入均价',
  `buy_transfer_fee` decimal(11,2) not null default 0 comment '买入过户费',
  `buy_entrust_fee` decimal(11,2) not null default 0 comment '买入委托费',
  `buy_commission` decimal(11,2) not null default 0 comment '买入佣金',
  `occupy_money` decimal(11,2) not null default 0 comment '占用资金',
  `occupy_day` int(5) not null default 1 coment '占用天数',
  `return_interest` decimal(11,2) not null default 0 comment '返息金额 无用',
  `reinterest_status` tinyint(1) DEFAULT 0 COMMENT '返息状态  0未返息 1已返息',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='结算流水表';


-- 利息佣金流水表
CREATE TABLE `ss_profit_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `member_id` int(10) NOT NULL DEFAULT  '0' COMMENT '业务员id',
  `total_interest` decimal(11,3) not null default 0 comment '利息总额',
  `sales_interest` decimal(11,3) not null default 0 comment '营业部利息收益',
  `ticheng_interest` decimal(11,3) not null default 0 comment '业务员利息收益',
  `total_yongjin` decimal(11,2) not null default 0 comment '佣金总额',
  `sales_yongjin` decimal(11,2) not null default 0 comment '营业部佣金收益',
  `ticheng_yongjin` decimal(11,2) not null default 0 comment '业务员佣金收益',
  `add_time` date not null  comment '插入时间',
  `status` tinyint(1) not null DEFAULT 1 comment '状态 1正常  2禁用',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='利息佣金流水表';


-- 返息表
CREATE TABLE `ss_return_interest_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `member_id` int(10) NOT NULL DEFAULT  '0' COMMENT '业务员id',
  `return_interest` decimal(11,3) not null default 0 comment '日返息',
  `day_interest` decimal(11,3) not null default 0 comment '日利息',
  `date` date not null  comment '日期',
  `add_time` int not null DEFAULT 0 comment '插入时间',
  `update_time` int not null DEFAULT 0 comment '修改时间',
  `status` tinyint(1) not null DEFAULT 1 comment '状态 1未返息  2已返息',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='返息表';

