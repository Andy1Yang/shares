<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/1/8
 * Time: 17:05
 */
namespace Admin\Controller;

/**
 * 后台操盘控制器
 * @author yhy  <494044011@qq.com>
 */
class OperateController extends AdminController {

    //交易页面
    public function  index(){
        //获得左边营业部门和对应用户（账户人员）
        $menu_list = D('User')->get_left_menu_sales(UID,'Operate');
        $this->assign('_menu_list',$menu_list);

        //获得用户信息
        $menuArr = array_shift($menu_list);
        $id = I('id',$menuArr[0]['id']);
        if(!empty($id)){
            $user_info = M('user')->where("id={$id}")->find();
            //记得做分页
            $deal_log = M('deal_log');
            $p1 = intval(I('p1',1));
            $count = $deal_log->where("user_id={$id} and status=1 ")->count('id');// 查询满足要求的总记录数
            $allPage1 = ceil($count/6);
            $start1 = ($p1-1)*6;
            $this->assign('_allPage1',$allPage1);
            $this->assign('_p1',$p1);
            $sql = "select a.*,b.nickname from ss_deal_log as a left join ss_member as b on a.member_id=b.uid where a.user_id={$id} and a.status=1 order by a.deal_time DESC,a.id DESC limit {$start1},6";
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

            //待卖出列表
            $p2 = intval(I('p2',1));
            $count = $deal_log->where("user_id={$id} and status=1 and do_type=1 and sell_status=1")->count('id');// 查询满足要求的总记录数
            $allPage2 = ceil($count/4);
            $start2 = ($p2-1)*4;
            $this->assign('_allPage2',$allPage2);
            $this->assign('_p2',$p2);
            $sql = "select a.*,b.nickname from ss_deal_log as a left join ss_member as b on a.member_id=b.uid where a.user_id={$id} and a.status=1 and a.do_type=1 and a.sell_status=1 order by a.deal_time DESC,a.id DESC limit {$start2},4";
            $Model = new \Think\Model(); // 实例化一个model对象 没有对应任何数据表
            $deal_list2 = $Model->query($sql);
            int_to_string($deal_list2,$map);
            $userModel = D('User');
            $total_float_win_lost = 0;
            $tonight = strtotime(date('Y-m-d',time()));
            foreach($deal_list2 as $key=>$item){
                if($item['deal_time']>$tonight){
                    $deal_list2[$key]['is_sell'] = 2;
                }else{
                    $deal_list2[$key]['is_sell'] = 1;
                }
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
                //卖出费用
                $sell_stamp_duty = $userModel->count_stamp_duty($deal_list2[$key]['now_value']);
                if($item['market_type']==1){//深圳
                    $sell_transfer_fee = 0;
                    $entrust_fee = $userModel->count_entrust_fee(1);
                }else{//上海
                    $sell_transfer_fee = $userModel->count_transfer_fee($item[$key]['able_sell_amount']);
                    $entrust_fee = $userModel->count_entrust_fee(2);
                }
                $commission = $userModel->count_commission($deal_list2[$key]['now_value'],$user_info['yongjin_rate']);
                $deal_list2[$key]['sell_cost'] = round($sell_stamp_duty+$sell_transfer_fee+$entrust_fee+$commission,2);
                $total_invest = $deal_list2[$key]['able_sell_amount']*$deal_list2[$key]['deal_price']+$deal_list2[$key]['buy_cost']+$deal_list2[$key]['interest']+$deal_list2[$key]['sell_cost'];
                $deal_list2[$key]['float_win_loss'] = round($deal_list2[$key]['now_value']-$total_invest,3);//浮动盈亏
                $deal_list2[$key]['win_loss_ratio'] = number_format($deal_list2[$key]['float_win_loss']/$user_info['ensure_money']*100,2);//盈亏比例
                $total_float_win_lost += $deal_list2[$key]['float_win_loss'];
            }
        }else{
            $user_info = array();
            $deal_list = array();
            $deal_list2 = array();
        }

        $this->assign('_total_float_win_lost',$total_float_win_lost);
        $this->assign('_user_info',$user_info);
        $this->assign('_deal_list',$deal_list);
        $this->assign('_deal_list2',$deal_list2);

        $this->meta_title = '交易管理';
        $this->display();
    }

