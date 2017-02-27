<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/1/8
 * Time: 16:38
 */
namespace Admin\Controller;

/**
 * 后台报表控制器
 * @author yhy  <494044011@qq.com>
 */
class ReportController extends AdminController {

    //盈亏总汇
//    public function  index(){
//        $user_list = M('user')->where('status=1')->select();
//        $userModel = D('User');
//        $nowDay =   date('Y-m-d',time());
//        foreach($user_list as $key=>$item){
//            $dealArr = M('deal_log')->where('user_id='.$item['id'].' and sell_status=1')->select();
//            $chengben = 0;
//            $now_value = 0;
//            $assess_cost = 0;
//            $assess_interest = 0;
//            $occupy_money = 0;
//            foreach($dealArr as $va){
//                if($va['market_type']==1){
//                    $shares_code = 'sz'.$va['shares_code'];
//                    $sell_entrust_fee = $userModel->count_entrust_fee(1); //委托费
//                }else if($va['market_type']==2){
//                    $shares_code = 'sh'.$va['shares_code'];
//                    $sell_transfer_fee = $userModel->count_transfer_fee($va['able_sell_amount']); //过户费
//                    $sell_entrust_fee = $userModel->count_entrust_fee(2); //委托费
//                }
//                //费用统计
//                $sell_stamp_duty = $userModel->count_stamp_duty($va['able_sell_amount']);//印花税
//                $result = $userModel->sharesApi($shares_code);
//                if(!is_array($result)) continue;
//                $now_price = $result['result'][0]['data']['nowPri'];
//                $sell_money = $now_price*$va['able_sell_amount'];
//                $now_value += $sell_money;
//                $chengben += $va['able_sell_amount']*$va['deal_price']+$va['stamp_duty']+$va['transfer_fee']+$va['entrust_fee']+$va['commission'];
//                $sell_commission = $userModel->count_commission($sell_money,$item['yongjin_rate']);//佣金
//
//                $buy_time =  date('Y-m-d',$va['deal_time']);//买入时间
//                $howDay = diffBetweenTwoDays($nowDay,$buy_time)+1;
//                $interest = $item['rate']*$howDay*$sell_money/10000;//利息
//                $assess_cost += $sell_entrust_fee+$sell_transfer_fee+$sell_stamp_duty+$sell_commission;
//                $assess_interest += $interest;
//                $occupy_money += $va['occupy_money'];
//            }
//            $user_list[$key]['chengben'] = $chengben;  //持股成本
//            $user_list[$key]['now_value'] = $now_value;//当前市值
//            $user_list[$key]['assess_cost'] = $assess_cost;  //预估费用
//            $user_list[$key]['assess_interest'] = $assess_interest; //预估利息
//            $user_list[$key]['float_win_loss'] = $user_list[$key]['now_value']-$user_list[$key]['chengben']-$user_list[$key]['assess_cost']-$user_list[$key]['assess_interest'] ;
//            $total_invest = $user_list[$key]['chengben']+$user_list[$key]['assess_cost']+ $user_list[$key]['assess_interest'];//总投资成本
//            $user_list[$key]['win_loss_ratio'] = number_format($user_list[$key]['float_win_loss']/$total_invest*100,2);//盈亏比例
//            $user_list[$key]['safe_line'] =  number_format($user_list[$key]['float_ensure_money']/$user_list[$key]['now_value'],2);//安全界限
//            $user_list[$key]['float_ensure_money'] =  $user_list[$key]['float_win_loss']+$item['ensure_money'];//浮动保证金
//            $user_list[$key]['float_able_money'] = $item['able_money']+$user_list[$key]['win_loss_ratio']*$item['pledge'];//浮动可用资金
//            $user_list[$key]['beilv'] = number_format($occupy_money/($item['ensure_money']*$item['pledge']),2);//倍率
//        }
//        $this->assign('_user_list',$user_list);
//        $this->meta_title = '报表';
//        $this->display();
//    }

