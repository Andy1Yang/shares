<?php if (!defined('THINK_PATH')) exit();?><!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title><?php echo ($meta_title); ?>|股票管理平台</title>
    <link href="/Public/favicon.ico" type="image/x-icon" rel="shortcut icon">
    <link rel="stylesheet" type="text/css" href="/Public/Admin/css/base.css" media="all">
    <link rel="stylesheet" type="text/css" href="/Public/Admin/css/common.css" media="all">
    <link rel="stylesheet" type="text/css" href="/Public/Admin/css/module.css">
    <link rel="stylesheet" type="text/css" href="/Public/Admin/css/style.css" media="all">
	<link rel="stylesheet" type="text/css" href="/Public/Admin/css/<?php echo (C("COLOR_STYLE")); ?>.css" media="all">
     <!--[if lt IE 9]>
    <script type="text/javascript" src="/Public/static/jquery-1.10.2.min.js"></script>
    <![endif]--><!--[if gte IE 9]><!-->
    <script type="text/javascript" src="/Public/static/jquery-2.0.3.min.js"></script>
    <script type="text/javascript" src="/Public/Admin/js/jquery.mousewheel.js"></script>
    <script type="text/javascript" src="/Public/Admin/js/PCASClass.js"></script>
    <!--<![endif]-->
    