    //买入
    public function buy(){

        $user_id =  I('user_id');
        $data['shares_code'] = I('shares_code');
        $data['shares_name'] = I('shares_name');
        $data['market_type'] = I('market_type');
        $data['deal_time'] = strtotime(I('deal_time'));
        $data['deal_amount'] = I('deal_amount');
        $data['able_sell_amount'] = I('deal_amount');
        $data['deal_price'] = I('deal_price');
//        $data['is_account'] = I('is_account');
        header("content-type:text/html;charset=utf-8");
        foreach($data as $item){
            if(empty($item)){
                echo "<script>alert('买入信息请填写完整！');history.go(-1);</script>";exit;
            }
        }
//        $data['stamp_duty'] = I('stamp_duty');
//        $data['entrust_fee'] = I('entrust_fee');
        $data['remarks'] = I('remarks');
        $data['do_type'] = 1;
        $happen_money = $data['deal_amount']*$data['deal_price'];
        $data['deal_money'] = $happen_money;
        $data['user_id'] = $user_id;
        $data['member_id'] = UID;

        //查询用户表
        $yuanArr = M('user')->where('id='.$user_id)->field('ensure_money,able_money,pledge,yongjin_rate')->find();
        //买入费用
        $userModel = D('User');
        if($data['market_type']==1){//深圳
            $data['entrust_fee'] = $userModel->count_entrust_fee(1);
        }else{//上海
            $data['transfer_fee'] = $userModel->count_transfer_fee($data['deal_amount']); //过户费
            $data['entrust_fee'] = $userModel->count_entrust_fee(2); //委托费
        }
        $data['commission'] = $userModel->count_commission($happen_money,$yuanArr['yongjin_rate']);//佣金
        $data['occupy_money'] = $happen_money+$data['stamp_duty']+$data['transfer_fee']+$data['entrust_fee']+$data['commission'];//占用资金

        //修改用户表  可用资金
        $udata['able_money'] = $yuanArr['able_money']-$happen_money- $data['stamp_duty']-$data['transfer_fee']-$data['entrust_fee']-$data['commission'];
        $bool = M('user')->where('id='.$user_id)->save($udata);

        //添加结算流水表
        $sdata = array();
        $sdata['user_id'] = $user_id;
        $sdata['shares_code'] =  $data['shares_code'];
        $sdata['shares_name'] =  $data['shares_name'];
        $sdata['buy_money'] = $happen_money;
        $sdata['buy_cost'] = $data['stamp_duty']+$data['transfer_fee']+$data['entrust_fee']+$data['commission'];
        $sdata['deal_price'] = $data['deal_price'];
        $sdata['do_time'] = time();//操作时间
        $sdata['member_id'] = UID;
        $sdata['buy_time'] = $data['deal_time'];
        $sdata['buy_amount'] = $data['deal_amount'];
        $sdata['buy_deal_price'] = $data['deal_price'];
        $sdata['buy_transfer_fee'] = $data['transfer_fee'];
        $sdata['buy_entrust_fee'] = $data['entrust_fee'];
        $sdata['buy_commission'] = $data['commission'];
        $sdata['occupy_money'] = $data['occupy_money'];
        $bool4 = M('summary_log')->add($sdata);

        //添加资金流水
        if($bool4){
            $cdata['user_id'] = $user_id;
            $cdata['happen_money'] = -$data['occupy_money'];
            $cdata['do_time'] =  $data['deal_time'];
            $cdata['remarks'] =  $data['remarks'];
            $cdata['ensure_money'] = $yuanArr['ensure_money'];
            $cdata['able_money'] = $udata['able_money'];
            $yestedayNight = strtotime(date('Y-m-d',time()));
            $preNum = M('capital_log')->where('user_id='. $cdata['user_id'].' and do_time>'.$yestedayNight)->count();
            $number = sprintf("%04d",$preNum+1);
            $cdata['deal_code'] = date('Ymd',time()).$number;
            $cdata['member_id'] = UID;
            $cdata['type'] = 5;
            $cdata['status'] = 1;
            $bool2 = M('capital_log')->add($cdata);
        }else{
            echo "<script>alert('买入失败！结算流水添加失败！');history.go(-1);</script>";exit;
        }

        //添加收益表
        $day = date('Y-m-d',time());
        $profitArr = M('profit_log')->where("add_time='{$day}' and user_id={$user_id}")->find();
        $pdata['user_id'] = $user_id;
        $pdata['member_id'] = UID;
        $pdata['add_time'] = $day;
        if($profitArr){
            $pdata['total_yongjin'] = $profitArr['total_yongjin']+$data['commission'];
            $bool5 = M('profit_log')->where("add_time='{$day}' and user_id={$user_id}")->save($pdata);
        }else{
            $pdata['total_yongjin'] = $data['commission'];
            $bool5 = M('profit_log')->add($pdata);
        }

        //添加交易流水
        $data['summary_id'] = $bool4;
        $bool3 = M('deal_log')->add($data);
        if($bool && $bool2 && $bool3 && $bool5){
            echo "<script>alert('买入成功！');location.href='/admin.php?s=/Operate/index/id/{$user_id}'</script>";
        }else{
            echo "<script>alert('买入失败！');history.go(-1);</script>";exit;
        }
    }