    //交易结算清单
    public function index(){
        //先查权限
        $user_info = M('member')->where('uid='.UID)->find();
        if($user_info['level']==1){//超级管理员
            $where = '1=1';
            $where1 = '1=1';
            $salesList = M('sales')->where('status=1')->field('id,title')->select();
            $userList = M('user')->where('status=1')->field('id,name,sales_id')->select();
            $this->assign('_salesList',$salesList);
            $this->assign('_userList',$userList);
        }else if($user_info['level']==2){ //主管
            $uidList = M('member')->where('sales_id='.$user_info['sales_id'])->field('uid')->select();
            $uidStr = '';
            foreach($uidList as $item){
                $uidStr .= $item['uid'].',';
            }
            $uidStr = trim($uidStr,',');
            $where = " a.member_id in ({$uidStr})";
            $where1 = " member_id in ({$uidStr})";
            $userList = M('user')->where('status=1 and sales_id='.$user_info['sales_id'])->field('id,name,sales_id')->select();
            $this->assign('_userList',$userList);
        }else{//普通业务员
            $where = ' a.member_id='.UID;
            $where1 = ' member_id='.UID;
            $userList = M('user')->where('status=1 and member_id='.$user_info['uid'])->field('id,name,sales_id')->select();
            $this->assign('_userList',$userList);
        }
        //接受参数
        $start_time = strtotime(I('start'));
        $end_time = strtotime(I('end'));
        $sales_id = I('sales_id');
        $user_id = I('user_id');
        if(!empty($start_time)){
            $where .= ' and a.sell_time>='.$start_time;
            $where1 .= ' and sell_time>='.$start_time;
            $this->assign('start',I('start'));
        }else{
            $now_day = date('Y-m-d',time());
            $start_time = strtotime($now_day);
            $where .= ' and a.sell_time>='.$start_time;
            $where1 .= ' and sell_time>='.$start_time;
            $this->assign('start',$now_day.' 00:00:00');
        }
        if(!empty($end_time)){
            $where .= ' and a.sell_time<='.$end_time;
            $where1 .= ' and sell_time<='.$end_time;
            $this->assign('end',I('end'));
        }else{
            $now_day = date('Y-m-d',time());
            $end_time = strtotime($now_day)+24*3600;
            $where .= ' and a.sell_time<='.$end_time;
            $where1 .= ' and sell_time<='.$end_time;
            $this->assign('end',$now_day.' 23:59:59');
        }
        if(!empty($user_id)){
            $where .= ' and a.user_id='.$user_id;
            $where1 .= ' and user_id='.$user_id;
            $this->assign('user_id',I('user_id'));
        }
        if(!empty($sales_id) && $user_info['level']==1){
            $uidList = M('member')->where('sales_id='.$sales_id)->field('uid')->select();
            $uidStr = '';
            foreach($uidList as $item){
                $uidStr .= $item['uid'].',';
            }
            $uidStr = trim($uidStr,',');
            $where .= " and a.member_id in ({$uidStr})";
            $where1 .= " and member_id in ({$uidStr})";
            $this->assign('sales_id',I('sales_id'));
        }
        $summary_log = M('summary_log');
        $count = $summary_log->where(" (status=3 or status=5) and {$where1}")->count('id');// 查询满足要求的总记录数
        $Page       = new \Think\Page($count,40);// 实例化分页类 传入总记录数和每页显示的记录数
        $show       = $Page->show();// 分页显示输出
        $this->assign('_page',$show);
        $sql = "select a.*,b.name from ss_summary_log as a left join ss_user as b on a.user_id=b.id where (a.status=3 or a.status=5) and {$where} order by a.do_time DESC,a.id DESC limit {$Page->firstRow},{$Page->listRows}";
        $Model = new \Think\Model(); // 实例化一个model对象 没有对应任何数据表
        $list = $Model->query($sql);
        $map = array(
            'status'=>array(
                '1'=>'不可结清',
                '2'=>'未结清',
                '3'=>'已结清',
                '5'=>'已结算',
                '6'=>'可结清',
            ),
            'do_type'=>array(
                '1'=>'盈亏转本金',
                '2'=>'盈亏结现'
            ),
        );
        int_to_string($list,$map);
        $this->assign('_list',$list);
        $this->meta_title = '报表';
        $this->display();
    }