</head>
<body>
    <!-- 头部 -->
    <div class="header">
        
        <!-- Logo -->
        <span class="logo yhy_logo">股票管理平台</span>
        <!-- /Logo -->

        <!-- 主导航 -->
        <ul class="main-nav">
            <?php if(is_array($__MENU__["main"])): $i = 0; $__LIST__ = $__MENU__["main"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$menu): $mod = ($i % 2 );++$i;?><li class="<?php echo ((isset($menu["class"]) && ($menu["class"] !== ""))?($menu["class"]):''); ?>"><a href="<?php echo (U($menu["url"])); ?>"><?php echo ($menu["title"]); ?></a></li><?php endforeach; endif; else: echo "" ;endif; ?>
        </ul>
        <!-- /主导航 -->
        

        
        <!-- 用户栏 -->
        <div class="user-bar">
            <a href="javascript:;" class="user-entrance"><i class="icon-user"></i></a>
            <ul class="nav-list user-menu hidden">
                <li class="manager">你好，<em title="<?php echo session('user_auth.username');?>"><?php echo session('user_auth.username');?></em></li>
                <li><a href="<?php echo U('User/updatePassword');?>">修改密码</a></li>
                <li><a href="<?php echo U('User/updateNickname');?>">修改昵称</a></li>
                <li><a href="<?php echo U('Public/logout');?>">退出</a></li>
            </ul>
        </div>
        
    </div>
    <!-- /头部 -->

    <!-- 边栏 -->
    <div class="sidebar">
        <!-- 子导航 -->
        
            <div id="subnav" class="subnav">
                <?php if(isset($_menu_list)): if(is_array($_menu_list)): $i = 0; $__LIST__ = $_menu_list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$sub_menu): $mod = ($i % 2 );++$i; if(!empty($sub_menu)): if(!empty($key)): ?><h3><i class="icon icon-unfold"></i><?php echo ($key); ?></h3><?php endif; ?>
                            <ul class="side-sub-menu">
                                <?php if(is_array($sub_menu)): $i = 0; $__LIST__ = $sub_menu;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$menu): $mod = ($i % 2 );++$i;?><li>
                                        <a class="item" href="<?php echo (U($menu["url"])); ?>">
                                            <?php echo ($menu["title"]); ?>
                                            <?php if($menu['have_summary'] == 1): ?><span style="display:inline-block;width:10px;height:10px;background-color:red;border-radius: 10px;"></span><?php endif; ?>
                                        </a>
                                    </li><?php endforeach; endif; else: echo "" ;endif; ?>
                            </ul><?php endif; endforeach; endif; else: echo "" ;endif; ?>
                <?php else: ?>
                    <?php if(!empty($_extra_menu)): ?>
                        <?php echo extra_menu($_extra_menu,$__MENU__); endif; ?>
                    <?php if(is_array($__MENU__["child"])): $i = 0; $__LIST__ = $__MENU__["child"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$sub_menu): $mod = ($i % 2 );++$i;?><!-- 子导航 -->
                        <?php if(!empty($sub_menu)): if(!empty($key)): ?><h3><i class="icon icon-unfold"></i><?php echo ($key); ?></h3><?php endif; ?>
                            <ul class="side-sub-menu">
                                <?php if(is_array($sub_menu)): $i = 0; $__LIST__ = $sub_menu;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$menu): $mod = ($i % 2 );++$i;?><li>
                                        <a class="item" href="<?php echo (U($menu["url"])); ?>"><?php echo ($menu["title"]); ?></a>
                                    </li><?php endforeach; endif; else: echo "" ;endif; ?>
                            </ul><?php endif; ?>
                        <!-- /子导航 --><?php endforeach; endif; else: echo "" ;endif; endif; ?>
            </div>
        
        <!-- /子导航 -->
    </div>
    <!-- /边栏 -->

    <!-- 内容区 -->
    <div id="main-content">
        <div id="top-alert" class="fixed alert alert-error" style="display: none;">
            <button class="close fixed" style="margin-top: 4px;">&times;</button>
            <div class="alert-content">这是内容</div>
        </div>
        <div id="main" class="main">
            
            <!-- nav -->
            <?php if(!empty($_show_nav)): ?><div class="breadcrumb">
                <span>您的位置:</span>
                <?php $i = '1'; ?>
                <?php if(is_array($_nav)): foreach($_nav as $k=>$v): if($i == count($_nav)): ?><span><?php echo ($v); ?></span>
                    <?php else: ?>
                    <span><a href="<?php echo ($k); ?>"><?php echo ($v); ?></a>&gt;</span><?php endif; ?>
                    <?php $i = $i+1; endforeach; endif; ?>
            </div><?php endif; ?>
            <!-- nav -->
            

            
    <!-- 标题栏 -->
    <div class="main-title">
        <h2>盈亏汇总表</h2>
    </div>
    <div class="cf">
        <div class="fl">
            <a class="btn reflash" href="javascript:location.reload();">刷 新</a>
            <button class="btn ajax-post" url="<?php echo U('changeStatus?method=resumeUser');?>" target-form="ids">导 出</button>
            <a class="sell btn" href="javascript:;" >安全界限(%)</a>
            营业部门：<select name="sales_id" id="sales_id">
                <option value="">--请选择--</option>
                <?php if(is_array($_salesList)): $i = 0; $__LIST__ = $_salesList;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$sa): $mod = ($i % 2 );++$i;?><option value="<?php echo ($sa["id"]); ?>" <?php if($sa['id'] == $sales_id): ?>selected='selected'<?php endif; ?>><?php echo ($sa["title"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
            </select>&nbsp;&nbsp;
                客户：<select name="user_id" id="user_id">
                <option value="0">--请选择--</option>
                <?php if(is_array($_userList)): $i = 0; $__LIST__ = $_userList;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$me): $mod = ($i % 2 );++$i;?><option style="display:none;" said="<?php echo ($me["sales_id"]); ?>" value="<?php echo ($me["id"]); ?>" <?php if($me['id'] == $user_id): ?>selected='selected'<?php endif; ?>><?php echo ($me["name"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
            </select>
                <a class="sch-btn" href="javascript:;" id="search" url="<?php echo U('index');?>" style="float:right;"><i class="btn-search"></i></a>
        </div>
    </div>
    <!-- 数据列表 -->
    <div class="data-table table-striped">
        <table class="">
            <thead>
            <tr>
                <th class="">姓名</th>
                <th class="">保证金</th>
                <th class="">浮动保证金</th>
                <th class="">倍率</th>
                <th class="">可用资金</th>
                <th class="">浮动可用</th>
                <th class="">持股成本</th>
                <th class="">当前市值</th>
                <th class="">预估费用</th>
                <th class="">预估利息</th>
                <th class="">浮动盈亏</th>
                <th class="">盈亏比例(%)</th>
                <th class="">安全界限</th>
            </tr>
            </thead>
            <tbody>
            <?php if(!empty($_user_list)): if(is_array($_user_list)): $i = 0; $__LIST__ = $_user_list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><tr <?php if(0 > $vo['float_win_loss']): ?>style="color:red;"<?php endif; ?>>
                    <td><?php echo ($vo["name"]); ?> </td>
                    <td><?php echo ($vo["ensure_money"]); ?></td>
                    <td><?php echo ($vo["float_ensure_money"]); ?></td>
                    <td><?php echo ($vo["beilv"]); ?></td>
                    <td><?php echo ($vo["able_money"]); ?></td>
                    <td><?php echo ($vo["float_able_money"]); ?></td>
                    <td><?php echo ($vo["chengben"]); ?></td>
                    <td><?php echo ($vo["now_value"]); ?></td>
                    <td><?php echo ($vo["assess_cost"]); ?></td>
                    <td><?php echo ($vo["assess_interest"]); ?></td>
                    <td><?php echo ($vo["float_win_loss"]); ?></td>
                    <td><?php echo ($vo["win_loss_ratio"]); ?></td>
                    <td style="text-align: center; font-weight: bold;color:<?php echo ($vo["color"]); ?>;<!--background-color:<?php echo ($vo["background"]); ?>-->"><?php echo ($vo["safe_line"]); ?></td>
                    </tr><?php endforeach; endif; else: echo "" ;endif; ?>
                <?php else: ?>
                <td colspan="13" class="text-center"> aOh! 暂时还没有内容! </td><?php endif; ?>
            </tbody>
        </table>
    </div>
    <div class="data-table table-striped">
        <table class="">
        <thead>
        <tr>
            <th class="">合计</th>
            <th class="">12333</th>
            <th class="">12333</th>
            <th class=""></th>
            <th class="">12333</th>
            <th class="">12333</th>
            <th class="">12333</th>
            <th class="">12333</th>
            <th class="">12333</th>
            <th class="">12333</th>
            <th class="">12333</th>
            <th class="">12333</th>
            <th class=""></th>
            <th class=""></th>
        </tr>
        </thead>
    </table>
    </div>
    <div class="page">
        <?php echo ($_page); ?>
    </div>
    <script type="text/javascript">
        /*可以移动div*/
        var a;
        document.onmouseup=function(){
            if(!a)return;document.all?a.releaseCapture():window.captureEvents(Event.MOUSEMOVE|Event.MOUSEUP);a="";};
        document.onmousemove=function (d){if(!a)return;if(!d)d=event;a.style.left=(d.clientX-b)+"px";a.style.top=(d.clientY-c)+"px";};
        function move(o,e){
            a=o;document.all?a.setCapture():window.captureEvents(Event.MOUSEMOVE);b=e.clientX-parseInt(a.style.left);c=e.clientY-parseInt(a.style.top);
        }
    </script>
    <div id="sell" style="height:270px;width: 558px;left: 454px; top: 174px;"  onmousedown="move(this,event)">
        <p class="black"><a href="javascript:;" class="close">X</a></p>
        <div class="neikuan">
            <label class="item-label" style="font-weight: bold;">安全界限颜色</label>
            <form action="<?php echo U('setFit');?>" class="doposit" method="post">
                <table cellpadding="80" cellspacing="80">
                    <tr>
                        <td class="tdtiao">警戒线(%)</td>
                        <td class="tiaotd2" style="width:80%;"> <input class='man' type="text" name="red" value="<?php echo ($_red); ?>"></td>
                    </tr>
                    <tr>
                        <td class="tdtiao">平仓线(%)</td>
                        <td class="tiaotd2" style="width:80%;"> <input class='man' type="text" name="blue" value="<?php echo ($_blue); ?>"></td>
                    </tr>
                    <tr>
                        <td class="tiaotd3" colspan="4">
                            <input style="margin-right: 40px;" class='sub' type="submit" name="sub" value="提交">
                            <input style="margin-left: 40px;" class='sub' type="reset" name="" value="重置">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>

        </div>
        <div class="cont-ft">
            <div class="copyright">
                <div class="fl">股票管理平台</div>
                <div class="fr">V<?php echo (股票管理平台_VERSION); ?></div>
            </div>
        </div>
    </div>
    <!-- /内容区 -->
    <script type="text/javascript">
    (function(){
        var ThinkPHP = window.Think = {
            "ROOT"   : "", //当前网站地址
            "APP"    : "/admin.php?s=", //当前项目地址
            "PUBLIC" : "/Public", //项目公共目录地址
            "DEEP"   : "<?php echo C('URL_PATHINFO_DEPR');?>", //PATHINFO分割符
            "MODEL"  : ["<?php echo C('URL_MODEL');?>", "<?php echo C('URL_CASE_INSENSITIVE');?>", "<?php echo C('URL_HTML_SUFFIX');?>"],
            "VAR"    : ["<?php echo C('VAR_MODULE');?>", "<?php echo C('VAR_CONTROLLER');?>", "<?php echo C('VAR_ACTION');?>"]
        }
    })();
    </script>
    <script type="text/javascript" src="/Public/static/think.js"></script>
    <script type="text/javascript" src="/Public/Admin/js/common.js"></script>
    <script type="text/javascript">
        +function(){
            var $window = $(window), $subnav = $("#subnav"), url;
            $window.resize(function(){
                $("#main").css("min-height", $window.height() - 130);
            }).resize();

            /* 左边菜单高亮 */
            url = window.location.pathname + window.location.search;
            url = url.replace(/(\/(p)\/\d+)|(&p=\d+)|(\/(id)\/\d+)|(&id=\d+)|(\/(group)\/\d+)|(&group=\d+)/, "");
            $subnav.find("a[href='" + url + "']").parent().addClass("current");

            /* 左边菜单显示收起 */
            $("#subnav").on("click", "h3", function(){
                var $this = $(this);
                $this.find(".icon").toggleClass("icon-fold");
                $this.next().slideToggle("fast").siblings(".side-sub-menu:visible").
                      prev("h3").find("i").addClass("icon-fold").end().end().hide();
            });

            $("#subnav h3 a").click(function(e){e.stopPropagation()});

            /* 头部管理员菜单 */
            $(".user-bar").mouseenter(function(){
                var userMenu = $(this).children(".user-menu ");
                userMenu.removeClass("hidden");
                clearTimeout(userMenu.data("timeout"));
            }).mouseleave(function(){
                var userMenu = $(this).children(".user-menu");
                userMenu.data("timeout") && clearTimeout(userMenu.data("timeout"));
                userMenu.data("timeout", setTimeout(function(){userMenu.addClass("hidden")}, 100));
            });

	        /* 表单获取焦点变色 */
	        $("form").on("focus", "input", function(){
		        $(this).addClass('focus');
	        }).on("blur","input",function(){
				        $(this).removeClass('focus');
			        });
		    $("form").on("focus", "textarea", function(){
			    $(this).closest('label').addClass('focus');
		    }).on("blur","textarea",function(){
			    $(this).closest('label').removeClass('focus');
		    });

            // 导航栏超出窗口高度后的模拟滚动条
            var sHeight = $(".sidebar").height();
            var subHeight  = $(".subnav").height();
            var diff = subHeight - sHeight; //250
            var sub = $(".subnav");
            if(diff > 0){
                $(window).mousewheel(function(event, delta){
                    if(delta>0){
                        if(parseInt(sub.css('marginTop'))>-10){
                            sub.css('marginTop','0px');
                        }else{
                            sub.css('marginTop','+='+10);
                        }
                    }else{
                        if(parseInt(sub.css('marginTop'))<'-'+(diff-10)){
                            sub.css('marginTop','-'+(diff-10));
                        }else{
                            sub.css('marginTop','-='+10);
                        }
                    }
                });
            }
        }();
    </script>
    
    <script src="/Public/static/thinkbox/jquery.thinkbox.js"></script>

    <script type="text/javascript">
        //搜索功能
        $("#search").click(function(){
            var url = $(this).attr('url');
            var query  = $('.search-form').find('input').serialize();
            query = query.replace(/(&|^)(\w*?\d*?\-*?_*?)*?=?((?=&)|(?=$))/g,'');
            query = query.replace(/^&/g,'');
            if( url.indexOf('?')>0 ){
                url += '&' + query;
            }else{
                url += '?' + query;
            }
            var sales_id = $('#sales_id').val();
            var user_id = $('#user_id').val();
            if(sales_id!=''){
                url += '&sales_id='+sales_id;
            }
            if(user_id!='') {
                url += '&user_id=' + user_id;
            }
            window.location.href = url;
        });
        //回车搜索
        $(".search-input").keyup(function(e){
            if(e.keyCode === 13){
                $("#search").click();
                return false;
            }
        });
        //卖出
        $('.sell').click(function(){
            $('#sell').css('display','block');
            //$('.sell_first').focus();
        });
        //关闭弹窗
        $('.close').click(function(){
            $('#sell').css('display','none');
        });
        //营业部和客户联动
        $('#sales_id').blur(function(){
            var salesId= $(this).val();
            $('#user_id option').css('display','none');
            $('#user_id option[said='+salesId+']').css('display','block');
            $('#user_id option:first').css('display','block');
            $('#user_id').val(0);
        });
        var salesId = $('#sales_id').val();
        if(salesId!=null && salesId!=''){
            $('#user_id option').css('display','none');
            $('#user_id option[said='+salesId+']').css('display','block');
            $('#user_id option:first').css('display','block');
        }
        //导航高亮
        highlight_subnav('<?php echo U('Ware/index');?>');
    </script>

</body>
</html>