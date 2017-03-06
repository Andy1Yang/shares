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
        <h2>交易管理</h2>
    </div>

    <!-- 数据列表 -->
    <div class="data-table table-striped">
        <table class="">
            <thead>
            <tr>
                <th class="">股票代码</th>
                <th class="">股票名称</th>
                <th class="">市场</th>
                <th class="">买入数量</th>
                <th class="">持仓数量</th>
                <th class="">可卖数量</th>
                <th class="">成交均价</th>
                <th class="">当前价格</th>
                <th class="">买入费用</th>
                <th class="">卖出费用</th>
                <th class="">利息费用</th>
                <th class="">市值</th>
                <th class="">浮动盈亏</th>
                <th class="">盈亏比例</th>
                <th class="">操作</th>
            </tr>
            </thead>
            <tbody>
            <?php if(!empty($_deal_list2)): if(is_array($_deal_list2)): $i = 0; $__LIST__ = $_deal_list2;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><tr>
                        <td><?php echo ($vo["shares_code"]); ?> </td>
                        <td><?php echo ($vo["shares_name"]); ?></td>
                        <td tag="<?php echo ($vo["market_type"]); ?>"><?php echo ($vo["market_type_text"]); ?></td>
                        <td><?php echo ($vo["deal_amount"]); ?></td>
                        <td><?php echo ($vo["able_sell_amount"]); ?></td>
                        <td><?php if($vo['is_sell'] == 1): echo ($vo["able_sell_amount"]); else: ?>0<?php endif; ?></td>
                        <td><?php echo ($vo["deal_price"]); ?></td>
                        <td><?php echo ($vo["now_price"]); ?></td>
                        <td><?php echo ($vo["buy_cost"]); ?></td>
                        <td><?php echo ($vo["sell_cost"]); ?></td>
                        <td><?php echo ($vo["interest"]); ?></td>
                        <td><?php echo ($vo["now_value"]); ?></td>
                        <td><span <?php if((0 > $vo['float_win_loss'])): ?>style="color:red;"<?php endif; ?>><?php echo ($vo["float_win_loss"]); ?></span></td>
                        <td><span <?php if((0 > $vo['win_loss_ratio'])): ?>style="color:red;"<?php endif; ?>><?php echo ($vo["win_loss_ratio"]); ?></span></td>
                        <td>
                            <?php if($vo['is_sell'] == 1): ?><a class="sell" style="font-size: 14px;font-weight: bold;color: white;background-color: #5992CB;border-radius: 3px;padding: 5px;"  href="javascript:;" tag="<?php echo ($vo["id"]); ?>">卖出</a>
                                <?php else: ?>
                                <a style="font-size: 14px;font-weight: bold;color: white;background-color: #5992CB;border-radius: 3px;padding: 5px;"  href="javascript:;" >暂不可卖</a><?php endif; ?>
                        </td>
                    </tr><?php endforeach; endif; else: echo "" ;endif; ?>
                <?php else: ?>
                <td colspan="16" class="text-center"> aOh! 暂时还没有内容! </td><?php endif; ?>
            </tbody>
        </table>
    </div>
    <div class="page">
        <script type="text/javascript" src="/Public/Admin/js/jquery.min.js"></script>
        <script type="text/javascript" src="/Public/Admin/js/jquery.page.js"></script>
        <div class="tcdPageCode2">
        </div>
        <script>
            $(".tcdPageCode2").createPage({
                pageCount:<?php echo ($_allPage2); ?>,
                current:<?php echo ($_p2); ?>,
                backFn:function(p){
                    p2 = p;
                    location.href='/admin.php?s=/Operate/index/id/<?php echo ($_user_info["id"]); ?>/p1/'+p1+'/p2/'+p+'/';
                }
            });
        </script>
    </div>

    <script type="text/javascript">
        /*可以移动div*/
        var a;
        document.onmouseup=function(){
            if(!a)return;document.all?a.releaseCapture():window.captureEvents(Event.MOUSEMOVE|Event.MOUSEUP);a="";};
        document.onmousemove=function (d){if(!a)return;if(!d)d=event;a.style.left=(d.clientX-b)+"px";a.style.top=(d.clientY-c)+"px";};
        var mo = false;
        function move(o,e){
            if(mo){
                a=o;document.all?a.setCapture():window.captureEvents(Event.MOUSEMOVE);b=e.clientX-parseInt(a.style.left);c=e.clientY-parseInt(a.style.top);
            }else{
                return false;
            }
        }
    </script>

    <div id="sell" style="height:270px;left: 310px; top: 173px;" onmousedown="move(this,event)">
        <p class="black"><a href="javascript:;" class="close">X</a></p>
        <div class="neikuan">
            <label class="item-label" style="font-weight: bold;">交易管理-卖出</label>
            <form action="<?php echo U('sell');?>" class="doposit" method="post" id="selform">
                <table cellpadding="80" cellspacing="80">
                    <tr>
                        <input type="hidden" class="sell_id" name="id" value="">
                        <input type="hidden" class="interest" name="interest" value="">
                        <input type="hidden" class="sell_cost" name="sell_cost" value="">
                        <input type="hidden" class="market_type" name="market_type" value="">
                        <td class="tdtiao">股票代码：</td>
                        <td class="tiaotd2"> <input disabled="disabled" class='man sell_code' type="text" name="shares_code" value=""></td>
                        <td class="tdtiao">股票名称：</td>
                        <td class="tiaotd2"> <input disabled="disabled" class='man sell_name' type="text" name="shares_name" value=""></td>
                    </tr>
                    <tr>
                        <td class="tdtiao">卖出数量：</td>
                        <td class="tiaotd2"> <input class='man sell_first' type="text" name="sell_amount" value=""></td>
                        <td class="tdtiao">可卖数量：</td>
                        <td class="tiaotd2"> <input disabled="disabled" class='man sell_amount' type="text" name="able_amount" value=""></td>
                    </tr>
                    <tr>
                        <td class="tdtiao">卖出价格：</td>
                        <td class="tiaotd2">
                            <div class="big_word_div"></div>
                            <input class='man big_word' type="text" name="sell_price" value="">
                        </td>
                        <td class="tdtiao">卖出时间：</td>
                        <td class="tiaotd2"> <input class='man' type="text" name="sell_time" value="<?=date('Y-m-d H:i:s',time())?>"></td>
                    </tr>
                    <!--tr>
                        <td class="tdtiao">免息金额：</td>
                        <td class="tiaotd2"> <input class='man' type="text" name="free_interest" value="0"></td>
                        <td class="tdtiao"></td>
                        <td class="tiaotd2"> <input class='man' type="text" name="" value=""></td>
                    </tr-->
                    <tr>
                        <td class="tiaotd3" colspan="4">
                            <input style="margin-right: 40px;" class='sub' type="submit" name="sub" value="提交">
                            <input style="margin-left: 40px;" class='sub' type="reset" name="" value="重置">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div >

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
        $('.black').mousemove(function(){
            mo = true;
        });
        $('.black').mouseout(function(){
            mo = false;
        });
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
            window.location.href = url;
        });
        //回车搜索
        $(".search-input").keyup(function(e){
            if(e.keyCode === 13){
                $("#search").click();
                return false;
            }
        });
        //导航高亮
        var id = <?php echo ($_user_info["id"]); ?>;
        highlight_subnav("<?php echo U('Operate/index/id/"+id+"');?>");
        //卖出
        $('.sell').click(function(){
            $('#sell').css('display','block');
            $('.sell_first').focus();
            var sell_code = $(this).parent().siblings().first().text();
            var sell_name = $(this).parent().siblings().eq(1).text();
            var sell_amount = $(this).parent().siblings().eq(4).text();
            var interest = $(this).parent().siblings().eq(10).text();
            var sell_cost = $(this).parent().siblings().eq(9).text();
            var sell_id = $(this).attr('tag');
            var market_type = $(this).parent().siblings().eq(2).attr('tag');
            $('.sell_code').val(sell_code);
            $('.sell_name').val(sell_name);
            $('.sell_amount').val(sell_amount);
            $('.sell_id').val(sell_id);
            $('.interest').val(interest);
            $('.sell_cost').val(sell_cost);
            $('.market_type').val(market_type);
        });
        //关闭弹窗
        $('.close').click(function(){
            $('#buy').css('display','none');
            $('#sell').css('display','none');
        });

        //数字转中文大写
        $('.big_word').bind('input propertychange', function() {
            $(this).siblings('.big_word_div').css('display','block');
            var num = $(this).val();
            var bigWord = DX(num);
            $('.big_word_div').text(bigWord);
        });
        $('.big_word').blur(function(){
            $('.big_word_div').css('display','none');
        });
        function DX(n) {
            if (!/^(0|[1-9]\d*)(\.\d+)?$/.test(n))
                return "数据非法";
            var unit = "千百拾亿千百拾万千百拾元角分", str = "";
            n += "00";
            var p = n.indexOf('.');
            if (p >= 0)
                n = n.substring(0, p) + n.substr(p+1, 2);
            unit = unit.substr(unit.length - n.length);
            for (var i=0; i < n.length; i++)
                str += '零壹贰叁肆伍陆柒捌玖'.charAt(n.charAt(i)) + unit.charAt(i);
            return str.replace(/零(千|百|拾|角)/g, "零").replace(/(零)+/g, "零").replace(/零(万|亿|元)/g, "$1").replace(/(亿)万|壹(拾)/g, "$1$2").replace(/^元零?|零分/g, "").replace(/元$/g, "元整");
        }
        //股票名称股市自动化
        $('.share_code').blur(function () {
            var sharesCode = $(this).val();
            $.post("<?php echo U('self_shares');?>",{'shares_code':sharesCode},function(data){
                $('.shares_name').val(data.sharesName);
                $('#market_type').val(data.market_type);
            }, "json");
        });
    </script>

</body>
</html>