    //业务员提成
    public function layer(){
        $start_time = I('start');
        $end_time = I('end');
        $sales_id = I('sales_id');
        $member_id = I('member_id');
        $condition = "";
        if(!empty($start_time)){
            $condition .= " and c.add_time>='{$start_time}'";
            $this->assign('start',I('start'));
        }
        if(!empty($end_time)){
            $condition .= " and c.add_time<='{$end_time}'";
            $this->assign('end',I('end'));
        }
        if(empty($condition)){
            $now_day = date('Y-m-d',time());
            $condition .= " and c.add_time={$now_day}";
//            $condition .= " order by c.ass_time desc";
            $this->assign('start',$now_day);
            $this->assign('end',$now_day);
        }

        //先查权限
        $user_info = M('member')->where('uid='.UID)->find();
        $search = '';
        if($user_info['level']==1){//超级管理员
            if(!empty($sales_id)){
                $search .= " and sales_id={$sales_id}";
                $this->assign('sales_id',I('sales_id'));
            }
            if(!empty($member_id)){
                $search .= ' and uid='.$member_id;
                $this->assign('member_id',I('member_id'));
            }
            $member_list = M('member')->where('status=1 '.$search)->select();
            $salesList = M('sales')->where('status=1')->field('id,title')->select();
            $memberList = M('member')->where('status=1')->field('uid,nickname,sales_id')->select();
            $this->assign('_salesList',$salesList);
            $this->assign('_memberList',$memberList);

        }else if($user_info['level']==2){ //主管
            if(!empty($member_id)){
                $search .= ' and uid='.$member_id;
                $this->assign('member_id',I('member_id'));
            }
            $member_list = M('member')->where('status=1 and sales_id='.$user_info['sales_id'].$search)->select();
            $memberList = M('member')->where('status=1 and sales_id='.$user_info['sales_id'])->field('uid,nickname,sales_id')->select();
            $this->assign('_memberList',$memberList);
        }else{//普通业务员
            $member_list = M('member')->where('status=1 and uid='.UID)->select();
            $memberList = M('member')->where('status=1 and uid='.UID)->field('uid,nickname,sales_id')->select();
            $this->assign('_memberList',$memberList);
        }

        $list = array();
        $i = 0;
        foreach($member_list as $item){
            $sql = "select a.name,a.rate,a.yongjin_rate,b.dali_rate,b.yongjin_rate as daili_yongjin_rate,sum(c.total_interest) as total_interest,sum(c.total_yongjin) as  total_yongjin from ss_user as a left join ss_sales as b on a.sales_id=b.id left join ss_profit_log as c on a.id=c.user_id where a.member_id={$item['uid']} and c.status=1 {$condition} group by a.id";
            $Model = new \Think\Model(); // 实例化一个model对象 没有对应任何数据表
            $list[$i] = $Model->query($sql);
            foreach($list[$i] as $key=>$value){
                $list[$i][$key]['nickname'] = $item['nickname'];
                $list[$i][$key]['profit_interest'] = round($list[$i][$key]['total_interest']*(1-$list[$i][$key]['dali_rate']/$list[$i][$key]['rate']),2);
                $list[$i][$key]['lixi_rate'] = $item['lixi_rate'];
                $list[$i][$key]['interest_ticheng'] = round($list[$i][$key]['profit_interest']*$item['lixi_rate']/100,2);
                $list[$i][$key]['profit_yongjin'] = round($list[$i][$key]['total_yongjin']*(1-$list[$i][$key]['daili_yongjin_rate']/$list[$i][$key]['yongjin_rate']),2);
                $list[$i][$key]['yonjin_rate'] = $item['yonjin_rate'];
                $list[$i][$key]['yonjin_ticheng'] = round($list[$i][$key]['profit_yongjin']*$item['yonjin_rate']/100,2);
            }
            $i++;
        }
        $this->assign('_list',$list);
        $this->meta_title = '报表';
        $this->display();
    }

