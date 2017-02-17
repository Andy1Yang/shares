<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/1/8
 * Time: 17:03
 */
namespace Admin\Controller;

/**
 * 后台结算控制器
 * @author yhy  <494044011@qq.com>
 */
class AccountController extends AdminController {

    //已经结清
    public function  index(){
        //获得左边营业部门和对应用户（账户人员）
        $menu_list = D('User')->get_left_menu_sales(UID,'Account');
        $this->assign('_menu_list',$menu_list);

        $menuArr = array_shift($menu_list);
        $id = I('id',$menuArr[0]['id']);
        if($id){
            $user_info = M('user')->where("id={$id}")->find();
            $summary_log = M('summary_log');
            $count = $summary_log->where("user_id={$id} and (status=3 or status=5)")->count('id');// 查询满足要求的总记录数
            $Page       = new \Think\Page($count,20);// 实例化分页类 传入总记录数和每页显示的记录数
            $show       = $Page->show();// 分页显示输出
            $this->assign('_page',$show);
            $sql = "select a.*,b.nickname from ss_summary_log as a left join ss_member as b on a.member_id=b.uid where a.user_id={$id} and (a.status=3 or a.status=5) order by a.do_time DESC,a.id DESC limit {$Page->firstRow},{$Page->listRows}";
            $Model = new \Think\Model(); // 实例化一个model对象 没有对应任何数据表
            $list = $Model->query($sql);
            $map = array(
                'status'=>array(
                    '1'=>'不可结清',
                    '2'=>'未结清',
                    '3'=>'已结清',
                    '5'=>'已结算',
                ),
                'do_type'=>array(
                    '1'=>'盈亏转本金',
                    '2'=>'盈亏结现'
                ),
            );
            int_to_string($list,$map);
        }else{
            $user_info = array();
            $list = array();
        }
        $this->assign('_user_info',$user_info);
        $this->assign('_list',$list);
        $this->meta_title = '结算';
        $this->display();
    }