    //卖出
    public function sell(){
        $id = I('id');
        $sell_amount = I('sell_amount');
        $sell_price = I('sell_price');
        $market_type = I('market_type');
        $freeInterest = I('free_interest',0);
        $sell_time = strtotime(I('sell_time'));
        $dealArr = M('deal_log')->where('id='.$id)->find();//买入信息
        header("content-type:text/html;charset=utf-8");
        if($dealArr){
            if($sell_amount>$dealArr['able_sell_amount']){
                echo "<script>alert('卖出失败！可卖数量不足！');history.go(-1);</script>";exit;
            }else{
                $user_info = M('user')->where('id='.$dealArr['user_id'])->find();//客户信息
                $sresult = M('summary_log')->where('(status=2 or status=1) and id='.$dealArr['summary_id'])->find();//结算信息
                $flaut = 'id';
                if(!$sresult){
                    $sresult = M('summary_log')->where('status=2 and summary_id='.$dealArr['summary_id'])->find();//结算信息
                    $flaut = 'summary_id';
                }
                $udata = array();
                $sell_money = $sell_amount*$sell_price;
                if($sell_amount==$dealArr['able_sell_amount']){//全卖出
                    //个人账户添加钱
                    $sell_cost = I('sell_cost');//卖出费用
                    $interest = I('interest');//利息
                    $interest = $interest-$freeInterest;
                    $win_loss = $sell_amount*($sell_price-$dealArr['deal_price'])-$interest-$sell_cost-$sresult['buy_cost'];//盈亏金额
                    $udata['able_money'] = $user_info['able_money']+$sell_money-$sell_cost-$interest;
                    if(!M('user')->where('id='.$dealArr['user_id'])->save($udata)){
                        echo "<script>alert('卖出失败！个人账户加钱失败！');history.go(-1);</script>";exit;
                    }
                    //结算流水修改
                    $sdata = array();
                    $userModel = D('User');
                    if(!$sresult){
                        $sdata['sell_money'] = $sell_money;
                        $sdata['sell_cost'] = $sell_cost;
                        $sdata['interest'] = $interest;
                        $sdata['win_loss'] = $win_loss;
                        $sdata['sell_time'] = $sell_time;
                        $sdata['status'] = 6;
                        $sdata['sell_amount'] = $sell_amount;
                        $sdata['sell_deal_price'] = $sell_price;//应该去查多次的价格然后平均
                        $sell_stamp_duty = $userModel->count_stamp_duty($sell_money);
                        if ($market_type == 1) {//深圳
                            $sell_entrust_fee = $userModel->count_entrust_fee(1);
                        } else {//上海
                            $sell_transfer_fee = $userModel->count_transfer_fee($sdata['sell_amount']); //过户费
                            $sell_entrust_fee = $userModel->count_entrust_fee(2); //委托费
                        }
                        $sell_commission = $userModel->count_commission($sdata['sell_money'], $user_info['yongjin_rate']);//佣金
                        $sdata['sell_transfer_fee'] = $sell_transfer_fee;
                        $sdata['sell_entrust_fee'] = $sell_entrust_fee;
                        $sdata['sell_commission'] = $sell_commission;
                        $sdata['sell_stamp_duty'] = $sell_stamp_duty;
                        $sdata['summary_id'] = $dealArr['summary_id'];

                        $sdata['user_id'] = $dealArr['user_id'];
                        $sdata['shares_code'] =  $dealArr['shares_code'];
                        $sdata['shares_name'] =  $dealArr['shares_name'];
                        $sdata['buy_money'] = $dealArr['deal_money'];
                        $sdata['buy_cost'] = $dealArr['stamp_duty']+$dealArr['transfer_fee']+$dealArr['entrust_fee']+$dealArr['commission'];
                        $sdata['deal_price'] = $dealArr['deal_price'];
                        $sdata['do_time'] = time();//操作时间
                        $sdata['member_id'] = UID;
                        $sdata['buy_time'] = $dealArr['deal_time'];
                        $sdata['buy_amount'] = $dealArr['deal_amount'];
                        $sdata['buy_deal_price'] = $dealArr['deal_price'];
                        $sdata['buy_transfer_fee'] = $dealArr['transfer_fee'];
                        $sdata['buy_entrust_fee'] = $dealArr['entrust_fee'];
                        $sdata['buy_commission'] = $dealArr['commission'];
                        $sdata['occupy_money'] = (1-$sell_amount/$dealArr['able_sell_amount'])*$dealArr['occupy_money'];

                        if(!M('summary_log')->add($sdata)){
                            echo "<script>alert('卖出失败！结算流水修改失败！');history.go(-1);</script>";exit;
                        }
                    }else {
                        $sdata['sell_money'] = $sresult['sell_money'] + $sell_money;
                        $sdata['sell_cost'] = $sresult['sell_cost'] + $sell_cost;
                        $sdata['interest'] = $sresult['interest'] + $interest;
                        $sdata['win_loss'] = $sresult['win_loss'] + $win_loss;
                        $sdata['sell_time'] = $sell_time;
                        $sdata['status'] = 6;
                        $sdata['do_time'] = time();//操作时间
                        $nowDay =  date('Y-m-d',strtotime(I('sell_time')));
                        $buy_time = date('Y-m-d', $dealArr['deal_time']);//买入时间
                        $howDay = diffBetweenTwoDays($nowDay, $buy_time) + 1;
                        $sdata['occupy_day'] = $howDay;//只算开始和结束时间，中间有可能有多卖一次
                        $sdata['sell_amount'] = $sresult['sell_amount'] + $sell_amount;
                        $sdata['sell_deal_price'] = $sell_price;//应该去查多次的价格然后平均
                        $sell_stamp_duty = $userModel->count_stamp_duty($sell_money);
                        if ($market_type == 1) {//深圳
                            $sell_entrust_fee = $userModel->count_entrust_fee(1);
                        } else {//上海
                            $sell_transfer_fee = $userModel->count_transfer_fee($sdata['sell_amount']); //过户费
                            $sell_entrust_fee = $userModel->count_entrust_fee(2); //委托费
                        }
                        $sell_commission = $userModel->count_commission($sdata['sell_money'], $user_info['yongjin_rate']);//佣金
                        $sdata['sell_transfer_fee'] = $sresult['sell_transfer_fee'] + $sell_transfer_fee;
                        $sdata['sell_entrust_fee'] = $sresult['sell_entrust_fee'] + $sell_entrust_fee;
                        $sdata['sell_commission'] = $sresult['sell_commission'] + $sell_commission;
                        $sdata['sell_stamp_duty'] = $sresult['sell_stamp_duty'] + $sell_stamp_duty;
                        if (!M('summary_log')->where("(status=2 or status=1) and {$flaut}=".$dealArr['summary_id'])->save($sdata)) {
                            echo "<script>alert('卖出失败！结算流水修改失败！');history.go(-1);</script>";
                            exit;
                        }
                    }

                    //添加收益表
                    $day = date('Y-m-d',time());
                    $profitArr = M('profit_log')->where("add_time='{$day}' and user_id={$dealArr['user_id']}")->find();
                    $pdata['user_id'] = $dealArr['user_id'];
                    $pdata['member_id'] = UID;
                    $pdata['add_time'] = $day;
                    if($profitArr){
                        $pdata['total_yongjin'] = $profitArr['total_yongjin']+$sell_commission;
                        $pdata['total_interest'] = $profitArr['total_interest']+$interest;
                        $bool5 = M('profit_log')->where("add_time='{$day}' and user_id={$dealArr['user_id']}")->save($pdata);
                    }else{
                        $pdata['total_yongjin'] = $sell_commission;
                        $pdata['total_interest'] = $interest;
                        $bool5 = M('profit_log')->add($pdata);
                    }
                    if(!$bool5){
                        echo "<script>alert('卖出失败！添加收益表失败！');history.go(-1);</script>";exit;
                    }
                    //修改交易流水买入记录   不可卖了
                    $jdata = array();
                    $jdata['able_sell_amount'] = $dealArr['able_sell_amount']-$sell_amount;
                    $jdata['sell_status'] = 2;
                    $jdata['occupy_money'] = 0;
                    if(!M('deal_log')->where('id='.$dealArr['id'])->save($jdata)){
                        echo "<script>alert('卖出失败！修改交易流水失败！');history.go(-1);</script>";exit;
                    }

                }else{
                    //个人账户添加钱
                    $userModel = D('User');
                    $sell_stamp_duty = $userModel->count_stamp_duty($sell_money);
                    if($market_type==1){//深圳
                        $sell_entrust_fee = $userModel->count_entrust_fee(1);
                    }else{//上海
                        $sell_transfer_fee = $userModel->count_transfer_fee($sell_amount); //过户费
                        $sell_entrust_fee = $userModel->count_entrust_fee(2); //委托费
                    }
                    $sell_commission = $userModel->count_commission($sell_money,$user_info['yongjin_rate']);//佣金
                    $sell_cost = $sell_stamp_duty+$sell_transfer_fee+$sell_entrust_fee+$sell_commission;//卖出费用
                    $nowDay =  date('Y-m-d',strtotime(I('sell_time')));
                    $buy_time =  date('Y-m-d',$dealArr['deal_time']);//买入时间
                    $rate = $user_info['rate'];
                    $howDay = diffBetweenTwoDays($nowDay,$buy_time)+1;
                    $foccupyMoney = ($sell_amount/$dealArr['able_sell_amount'])*$dealArr['occupy_money'];
                    $interest = $rate*$howDay*$foccupyMoney/10000-$freeInterest;//利息
                    $interest = $rate*$howDay*$foccupyMoney/10000-$freeInterest;//利息
                    $win_loss = $sell_amount*($sell_price-$dealArr['deal_price'])-$interest-$sell_cost;//盈亏金额
                    $udata['able_money'] = $user_info['able_money']+$sell_money-$sell_cost-$interest;
                    if(!M('user')->where('id='.$dealArr['user_id'])->save($udata)){
                        echo "<script>alert('卖出失败！个人账户加钱失败！');history.go(-1);</script>";exit;
                    }
                    //结算流水修改
                    $sdata = array();
                    if(!$sresult){
                        $sdata['sell_money'] = $sell_money;
                        $sdata['sell_cost'] = $sell_cost;
                        $sdata['interest'] = $interest;
                        $sdata['win_loss'] = $win_loss;
                        $sdata['sell_time'] = $sell_time;
                        $sdata['status'] = 2;
                        $sdata['sell_amount'] = $sell_amount;
                        $sdata['sell_deal_price'] = $sell_price;//应该去查多次的价格然后平均
                        $sdata['sell_transfer_fee'] = $sell_transfer_fee;
                        $sdata['sell_entrust_fee'] = $sell_entrust_fee;
                        $sdata['sell_commission'] = $sell_commission;
                        $sdata['sell_stamp_duty'] = $sell_stamp_duty;
                        $sdata['summary_id'] = $dealArr['summary_id'];

                        $sdata['user_id'] = $dealArr['user_id'];
                        $sdata['shares_code'] =  $dealArr['shares_code'];
                        $sdata['shares_name'] =  $dealArr['shares_name'];
                        $sdata['buy_money'] = $dealArr['deal_money'];
                        $sdata['buy_cost'] = $dealArr['stamp_duty']+$dealArr['transfer_fee']+$dealArr['entrust_fee']+$dealArr['commission'];
                        $sdata['deal_price'] = $dealArr['deal_price'];
                        $sdata['do_time'] = time();//操作时间
                        $sdata['member_id'] = UID;
                        $sdata['buy_time'] = $dealArr['deal_time'];
                        $sdata['buy_amount'] = $dealArr['deal_amount'];
                        $sdata['buy_deal_price'] = $dealArr['deal_price'];
                        $sdata['buy_transfer_fee'] = $dealArr['transfer_fee'];
                        $sdata['buy_entrust_fee'] = $dealArr['entrust_fee'];
                        $sdata['buy_commission'] = $dealArr['commission'];
                        $sdata['occupy_money'] = (1-$sell_amount/$dealArr['able_sell_amount'])*$dealArr['occupy_money'];

                        if(!M('summary_log')->add($sdata)){
                            echo "<script>alert('卖出失败！结算流水修改失败！');history.go(-1);</script>";exit;
                        }
                    }else{
                        $sdata['sell_money'] = $sresult['sell_money']+$sell_money;
                        $sdata['sell_cost'] = $sresult['sell_cost']+$sell_cost;
                        $sdata['interest'] = $sresult['interest']+$interest;
                        $sdata['win_loss'] = $sresult['win_loss']+$win_loss;
                        $sdata['sell_time'] = $sell_time;
                        $sdata['status'] = 2;
                        $sdata['sell_amount'] = $sresult['sell_amount']+$sell_amount;
                        $sdata['sell_deal_price'] = $sell_price;//应该去查多次的价格然后平均
                        $sdata['sell_transfer_fee'] = $sresult['sell_transfer_fee']+$sell_transfer_fee;
                        $sdata['sell_entrust_fee'] = $sresult['sell_entrust_fee']+$sell_entrust_fee;
                        $sdata['sell_commission'] = $sresult['sell_commission']+$sell_commission;
                        $sdata['sell_stamp_duty'] = $sresult['sell_stamp_duty']+$sell_stamp_duty;
                        $sdata['occupy_money'] = (1-$sell_amount/$dealArr['able_sell_amount'])*$dealArr['occupy_money'];
                        if(!M('summary_log')->where("(status=2 or status=1) and {$flaut}=".$dealArr['summary_id'])->save($sdata)){
                            echo "<script>alert('卖出失败！结算流水修改失败！');history.go(-1);</script>";exit;
                        }
                    }

                    //添加收益表
                    $day = date('Y-m-d',time());
                    $profitArr = M('profit_log')->where("add_time='{$day}' and user_id={$dealArr['user_id']}")->find();
                    $pdata['user_id'] = $dealArr['user_id'];
                    $pdata['member_id'] = UID;
                    $pdata['add_time'] = $day;
                    if($profitArr){
                        $pdata['total_yongjin'] = $profitArr['total_yongjin']+$sell_commission;
                        $pdata['total_interest'] = $profitArr['total_interest']+$interest;
                        $bool5 = M('profit_log')->where("add_time='{$day}' and user_id={$dealArr['user_id']}")->save($pdata);
                    }else{
                        $pdata['total_yongjin'] = $sell_commission;
                        $pdata['total_interest'] = $interest;
                        $bool5 = M('profit_log')->add($pdata);
                    }
                    if(!$bool5){
                        echo "<script>alert('卖出失败！添加收益表失败！');history.go(-1);</script>";exit;
                    }
                    //修改交易流水买入记录   只修改部分
                    $jdata = array();
                    $jdata['able_sell_amount'] = $dealArr['able_sell_amount']-$sell_amount;
                    $occupy_money = (1-$sell_amount/$dealArr['able_sell_amount'])*$dealArr['occupy_money'];
                    $jdata['occupy_money'] = $occupy_money<0?0:$occupy_money;
                    if(!M('deal_log')->where('id='.$dealArr['id'])->save($jdata)){
                        echo "<script>alert('卖出失败！修改交易流水失败！');history.go(-1);</script>";exit;
                    }
                }
                //资金流水记录
                $cdata['user_id'] = $dealArr['user_id'];
                $cdata['happen_money'] = $sell_money-$sell_cost-$interest;
                $cdata['do_time'] =  time();
                $cdata['ensure_money'] = $user_info['ensure_money'];
                $cdata['able_money'] = $udata['able_money'];
                $yestedayNight = strtotime(date('Y-m-d',time()));
                $preNum = M('capital_log')->where('user_id='. $cdata['user_id'].' and do_time>'.$yestedayNight)->count();
                $number = sprintf("%04d",$preNum+1);
                $cdata['deal_code'] = date('Ymd',time()).$number;
                $cdata['member_id'] = UID;
                $cdata['type'] = 6;
                $cdata['status'] = 1;
                if(!M('capital_log')->add($cdata)){
                    echo "<script>alert('卖出失败！资金流水记录添加失败！');history.go(-1);</script>";exit;
                }

                //添加交易流水卖出记录
                $ddata = $dealArr;
                unset($ddata['id']);
                $ddata['do_type'] = 2;
                $ddata['deal_amount'] = $sell_amount;
                $ddata['able_sell_amount'] = $dealArr['deal_amount']-$sell_amount;
                $ddata['occupy_money'] = $jdata['occupy_money'];
                $ddata['deal_price'] = $sell_price;
                $ddata['stamp_duty'] = $sell_stamp_duty;
                $ddata['transfer_fee'] = $sell_transfer_fee;
                $ddata['entrust_fee'] = $sell_entrust_fee;
                $ddata['commission'] = $sell_commission;
                $ddata['deal_money'] = $sell_price*$sell_amount;
                $ddata['deal_time'] = $sell_time;
                $ddata['member_id'] = UID;
                $ddata['sell_status'] = 3;
                if(!M('deal_log')->add($ddata)){
                    echo "<script>alert('卖出失败！添加交易流水卖出记录失败！');history.go(-1);</script>";exit;
                }else{
                    echo "<script>alert('卖出成功！');location.href='/admin.php?s=/Operate/index/id/{$dealArr['user_id']}'</script>";
                }
            }
        }else{
            echo "<script>alert('卖出失败！无买入此股票！');history.go(-1);</script>";exit;
        }
    }