    //持仓汇总
    public function position(){
        //先查权限
        $user_info = M('member')->where('uid='.UID)->find();
        if($user_info['level']==1){//超级管理员
            $where = '1=1';
            $where1 = '1=1';
            $salesList = M('sales')->where('status=1')->field('id,title')->select();
            $userList = M('user')->where('status=1')->field('id,name,sales_id')->select();
            $this->assign('_salesList',$salesList);
            $this->assign('_userList',$userList);
        }else if($user_info['level']==2){ //主管
            $uidList = M('member')->where('sales_id='.$user_info['sales_id'])->field('uid')->select();
            $uidStr = '';
            foreach($uidList as $item){
                $uidStr .= $item['uid'].',';
            }
            $uidStr = trim($uidStr,',');
            $where = " a.member_id in ({$uidStr})";
            $where1 = " ss_deal_log.member_id in ({$uidStr})";
            $userList = M('user')->where('status=1 and sales_id='.$user_info['sales_id'])->field('id,name,sales_id')->select();
            $this->assign('_userList',$userList);
        }else{//普通业务员
            $where = ' a.member_id='.UID;
            $where1 = ' ss_deal_log.member_id='.UID;
            $userList = M('user')->where('status=1 and member_id='.$user_info['uid'])->field('id,name,sales_id')->select();
            $this->assign('_userList',$userList);
        }
        //接受参数
        $shares_code = I('shares_code');
        $sales_id = I('sales_id');
        $user_id = I('user_id');

        if(!empty($shares_code)){
            $where .= " and a.shares_code='{$shares_code}'";
            $where1 .= " and ss_deal_log.shares_code='{$shares_code}'";
            $this->assign('shares_code',$shares_code);
        }
        if(!empty($user_id)){
            $where .= ' and a.user_id='.$user_id;
            $where1 .= ' and ss_deal_log.user_id='.$user_id;
            $this->assign('user_id',$user_id);
        }
        if(!empty($sales_id)){
            $where .= ' and b.sales_id='.$sales_id;
            $where1 .= ' and b.sales_id='.$sales_id;
            $this->assign('sales_id',I('sales_id'));
        }

        $deal_log = M('deal_log');
        $count = $deal_log->join("ss_member as b on ss_deal_log.member_id=b.uid")->where("{$where1} and ss_deal_log.status=1 and ss_deal_log.do_type=1 and ss_deal_log.sell_status=1")->count('id');// 查询满足要求的总记录数
        $Page       = new \Think\Page($count,20);// 实例化分页类 传入总记录数和每页显示的记录数
        $show       = $Page->show();// 分页显示输出
        $this->assign('_page',$show);
        $sql = "select a.*,b.nickname,c.name from ss_deal_log as a left join ss_member as b on a.member_id=b.uid left join ss_user as c on a.user_id=c.id where {$where} and a.status=1 and a.do_type=1 and a.sell_status=1 order by a.deal_time DESC,a.id DESC limit {$Page->firstRow},{$Page->listRows}";
        $Model = new \Think\Model(); // 实例化一个model对象 没有对应任何数据表
        $deal_list2 = $Model->query($sql); 
        $map = array(
            'status'=>array(
                '0'=>'禁用',
                '1'=>'正常',
                '2'=>'已结清'
            ),
            'do_type'=>array(
                1=>'买入',
                2=>'卖出',
            ),
            'market_type'=>array(
                1=>'深市',
                2=>'沪市',
            )
        );
        int_to_string($deal_list2,$map);
        $userModel = D('User');
        $total_float_win_lost = 0;
        foreach($deal_list2 as $key=>$item){
            //访问股票价格接口
            if($item['market_type']==1){
                $shares_code = 'sz'.$item['shares_code'];
            }else if($item['market_type']==2){
                $shares_code = 'sh'.$item['shares_code'];
            }
            $result = $userModel->sharesApi($shares_code);

            if(is_array($result)){
                $now_price = isset($result['result'][0]['data']['nowPri'])?$result['result'][0]['data']['nowPri']:0;
            }else{
                $now_price = 0;
            }
            $deal_list2[$key]['now_price'] = $now_price;
            $deal_list2[$key]['buy_cost'] = round($deal_list2[$key]['stamp_duty']+$deal_list2[$key]['transfer_fee']+$deal_list2[$key]['entrust_fee']+$deal_list2[$key]['commission'],2);

            $nowDay =  date('Y-m-d',time());
            $buy_time =  date('Y-m-d',$deal_list2[$key]['deal_time']);
            $rate = $user_info['rate'];
            $howDay = diffBetweenTwoDays($nowDay,$buy_time)+1;
            $deal_list2[$key]['interest'] = round($rate*$howDay*$deal_list2[$key]['occupy_money']/10000,3);
            $deal_list2[$key]['now_value'] = $deal_list2[$key]['able_sell_amount']*$deal_list2[$key]['now_price'];//当前市值
            $total_invest = $deal_list2[$key]['able_sell_amount']*$deal_list2[$key]['deal_price']+$deal_list2[$key]['buy_cost']+$deal_list2[$key]['interest']+$deal_list2[$key]['sell_cost'];
            $deal_list2[$key]['float_win_loss'] = round($deal_list2[$key]['now_value']-$total_invest,3);//浮动盈亏
            $deal_list2[$key]['win_loss_ratio'] = number_format($deal_list2[$key]['float_win_loss']/$total_invest*100,2);//盈亏比例
            $total_float_win_lost += $deal_list2[$key]['float_win_loss'];
            //卖出费用
            $sell_stamp_duty = $userModel->count_stamp_duty($deal_list2[$key]['now_value']);//印花税
            $sell_transfer_fee = $userModel->count_transfer_fee($item[$key]['now_value']);//过户费
            $entrust_fee = $userModel->count_entrust_fee(1,$deal_list2[$key]['now_value']); //委托费
            $commission = $userModel->count_commission($deal_list2[$key]['now_value'],$user_info['yongjin_rate']);//佣金
            $deal_list2[$key]['sell_cost'] = round($sell_stamp_duty+$sell_transfer_fee+$entrust_fee+$commission,2);
        }

        $this->assign('_deal_list2',$deal_list2);
        $this->meta_title = '报表';
        $this->display();
    }