    //未交易列表
    public function un_deal_list(){
        //获得左边营业部门和对应用户（账户人员）
        $menu_list = D('User')->get_left_menu_sales(UID,'Account');
        $this->assign('_menu_list',$menu_list);

        $menuArr = array_shift($menu_list);
        $id = I('id',$menuArr[0]['id']);
        if($id){
            $user_info = M('user')->where("id={$id}")->find();
            $summary_log = M('summary_log');
            $count = $summary_log->where("user_id={$id} and (status=2 or status=6)")->count('id');// 查询满足要求的总记录数
            $Page       = new \Think\Page($count,20);// 实例化分页类 传入总记录数和每页显示的记录数
            $show       = $Page->show();// 分页显示输出
            $this->assign('_page',$show);
            $sql = "select a.*,b.nickname from ss_summary_log as a left join ss_member as b on a.member_id=b.uid where a.user_id={$id} and (a.status=2 or a.status=6) order by a.do_time DESC,a.id DESC limit {$Page->firstRow},{$Page->listRows}";
            $Model = new \Think\Model(); // 实例化一个model对象 没有对应任何数据表
            $list = $Model->query($sql);
            $map = array(
                'status'=>array(
                    '1'=>'不可结清',
                    '2'=>'可结算',
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
        }else{
            $user_info = array();
            $list = array();
        }
        $this->assign('_user_info',$user_info);
        $this->assign('_list',$list);
        $this->meta_title = '结算';
        $this->display();
    }

    //盈亏转本金
    public function winLoss_to_ensure(){
        $id = I('id');
        $parArr = M('summary_log')->where('id='.$id)->find();
        $user_info = M('user')->where('id='.$parArr['user_id'])->find();

//        header("content-type:text/html;charset=utf-8");
        //计算返息金额
        

        //账户本金
        $data['ensure_money'] = $user_info['ensure_money']+$parArr['win_loss'];
        if( $data['ensure_money']<0){
//            echo "<script>alert('盈亏转本金失败！本金不足！');history.go(-1);</script>";exit;
            $this->error('盈亏转本金失败！本金不足！)');
        }
        $data['able_money'] = $user_info['able_money']+$parArr['win_loss']*$user_info['pledge']-$parArr['win_loss'];
        if(!M('user')->where('id='.$parArr['user_id'])->save($data)){
//            echo "<script>alert('盈亏转本金失败！');history.go(-1);</script>";exit;
            $this->error('盈亏转本金失败)');
        }
        //资金流水
        $cdata['user_id'] = $parArr['user_id'];
        $cdata['happen_money'] = $parArr['win_loss'];
        $cdata['do_time'] =  time();
        $cdata['ensure_money'] = $data['ensure_money'];
        $cdata['able_money'] = $data['able_money'];
        $yestedayNight = strtotime(date('Y-m-d',time()));
        $preNum = M('capital_log')->where('user_id='. $cdata['user_id'].' and do_time>'.$yestedayNight)->count();
        $number = sprintf("%04d",$preNum+1);
        $cdata['deal_code'] = date('Ymd',time()).$number;
        $cdata['member_id'] = UID;
        $cdata['type'] = 3;
        $cdata['status'] = 1;
        if(!M('capital_log')->add($cdata)){
//            echo "<script>alert('盈亏转本金失败！添加资金流水表失败！(请勿重复操作！)');history.go(-1);</script>";exit;
            $this->error('盈亏转本金失败！添加资金流水表失败！(请勿重复操作！)');
        }

        if($parArr['status']==6){
            $sdata['status'] = 3;
        }else{
            $sdata['status'] = 5;
        }
        $sdata['do_type'] = 1;
        $sdata['do_time'] = time();
        if(!M('summary_log')->where('id='.$id)->save($sdata)){
//            echo "<script>alert('盈亏转本金失败！结算表修改失败！(请勿重复操作！)');history.go(-1);</script>";exit;
            $this->error('盈亏转本金失败！结算表修改失败！(请勿重复操作！)');
        }
//        echo "<script>alert('盈亏转本金成功！');location.href='/admin.php?s=/Account/index/id/{$parArr['user_id']}'</script>";
        $this->success('盈亏转本金成功！',U('/Account/index/id/'.$parArr['user_id']));
    }

    //盈亏结现
    public function winLoss_to_cash(){
        $id = I('id');
        $parArr = M('summary_log')->where('id='.$id)->find();
        $user_info = M('user')->where('id='.$parArr['user_id'])->find();

        header("content-type:text/html;charset=utf-8");
        //个人账户表 扣除  可用资金-盈亏资金
        $udata['able_money'] = $user_info['able_money']-$parArr['win_loss'];
        if(!M('user')->where('id='.$parArr['user_id'])->save($udata)){
            echo "<script>alert('盈亏结现失败！个人账户表修改失败！');history.go(-1);</script>";exit;
        }

        //添加资金流水记录
        $cdata['user_id'] = $parArr['user_id'];
        $cdata['happen_money'] = $parArr['win_loss'];
        $cdata['do_time'] =  time();
        $cdata['ensure_money'] = $user_info['ensure_money'];
        $cdata['able_money'] = $udata['able_money'];
        $yestedayNight = strtotime(date('Y-m-d',time()));
        $preNum = M('capital_log')->where('user_id='. $cdata['user_id'].' and do_time>'.$yestedayNight)->count();
        $number = sprintf("%04d",$preNum+1);
        $cdata['deal_code'] = date('Ymd',time()).$number;
        $cdata['member_id'] = UID;
        $cdata['type'] = 7;
        $cdata['status'] = 1;
        if(!M('capital_log')->add($cdata)){
            echo "<script>alert('盈亏结现失败！添加资金流水表失败！(请勿重复操作！)');history.go(-1);</script>";exit;
        }

        //结算表 修改status和do_time
        $sdata['status'] = 5;
        $sdata['do_type'] = 2;
        $sdata['do_time'] = time();
        if(!M('summary_log')->where('id='.$id)->save($sdata)){
            echo "<script>alert('盈亏结现失败！结算表修改失败！(请勿重复操作！)');history.go(-1);</script>";exit;
        }
        echo "<script>alert('盈亏结现成功！');location.href='/admin.php?s=/Account/index/id/{$parArr['user_id']}'</script>";
    }

    //修改
    public function edit(){
        //获得左边营业部门和对应用户（账户人员）
        $menu_list = D('User')->get_left_menu_sales(UID,'Account');
        $this->assign('_menu_list',$menu_list);

        $id = I('id');
        $is_edit = I('is_edit');
        if($is_edit==1){
            $user_id =  I('user_id');
            $data['shares_code'] =  I('shares_code');
            $data['shares_name'] =  I('shares_name');
            $data['buy_money'] =  I('buy_money');
            $data['buy_cost'] =  I('buy_cost');
            $data['sell_money'] =  I('sell_money');
            $data['sell_cost'] =  I('sell_cost');
            $data['interest'] = I('interest');
            $data['win_loss'] = I('win_loss');
            $data['sell_time'] = strtotime(I('sell_time'));
            $data['do_time'] = strtotime(I('do_time'));
            $data['member_id'] = I('member_id');
            $bool = M('summary_log')->where('id='.$id)->save($data);
            if($bool){
                $this->success('修改成功！',"/admin.php?s=/Account/index/id/{$user_id}");
            }else{
                $this->error('修改失败！');
            }
        }else{
            $sql = "select * from ss_summary_log where id={$id} ";
            $Model = new \Think\Model(); // 实例化一个model对象 没有对应任何数据表
            $summary_list = $Model->query($sql);
            $memberArr = M('member')->field('uid,nickname')->select();
            $this->assign('_member_list',$memberArr);
            $this->meta_title = '修改资金流水';
            $this->assign('_res',$summary_list[0]);
            $this->display();
        }

    }

    //撤销    暂不用
    public function del(){
        $id = I('id');
        $parArr = M('summary_log')->where('id='.$id)->find();

        if(empty($parArr)){
            echo "<script>alert('撤销失败！');history.go(-1);</script>";exit;
        }

        $sdata['status'] = 4;
        if(!M('summary_log')->where('id='.$id)->save($sdata)){
            echo "<script>alert('撤销失败！');history.go(-1);</script>";exit;
        }
        echo "<script>alert('撤销成功！');location.href='/admin.php?s=/Account/index/id/{$parArr['user_id']}'</script>";
    }

    //明细
    public function detail(){
        //获得左边营业部门和对应用户（账户人员）
        $menu_list = D('User')->get_left_menu_sales(UID,'Account');
        $this->assign('_menu_list',$menu_list);

        $id = I('id');
        $summary = M('summary_log')->where('id='.$id)->find();
        $deal_list = M('deal_log')->where("summary_id={$id}")->order('deal_time asc')->select();
        if(!$deal_list){
            $deal_list = M('deal_log')->where("summary_id={$summary['summary_id']}")->order('deal_time asc')->select();
        }
        $map = array(
            'do_type'=>array(
                1=>'买入',
                2=>'卖出',
            ),
        );
        int_to_string($deal_list,$map);
        $this->assign('_deal_list',$deal_list);
        $end = array_pop($deal_list);
        $days = diffBetweenTwoDays(date('Y-m-d',$deal_list[0]['deal_time']),date('Y-m-d',$end['deal_time']))+1;
        $this->assign('_days',$days);
        $this->assign('_summary',$summary);

        $this->meta_title = '交易明细';
        $this->display();

    }
}