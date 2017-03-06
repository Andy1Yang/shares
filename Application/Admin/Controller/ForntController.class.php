<?php
// +----------------------------------------------------------------------
// | 股票管理平台 [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.股票管理平台.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 后台首页控制器
 * @author 麦当苗儿 <zuojiazi@vip.qq.com>
 */
class ForntController extends \Think\Controller {


    public function index(){
        //是否登录
        session_start();
        $user = $_SESSION['股票管理平台_home']['user_auth2'];
        if(!$user){
            echo "<script>location.href='/index.php?s=/Home/User/login.html';</script>";exit;
        }
        //获得用户信息
        $id = $user['uid'];
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
            $allPage2 = ceil($count/8);
            $start2 = ($p2-1)*8;
            $this->assign('_allPage2',$allPage2);
            $this->assign('_p2',$p2);
            $sql = "select a.*,b.nickname from ss_deal_log as a left join ss_member as b on a.member_id=b.uid where a.user_id={$id} and a.status=1 and a.do_type=1 and a.sell_status=1 order by a.deal_time DESC,a.id DESC limit {$start2},8";
//            $sql = "select a.*,b.nickname from ss_deal_log as a left join ss_member as b on a.member_id=b.uid where a.user_id={$id} and a.status=1 and a.do_type=1 and a.sell_status=1 group by a.shares_code order by a.deal_time DESC,a.id DESC limit {$start2},8";
            $Model = new \Think\Model(); // 实例化一个model对象 没有对应任何数据表
//            echo $sql;exit;
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
                $sell_stamp_duty = $userModel->count_stamp_duty($deal_list2[$key]['now_value']);//印花税
                $sell_transfer_fee = $userModel->count_transfer_fee($deal_list2[$key]['now_value']);//过户费
                $entrust_fee = $userModel->count_entrust_fee(1,$deal_list2[$key]['now_value']); //委托费
                $commission = $userModel->count_commission($deal_list2[$key]['now_value'],$user_info['yongjin_rate']);//佣金
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

    /* 退出登录 */
    public function logout(){
        session_start();
        $user = $_SESSION['股票管理平台_home']['user_auth2'];
        if($user){
            session_unset('股票管理平台_home');
            echo "<script>location.href='/index.php?s=/Home/User/login.html';</script>";exit;
        } else {
            echo "<script>location.href='/index.php?s=/Home/User/login.html';</script>";exit;
        }
    }

    public function buy(){
        session_start();
        $user = $_SESSION['股票管理平台_home']['user_auth2'];
        $user_id =  $user['uid'];
        $userArr = M('user')->where('id='.$user_id)->find();
        $data['user_id'] = $user_id;
        $data['shares_code'] = I('shares_code');
        $data['shares_name'] = I('shares_name');
        $data['market_type'] = I('market_type');
        $data['add_time'] = time();
        $data['deal_amount'] = I('deal_amount');
        $data['deal_price'] = I('deal_price');
        $data['remarks'] = I('remarks');
        $data['do_type'] = 1;
        $data['member_id'] = $userArr['member_id'];
        header('Content-type:text/html;charset=utf-8');
        if($data['deal_amount']*$data['deal_price']>$userArr['able_money']){
            echo "<script>alert('申请交易金额不可大于用资金！');history.go(-1);</script>";exit;
        }
        if(M('apply_log')->add($data)){
            echo "<script>alert('申请买入成功！');location.href='/admin.php?s=/Fornt/apply.html'</script>";
        }else{
            echo "<script>alert('申请买入失败！');history.go(-1);</script>";exit;
        }
    }

    public function sell(){
        session_start();
        $user = $_SESSION['股票管理平台_home']['user_auth2'];
        $user_id =  $user['uid'];
        $userArr = M('user')->where('id='.$user_id)->find();
        $data['user_id'] = $user_id;
        $data['deal_id'] = I('id');
        $data['shares_code'] = I('shares_code');
        $data['shares_name'] = I('shares_name');
        $data['market_type'] = I('market_type');
        $data['add_time'] = time();
        $data['deal_amount'] = I('sell_amount');
        $data['deal_price'] = I('sell_price');
        $data['remarks'] = I('remarks');
        $data['do_type'] = 2;
        $data['member_id'] = $userArr['member_id'];
        $data['able_amount'] = I('able_amount');
        header('Content-type:text/html;charset=utf-8');
        if($data['deal_amount']>$data['able_amount']){
            echo "<script>alert('申请卖出数量不可大于可卖出数量！');history.go(-1);</script>";exit;
        }
        $oldAmount = M('apply_log')->where('deal_id='.$data['deal_id'])->sum('deal_amount');
        if(($oldAmount+$data['deal_amount'])>$data['able_amount']){
            echo "<script>alert('总共申请卖出数量不可大于可卖出数量！');history.go(-1);</script>";exit;
        }
        if(M('apply_log')->add($data)){
            echo "<script>alert('申请卖出成功！');location.href='/admin.php?s=/Fornt/apply.html'</script>";
        }else{
            echo "<script>alert('申请卖出失败！');history.go(-1);</script>";exit;
        }
    }

    public function apply(){
        session_start();
        $user = $_SESSION['股票管理平台_home']['user_auth2'];
        $user_id =  $user['uid'];
        $apply_log = M('apply_log');
        $count = $apply_log->where("user_id={$user_id} and status<>3")->count('id');// 查询满足要求的总记录数
        $Page       = new \Think\Page($count,40);// 实例化分页类 传入总记录数和每页显示的记录数
        $show       = $Page->show();// 分页显示输出
        $this->assign('_page',$show);
        $apply_list = M('apply_log')->where("user_id={$user_id} and status<>3")->order('add_time desc')->limit($Page->firstRow,$Page->listRows)->select();
        $map = array(
            'status'=>array(
                '1'=>'受理中',
                '2'=>'已处理'
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
        int_to_string($apply_list,$map);
        $this->assign('_apply_list',$apply_list);
        $this->display();
    }

    public function del(){
        session_start();
        $user = $_SESSION['股票管理平台_home']['user_auth2'];
        $user_id =  $user['uid'];
        $id = I('id');
        if(M('apply_log')->where("user_id={$user_id} and id={$id}")->save(array('status'=>3))){
            $this->success('撤销成功！',U('/Fornt/apply/'));
        }else{
            $this->error('撤销申请失败！');
        }
    }

    public function updatePassword(){
        if(IS_POST){
            $password = I('password');
            $repassword = I('repassword');
            $old = I('old');
            if(empty($password) || empty($repassword) || empty($old)){
                $this->error('密码不能为空！');
            }
            if($password!=$repassword){
                $this->error('密码必须一致！');
            }
            session_start();
            $user = $_SESSION['股票管理平台_home']['user_auth2'];
            $user_id =  $user['uid'];
            $old = md5($old);
            $bool = M('user')->where("id={$user_id} and password='{$old}'")->find();
            if($bool){
                $data['password'] = md5($password);
                $bool2 = M('user')->where("id={$user_id}")->save($data);
                if($bool2){
                    $this->success('密码修改成功！',U('index'));
                }else{
                    $this->error('旧密码错误！');
                }
            }else{
                $this->error('旧密码错误！');
            }
        }else{
            $this->display();
        }
    }


    //股票名称股市自动化
    public function self_shares(){
        $sharesCode = $_POST['shares_code'];
        if($sharesCode==''){
            $marketType = 0;
            $shares_code = '';
        }else{
            $fisrtNum = $sharesCode[0];
            if($fisrtNum==0 || $fisrtNum==3){
                $marketType = 1;
                $shares_code = 'sz'.$sharesCode;
            }else if($fisrtNum==6){
                $marketType = 2;
                $shares_code = 'sh'.$sharesCode;
            }else{
                $marketType = 0;
                $shares_code = '';
            }
        }

        //访问股票价格接口
        $userModel = D('User');
        $result = $userModel->sharesApi($shares_code);
        if(is_array($result)){
            $sharesName = $result['result'][0]['data']['name'];
        }else{
            $sharesName = '';
        }
        $arr = array(
            'sharesName'=>$sharesName,
            'market_type'=>$marketType,
        );
        exit(json_encode($arr));
    }
}