    //账户资金
    public function cpital(){
        //先查权限
        $user_info = M('member')->where('uid='.UID)->find();
        if($user_info['level']==1){//超级管理员
            $where = '1=1';
            $where1 = '1=1';
            $salesList = M('sales')->where('status=1')->field('id,title')->select();
            $userList = M('user')->where('status=1')->field('id,name,sales_id')->select();
            $this->assign('_salesList',$salesList);
            $this->assign('_userList',$userList);
        }else if($user_info['level']==2){ //主管
            $uidList = M('member')->where('sales_id='.$user_info['sales_id'])->field('uid')->select();
            $uidStr = '';
            foreach($uidList as $item){
                $uidStr .= $item['uid'].',';
            }
            $uidStr = trim($uidStr,',');
            $where = " a.member_id in ({$uidStr})";
            $where1 = " ss_capital_log.member_id in ({$uidStr})";
            $userList = M('user')->where('status=1 and sales_id='.$user_info['sales_id'])->field('id,name,sales_id')->select();
            $this->assign('_userList',$userList);
        }else{//普通业务员
            $where = ' a.member_id='.UID;
            $where1 = ' ss_capital_log.member_id='.UID;
            $userList = M('user')->where('status=1 and member_id='.$user_info['uid'])->field('id,name,sales_id')->select();
            $this->assign('_userList',$userList);
        }
        //接受参数
        $start_time = strtotime(I('start'));
        $end_time = strtotime(I('end'));
        $sales_id = I('sales_id');
        $user_id = I('user_id');
        $type = I('type');
        if(!empty($start_time)){
            $where .= ' and a.do_time>='.$start_time;
            $where1 .= ' and ss_capital_log.do_time>='.$start_time;
            $this->assign('start',I('start'));
        }else{
            $now_day = date('Y-m-d',time());
            $start_time = strtotime($now_day);
            $where .= ' and a.do_time>='.$start_time;
            $where1 .= ' and ss_capital_log.do_time>='.$start_time;
            $this->assign('start',$now_day.' 00:00:00');
        }
        if(!empty($end_time)){
            $where .= ' and a.do_time<='.$end_time;
            $where1 .= ' and ss_capital_log.do_time<='.$end_time;
            $this->assign('end',I('end'));
        }else{
            $now_day = date('Y-m-d',time());
            $end_time = strtotime($now_day)+24*3600;
            $where .= ' and a.do_time<='.$end_time;
            $where1 .= ' and ss_capital_log.do_time<='.$end_time;
            $this->assign('end',$now_day.' 23:59:59');
        }
        if(!empty($user_id)){
            $where .= ' and a.user_id='.$user_id;
            $where1 .= ' and ss_capital_log.user_id='.$user_id;
            $this->assign('user_id',I('user_id'));
        }
        if(!empty($sales_id)){
            $where .= ' and b.sales_id='.$sales_id;
            $where1 .= ' and b.sales_id='.$sales_id;
            $this->assign('sales_id',I('sales_id'));
        }
        if(!empty($type)){
            $where .= ' and a.type='.$type;
            $where1 .= ' and ss_capital_log.type='.$type;
            $this->assign('type',$type);
        }

        //记得做分页
        $capital_log = M('capital_log');
        $count = $capital_log->join("ss_member as b on ss_capital_log.member_id=b.uid")->where("{$where1} and ss_capital_log.status=1 ")->count('id');// 查询满足要求的总记录数
        $Page       = new \Think\Page($count,20);// 实例化分页类 传入总记录数和每页显示的记录数
        $show       = $Page->show();// 分页显示输出
        $this->assign('_page',$show);
        $sql = "select a.*,b.nickname,c.name from ss_capital_log as a left join ss_member as b on a.member_id=b.uid left join ss_user as c on a.user_id=c.id where {$where} and a.status=1 order by a.do_time DESC,a.id DESC limit {$Page->firstRow},{$Page->listRows}";
        $Model = new \Think\Model(); // 实例化一个model对象 没有对应任何数据表
        $capital_list = $Model->query($sql);
        $map = array(
            'type'=>array(
                1=>'存入保证金',
                2=>'保证金取现',
                3=>'盈亏转本金',
                4=>'月底返息',
                5=>'买入',
                6=>'卖出',
                7=>'盈亏结现',
            )
        );
        int_to_string($capital_list,$map);

        $this->assign('_user_info',$user_info);
        $this->assign('_capital_list',$capital_list);

        $this->display();
    }

