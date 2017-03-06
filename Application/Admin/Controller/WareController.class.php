<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/2/4
 * Time: 19:15
 */
namespace Admin\Controller;

/**
 * 后台预警控制器
 * @author yhy  <494044011@qq.com>
 */
class WareController extends AdminController {

    //盈亏总汇
    public function  index(){
        //先查权限
        $user_info = M('member')->where('uid='.UID)->find();
        if($user_info['level']==1){//超级管理员
            $where = '1=1';
            $salesList = M('sales')->where('status=1')->field('id,title')->select();
            $user_list = M('user')->where('status=1')->select();
            $this->assign('_salesList',$salesList);
            $this->assign('_userList',$user_list);
        }else if($user_info['level']==2){ //主管
            $uidList = M('member')->where('sales_id='.$user_info['sales_id'])->field('uid')->select();
            $uidStr = '';
            foreach($uidList as $item){
                $uidStr .= $item['uid'].',';
            }
            $uidStr = trim($uidStr,',');
            $where = " member_id in ({$uidStr})";
            $user_list = M('user')->where('status=1 and sales_id='.$user_info['sales_id'])->select();
            $this->assign('_userList',$user_list);
        }else{//普通业务员
            $where = ' member_id='.UID;
            $user_list = M('user')->where('status=1 and member_id='.$user_info['uid'])->select();
            $this->assign('_userList',$user_list);
        }

        //接受参数
        $sales_id = I('sales_id');
        $user_id = I('user_id');
        if(!empty($user_id)){
            $where .= ' and id='.$user_id;
            $this->assign('user_id',I('user_id'));
        }
        if(!empty($sales_id) && $user_info['level']==1){
            $uidList = M('member')->where('sales_id='.$sales_id)->field('uid')->select();
            $uidStr = '';
            foreach($uidList as $item){
                $uidStr .= $item['uid'].',';
            }
            $uidStr = trim($uidStr,',');
            $where .= " and member_id in ({$uidStr})";
            $this->assign('sales_id',I('sales_id'));
        }

        $user_list = M('user')->where($where.' and status=1')->select();
        $userModel = D('User');
        $nowDay =   date('Y-m-d',time());
        $redNum = C('RED_NUM');
        $blueNum = C('BLUE_NUM');
        foreach($user_list as $key=>$item){
            $dealArr = M('deal_log')->where('user_id='.$item['id'].' and sell_status=1 and status<>3')->select();
            $chengben = 0;
            $now_value = 0;
            $assess_cost = 0;
            $assess_interest = 0;
            $occupy_money = 0;
            $total_data = array();
            foreach($dealArr as $va){
                if($va['market_type']==1){
                    $shares_code = 'sz'.$va['shares_code'];
                }else if($va['market_type']==2){
                    $shares_code = 'sh'.$va['shares_code'];
                }
                //费用统计
                $result = $userModel->sharesApi($shares_code);
                if(!is_array($result)) continue;
//                if(!is_array($result)) $now_price= $va['deal_price'];
                $now_price = $result['result'][0]['data']['nowPri'];
                $sell_money = $now_price*$va['able_sell_amount'];
                $now_value += $sell_money;
                $chengben += $va['able_sell_amount']*$va['deal_price']+$va['stamp_duty']+$va['transfer_fee']+$va['entrust_fee']+$va['commission'];

                $sell_stamp_duty = $userModel->count_stamp_duty($sell_money);//印花税
                $sell_transfer_fee = $userModel->count_transfer_fee($sell_money); //过户费
                $sell_entrust_fee = $userModel->count_entrust_fee(1,$sell_money); //委托费
                $sell_commission = $userModel->count_commission($sell_money, $item['yongjin_rate']);//佣金
                $buy_time =  date('Y-m-d',$va['deal_time']);//买入时间
                $howDay = diffBetweenTwoDays($nowDay,$buy_time)+1;
                $interest = $item['rate']*$howDay*$va['occupy_money']/10000;//利息
                $assess_cost += $sell_entrust_fee+$sell_transfer_fee+$sell_stamp_duty+$sell_commission;
                $assess_interest += $interest;
                $occupy_money += $va['occupy_money'];
            }
            $user_list[$key]['chengben'] = $chengben;  //持股成本
            $user_list[$key]['now_value'] = $now_value;//当前市值
            $user_list[$key]['assess_cost'] = $assess_cost;  //预估费用
            $user_list[$key]['assess_interest'] = $assess_interest; //预估利息
            $user_list[$key]['float_win_loss'] = $user_list[$key]['now_value']-$user_list[$key]['chengben']-$user_list[$key]['assess_cost']-$user_list[$key]['assess_interest'] ;//浮动盈亏
            $total_invest = $user_list[$key]['chengben']+$user_list[$key]['assess_cost']+ $user_list[$key]['assess_interest'];//总投资成本
            $user_list[$key]['win_loss_ratio'] = number_format($user_list[$key]['float_win_loss']/$total_invest*100,2);//盈亏比例
            $user_list[$key]['float_ensure_money'] =  $user_list[$key]['float_win_loss']+$item['ensure_money'];//浮动保证金
            if($user_list[$key]['now_value']==0){
                $user_list[$key]['safe_line'] = 99.9;
            }else{
                $user_list[$key]['safe_line'] =  number_format($user_list[$key]['float_ensure_money']/$user_list[$key]['now_value']*100,2);//安全界限
            }
            $user_list[$key]['float_able_money'] = $item['able_money']+$user_list[$key]['win_loss_ratio']*$item['pledge'];//浮动可用资金
//            $user_list[$key]['beilv'] = number_format($occupy_money/($item['ensure_money']*$item['pledge']),2);//倍率
            $user_list[$key]['beilv'] = number_format($occupy_money/$item['ensure_money'],2);//倍率
            if($user_list[$key]['safe_line']>$redNum){
                $user_list[$key]['color'] = 'blue';
                $user_list[$key]['background'] = '';
            }else if($user_list[$key]['safe_line']<=$redNum && $user_list[$key]['safe_line']>$blueNum){
                $user_list[$key]['color'] = 'yellow';
                $user_list[$key]['background'] = '';
            }else{
//                $user_list[$key]['color'] = 'white';
                $user_list[$key]['color'] = 'red';
                $user_list[$key]['background'] = '#9F0F05';
            }
//            $total_data[0] += 
        }
        $this->assign('_red',$redNum);
        $this->assign('_blue',$blueNum);
        $this->assign('_user_list',$user_list);
        $this->meta_title = '报表';
        $this->display();
    }

    //设置安全界限颜色
    public function setFit(){
        header("content-type:text/html;charset=utf-8");
        $redNum = I('red');
        $blueNum = I('blue');
        if($redNum<=$blueNum){
            echo "<script>alert('警戒线不能小于平仓线！请重新设置！');history.go(-1);</script>";
        }
       M('config')->where("name='RED_NUM'")->save(array('value'=>$redNum));
       M('config')->where("name='BLUE_NUM'")->save(array('value'=>$blueNum));
       S('DB_CONFIG_DATA',null);
       echo "<script>location.href='/admin.php?s=/Ware/index'</script>";
    }
}