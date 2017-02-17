<?php
// +----------------------------------------------------------------------
// | 股票配资管理平台 [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.股票配资管理平台.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

if(version_compare(PHP_VERSION,'5.3.0','<'))  die('require PHP > 5.3.0 !');
header("content-type:text/html;charset=utf-8");

/**
 * 系统调试设置
 * 项目正式部署后请设置为false
 */
define('APP_DEBUG', true );

defined('ROOT_PATH') or define('ROOT_PATH', dirname(__FILE__));
define('MODE_NAME','Cli');//必须是cli，采用CLI运行模式运行
define('THINK_PATH', ROOT_PATH.'/ThinkPHP/');
define('APP_PATH', dirname(__FILE__).'/Application/' );
define ( 'CLI_PATH', '/data/paidread_admin/' );

/**
 * 应用目录设置
 * 安全期间，建议安装调试完成后移动到非WEB目录
 */
//define ( 'APP_PATH', './Application/' );
//if(!is_file(APP_PATH . 'User/Conf/config.php')){
//    header('Location: ./install.php');
//    exit;
//}

/**
 * 缓存目录设置
 * 此目录必须可写，建议移动到非WEB目录
 */
define ( 'RUNTIME_PATH', './Runtime/' );

/**
 * 引入核心入口
 * ThinkPHP亦可移动到WEB以外的目录
 */
require( THINK_PATH."ThinkPHP.php");