    //交易汇总
    public function operate(){
        //先查权限
        $user_info = M('member')->where('uid='.UID)->find();
        if($user_info['level']==1){//超级管理员
            $where = '1=1';
            $where1 = '1=1';
            $salesList = M('sales')->where('status=1')->field('id,title')->select();
            $userList = M('user')->where('status=1')->field('id,name,sales_id')->select();
            $this->assign('_salesList',$salesList);
            $this->assign('_userList',$userList);
        }else if($user_info['level']==2){ //主管
            $uidList = M('member')->where('sales_id='.$user_info['sales_id'])->field('uid')->select();
            $uidStr = '';
            foreach($uidList as $item){
                $uidStr .= $item['uid'].',';
            }
            $uidStr = trim($uidStr,',');
            $where = " a.member_id in ({$uidStr})";
            $where1 = " ss_deal_log.member_id in ({$uidStr})";
            $userList = M('user')->where('status=1 and sales_id='.$user_info['sales_id'])->field('id,name,sales_id')->select();
            $this->assign('_userList',$userList);
        }else{//普通业务员
            $where = ' a.member_id='.UID;
            $where1 = ' ss_deal_log.member_id='.UID;
            $userList = M('user')->where('status=1 and member_id='.$user_info['uid'])->field('id,name,sales_id')->select();
            $this->assign('_userList',$userList);
        }
        //接受参数
        $start_time = strtotime(I('start'));
        $end_time = strtotime(I('end'));
        $sales_id = I('sales_id');
        $user_id = I('user_id');
        if(!empty($start_time)){
            $where .= ' and a.deal_time>='.$start_time;
            $where1 .= ' and ss_deal_log.deal_time>='.$start_time;
            $this->assign('start',I('start'));
        }else{
            $now_day = date('Y-m-d',time());
            $start_time = strtotime($now_day);
            $where .= ' and a.deal_time>='.$start_time;
            $where1 .= ' and ss_deal_log.deal_time>='.$start_time;
            $this->assign('start',$now_day.' 00:00:00');
        }
        if(!empty($end_time)){
            $where .= ' and a.deal_time<='.$end_time;
            $where1 .= ' and ss_deal_log.deal_time<='.$end_time;
            $this->assign('end',I('end'));
        }else{
            $now_day = date('Y-m-d',time());
            $end_time = strtotime($now_day)+24*3600;
            $where .= ' and a.deal_time<='.$end_time;
            $where1 .= ' and ss_deal_log.deal_time<='.$end_time;
            $this->assign('end',$now_day.' 23:59:59');
        }
        if(!empty($user_id)){
            $where .= ' and a.user_id='.$user_id;
            $where1 .= ' and ss_deal_log.user_id='.$user_id;
            $this->assign('user_id',I('user_id'));
        }
        if(!empty($sales_id)){
            $where .= ' and b.sales_id='.$sales_id;
            $where1 .= ' and b.sales_id='.$sales_id;
            $this->assign('sales_id',I('sales_id'));
        }

        $deal_log = M('deal_log');
        $count = $deal_log->join("ss_member as b on ss_deal_log.member_id=b.uid")->where("{$where1} and ss_deal_log.status=1 ")->count('id');// 查询满足要求的总记录数
        $Page       = new \Think\Page($count,20);// 实例化分页类 传入总记录数和每页显示的记录数
        $show       = $Page->show();// 分页显示输出
        $this->assign('_page',$show);
        $sql = "select a.*,b.nickname,c.name from ss_deal_log as a left join ss_member as b on a.member_id=b.uid left join ss_user as c on a.user_id=c.id where {$where} and a.status=1 order by a.deal_time DESC,a.id DESC limit {$Page->firstRow},{$Page->listRows}";
        $Model = new \Think\Model(); // 实例化一个model对象 没有对应任何数据表
        $deal_list = $Model->query($sql);
        $map = array(
            'status'=>array(
                '0'=>'禁用',
                '1'=>'正常',
                '2'=>'已结清'
            ),
            'do_type'=>array(
                1=>'买入',
                2=>'卖出',
            ),
            'market_type'=>array(
                1=>'深市',
                2=>'沪市',
            )
        );
        int_to_string($deal_list,$map);

        $this->assign('_user_info',$user_info);
        $this->assign('_deal_list',$deal_list);

        $this->display();
    }