    //修改
    public function edit(){
        //获得左边营业部门和对应用户（账户人员）
        $menu_list = D('User')->get_left_menu_sales(UID,'Operate');
        $this->assign('_menu_list',$menu_list);

        $id = I('id');
        $is_edit = I('is_edit');
        if($is_edit==1){
            $user_id =  I('user_id');
            $data['shares_code'] =  I('shares_code');
            $data['shares_name'] =  I('shares_name');
            $data['market_type'] =  I('market_type');
            $data['deal_amount'] =  I('deal_amount');
            $data['deal_price'] =  I('deal_price');
            $data['stamp_duty'] =  I('stamp_duty');
            $data['transfer_fee'] = I('transfer_fee');
            $data['entrust_fee'] = I('entrust_fee');
            $data['commission'] = I('commission');
            $data['deal_money'] = I('deal_money');
            $data['deal_time'] = strtotime(I('deal_time'));
            $data['member_id'] = I('member_id');
            $data['status'] = I('status');
            $bool = M('deal_log')->where('id='.$id)->save($data);
            if($bool){
                $this->success('修改成功！',"/admin.php?s=/Operate/index/id/{$user_id}");
            }else{
                $this->error('修改失败！');
            }
        }else{
            $dealArr = M('deal_log')->where('id='.$id)->find();
            $memberArr = M('member')->field('uid,nickname')->select();
            $this->assign('_member_list',$memberArr);
            $this->meta_title = '修改交易流水';
            $this->assign('_res',$dealArr);
            $this->display();
        }
    }

    //删除
    public function del(){
        $id = I('id');
        $uid = I('uid');
        $data['status'] = 3;
        header("content-type:text/html;charset=utf-8");
        if(M('deal_log')->where("id={$id}")->save($data)){
            //echo "<script>alert('删除成功！');location.href='/admin.php?s=/Operate/index/id/{$uid}'</script>";exit;
            $this->success('删除成功！',U('/Operate/index/id/'.$uid));
        }
//        echo "<script>alert('删除失败！');history.go(-1);</script>";exit;
        $this->error('删除失败！');
    }

    public function test(){
        $authListArr = M('auth_rule')->field('id,name')->select();
        foreach($authListArr as $key=>$item){
            $bamne = str_replace('//','/',$item['name']);
            $bamne =  trim($bamne,'/');
            M('auth_rule')->where('id='.$item['id'])->save(array('name'=>$bamne));
        }
    }
}