    //结算汇总
    public function accounts(){
        //先查权限
        $user_info = M('member')->where('uid='.UID)->find();
        if($user_info['level']==1){//超级管理员
            $where = '1=1';
            $where1 = '1=1';
            $salesList = M('sales')->where('status=1')->field('id,title')->select();
            $userList = M('user')->where('status=1')->field('id,name,sales_id')->select();
            $this->assign('_salesList',$salesList);
            $this->assign('_userList',$userList);
        }else if($user_info['level']==2){ //主管
            $uidList = M('member')->where('sales_id='.$user_info['sales_id'])->field('uid')->select();
            $uidStr = '';
            foreach($uidList as $item){
                $uidStr .= $item['uid'].',';
            }
            $uidStr = trim($uidStr,',');
            $where = " a.member_id in ({$uidStr})";
            $where1 = " member_id in ({$uidStr})";
            $userList = M('user')->where('status=1 and sales_id='.$user_info['sales_id'])->field('id,name,sales_id')->select();
            $this->assign('_userList',$userList);
        }else{//普通业务员
            $where = ' a.member_id='.UID;
            $where1 = ' member_id='.UID;
            $userList = M('user')->where('status=1 and member_id='.$user_info['uid'])->field('id,name,sales_id')->select();
            $this->assign('_userList',$userList);
        }
        //接受参数
        $start_time = strtotime(I('start'));
        $end_time = strtotime(I('end'));
        $sales_id = I('sales_id');
        $user_id = I('user_id');
        if(!empty($start_time)){
            $where .= ' and a.do_time>='.$start_time;
            $where1 .= ' and do_time>='.$start_time;
            $this->assign('start',I('start'));
        }else{
            $now_day = date('Y-m-d',time());
            $start_time = strtotime($now_day);
            $where .= ' and a.do_time>='.$start_time;
            $where1 .= ' and do_time>='.$start_time;
            $this->assign('start',$now_day.' 00:00:00');
        }
        if(!empty($end_time)){
            $where .= ' and a.do_time<='.$end_time;
            $where1 .= ' and do_time<='.$end_time;
            $this->assign('end',I('end'));
        }else{
            $now_day = date('Y-m-d',time());
            $end_time = strtotime($now_day)+24*3600;
            $where .= ' and a.do_time<='.$end_time;
            $where1 .= ' and do_time<='.$end_time;
            $this->assign('end',$now_day.' 23:59:59');
        }
        if(!empty($user_id)){
            $where .= ' and a.user_id='.$user_id;
            $where1 .= ' and user_id='.$user_id;
            $this->assign('user_id',I('user_id'));
        }
        if(!empty($sales_id)){
            $where .= ' and b.sales_id='.$sales_id;
            $this->assign('sales_id',I('sales_id'));
        }

        $sql = "select b.sales_id,b.name,a.user_id,sum(a.sell_transfer_fee) as sell_transfer_fee,sum(a.sell_stamp_duty) as sell_stamp_duty,sum(a.sell_entrust_fee) as sell_entrust_fee,sum(a.sell_commission) as sell_commission,sum(a.interest) as interest from ss_summary_log as a left join ss_user as b on a.user_id=b.id where {$where} group by user_id";
        $sql1 = "select b.able_money, b.ensure_money,b.sales_id,b.name,a.user_id,sum(a.buy_transfer_fee) as buy_transfer_fee,sum(a.buy_entrust_fee) as buy_entrust_fee,sum(a.buy_commission) as buy_commission from ss_summary_log as a left join ss_user as b on a.user_id=b.id where {$where} group by user_id";
        $Model = new \Think\Model(); // 实例化一个model对象 没有对应任何数据表
        $account = $Model->query($sql);
        $account1 = $Model->query($sql1);
        $saleList = M('sales')->where('status=1')->select();
        foreach($saleList as $value){
            $saleArr[$value['id']] = $value['title'];
        }
        foreach($account as $value){
            $accountArr[$value['user_id']] = $value;
        }
        foreach($account1 as $value){
            $account1Arr[$value['user_id']] = $value;
        }
        foreach($account1Arr as $key=>$item){
            $data[$key]['name'] = $item['name'];
            $data[$key]['title'] = $saleArr[$item['sales_id']];
            $data[$key]['ensure_money'] = $item['ensure_money'];
            $data[$key]['able_money'] = $item['able_money'];
            $data[$key]['stamp_duty'] = $accountArr[$key]['sell_stamp_duty'];//印花税
            $data[$key]['entrust_fee'] = $accountArr[$key]['sell_entrust_fee']+$item['buy_entrust_fee'];//委托费
            $data[$key]['transfer_fee'] = $accountArr[$key]['sell_transfer_fee']+$item['buy_transfer_fee'];//过户费
            $data[$key]['commission'] = $accountArr[$key]['sell_commission']+$item['buy_commission'];//委托费
            $data[$key]['interest'] = $accountArr[$key]['interest'];//利息
            $data[$key]['total_profit'] = round($accountArr[$key]['interest']+$data[$key]['commission'],2);//利息
        }
        $this->assign('_list',$data);
        $this->display();
    }

    //返息汇总
    public function reinterest(){
        //先查权限
        $user_info = M('member')->where('uid='.UID)->find();
        if($user_info['level']==1){//超级管理员
            $where = '1=1';
            $where1 = '1=1';
            $salesList = M('sales')->where('status=1')->field('id,title')->select();
            $userList = M('user')->where('status=1')->field('id,name,sales_id')->select();
            $this->assign('_salesList',$salesList);
            $this->assign('_userList',$userList);
        }else if($user_info['level']==2){ //主管
            $uidList = M('member')->where('sales_id='.$user_info['sales_id'])->field('uid')->select();
            $uidStr = '';
            foreach($uidList as $item){
                $uidStr .= $item['uid'].',';
            }
            $uidStr = trim($uidStr,',');
            $where = " a.member_id in ({$uidStr})";
            $where1 = " member_id in ({$uidStr})";
            $userList = M('user')->where('status=1 and sales_id='.$user_info['sales_id'])->field('id,name,sales_id')->select();
            $this->assign('_userList',$userList);
        }else{//普通业务员
            $where = ' a.member_id='.UID;
            $where1 = ' member_id='.UID;
            $userList = M('user')->where('status=1 and member_id='.$user_info['uid'])->field('id,name,sales_id')->select();
            $this->assign('_userList',$userList);
        }
        //接受参数
        $start_time = strtotime(I('start'));
        $end_time = strtotime(I('end'));
        $sales_id = I('sales_id');
        $user_id = I('user_id');
        if(!empty($start_time)){
            $where .= ' and a.add_time>='.$start_time;
            $where1 .= ' and add_time>='.$start_time;
            $this->assign('start',I('start'));
        }else{
            $now_day = date('Y-m-d',time());
            $start_time = strtotime($now_day);
            $where .= ' and a.add_time>='.$start_time;
            $where1 .= ' and add_time>='.$start_time;
            $this->assign('start',$now_day.' 00:00:00');
        }
        if(!empty($end_time)){
            $where .= ' and a.add_time<='.$end_time;
            $where1 .= ' and add_time<='.$end_time;
            $this->assign('end',I('end'));
        }else{
            $now_day = date('Y-m-d',time());
            $end_time = strtotime($now_day)+24*3600;
            $where .= ' and a.add_time<='.$end_time;
            $where1 .= ' and add_time<='.$end_time;
            $this->assign('end',$now_day.' 23:59:59');
        }
        if(!empty($user_id)){
            $where .= ' and a.user_id='.$user_id;
            $where1 .= ' and user_id='.$user_id;
            $this->assign('user_id',I('user_id'));
        }
        if(!empty($sales_id)){
            $where .= ' and b.sales_id='.$sales_id;
            $this->assign('sales_id',I('sales_id'));
        }

        $sql = "select sum(a.day_interest) as total_interest,sum(a.return_interest) as total_reiterest,b.name,b.rate,c.nickname from ss_return_interest_log as a left join ss_user as b on a.user_id=b.id left join ss_member as c on a.member_id=c.uid where {$where} and b.status=1 group by user_id";
        $Model = new \Think\Model(); // 实例化一个model对象 没有对应任何数据表
        $resList = $Model->query($sql);
        $map = array(
            'status'=>array(
                1=>'未返息',
                2=>'已返息',
            )
        );
        int_to_string($resList,$map);
        $this->assign('_list',$resList);
        $this->display();
    }

    public function test(){
        $userModel = D('User');
        echo $userModel->count_commission(34740.00,0.80);
    }
}