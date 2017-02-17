<?php
namespace Admin\Controller;

/**
 * 后台资金控制器
 * @author yhy  <494044011@qq.com>
 */
class CapitalController extends AdminController {

    //资金列表
    public function  index(){

        //获得左边营业部门和对应用户（账户人员）
        $menu_list = D('User')->get_left_menu_sales(UID,'Capital');
        $this->assign('_menu_list',$menu_list);
        //获得用户信息
        $menuArr = array_shift($menu_list);
        $id = I('id',$menuArr[0]['id']);
        if(!empty($id)){
            $user_info = M('user')->where("id={$id}")->find();
            //记得做分页
            $capital_log = M('capital_log');
            $count = $capital_log->where("user_id={$id} and status=1 ")->count('id');// 查询满足要求的总记录数
            $Page       = new \Think\Page($count,20);// 实例化分页类 传入总记录数和每页显示的记录数
            $show       = $Page->show();// 分页显示输出
            $this->assign('_page',$show);
            $sql = "select a.*,b.nickname from ss_capital_log as a left join ss_member as b on a.member_id=b.uid where a.user_id={$id} and a.status=1 order by a.do_time DESC,a.id DESC limit {$Page->firstRow},{$Page->listRows}";
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
        }else{
            $user_info = array();
            $capital_list = array();
        }

        $this->assign('_user_info',$user_info);
        $this->assign('_capital_list',$capital_list);
        $this->meta_title = '资金管理';
        $this->display();
    }

    //存入资金
    public function doposit(){
        $user_id =  I('user_id');
        $happen_money = I('happen_money');
        $do_time = I('do_time');
        $data['user_id'] = $user_id;
        $data['happen_money'] = $happen_money;
        $data['do_time'] = strtotime($do_time);;
        $data['remarks'] = I('remarks');
        $yuanArr = M('user')->where('id='.$user_id)->field('ensure_money,able_money,pledge')->find();
        $data['ensure_money'] = $yuanArr['ensure_money']+$happen_money;
        $data['able_money'] = $yuanArr['able_money']+$happen_money*$yuanArr['pledge'];
        $yestedayNight = strtotime(date('Y-m-d',time()));
        $preNum = M('capital_log')->where('user_id='. $data['user_id'].' and do_time>'.$yestedayNight)->count();
        $number = sprintf("%04d",$preNum+1);
        $data['deal_code'] = date('Ymd',time()).$number;
        $data['member_id'] = UID;
        $data['type'] = 1;
        $data['status'] = 1;
        $udata['ensure_money'] =  $data['ensure_money'];
        $udata['able_money'] =  $data['able_money'];
        $bool = M('user')->where('id='.$user_id)->save($udata);
        header("content-type:text/html;charset=utf-8");
        if($bool && M('capital_log')->add($data)){
            echo "<script>alert('存入保证金成功！');location.href='/admin.php?s=/Capital/index/id/{$user_id}'</script>";
        }else{
            echo "<script>alert('存入保证金失败！');history.go(-1);</script>";
        }
    }

    //保证金取现
    public function trim(){
        $user_id =  I('user_id');
        $happen_money = I('happen_money');
        $do_time = I('do_time');
        $data['user_id'] = $user_id;
        $data['happen_money'] = $happen_money;
        $data['do_time'] = strtotime($do_time);;
        $data['remarks'] = I('remarks');
        $yuanArr = M('user')->where('id='.$user_id)->field('ensure_money,able_money,pledge')->find();
        $data['ensure_money'] = $yuanArr['ensure_money']-$happen_money;
        $data['able_money'] = $yuanArr['able_money']-$happen_money*$yuanArr['pledge'];
        $yestedayNight = strtotime(date('Y-m-d',time()));
        $preNum = M('capital_log')->where('user_id='. $data['user_id'].' and do_time>'.$yestedayNight)->count();
        $number = sprintf("%04d",$preNum+1);
        $data['deal_code'] = date('Ymd',time()).$number;
        $data['member_id'] = UID;
        $data['type'] = 2;
        $data['status'] = 1;
        $udata['ensure_money'] =  $data['ensure_money'];
        $udata['able_money'] =  $data['able_money'];
        $bool = M('user')->where('id='.$user_id)->save($udata);
        header("content-type:text/html;charset=utf-8");
        if($bool && M('capital_log')->add($data)){
            echo "<script>alert('减少保证金成功！');location.href='/admin.php?s=/Capital/index/id/{$user_id}'</script>";
        }else{
            echo "<script>alert('减少保证金失败！');history.go(-1);</script>";
        }
    }

    //修改操作
    public function edit(){
        //获得左边营业部门和对应用户（账户人员）
        $menu_list = D('User')->get_left_menu_sales(UID,'Capital');
        $this->assign('_menu_list',$menu_list);

        $id = I('id');
        $is_edit = I('is_edit');
        if($is_edit==1){
            $user_id = I('user_id');
            $do_time = I('do_time');
            $data['happen_money'] =  I('happen_money');
            $data['do_time'] = strtotime($do_time);;
            $data['remarks'] = I('remarks');
            $data['ensure_money'] = I('ensure_money');
            $data['able_money'] = I('able_money');
            $yestedayNight = strtotime(date('Y-m-d',time()));
            $preNum = M('capital_log')->where('user_id='. $user_id.' and do_time>'.$yestedayNight)->count();
            $number = sprintf("%04d",$preNum+1);
            $data['deal_code'] = date('Ymd',time()).$number;
            $bool = M('capital_log')->where('id='.$id)->save($data);
//           echo M('capital_log')->getLastSql();
            if($bool){
                $this->success('修改成功！',"/admin.php?s=/Capital/index/id/{$user_id}");
            }else{
                $this->error('修改失败！');
            }
        }else{
            $sql = "select a.*,b.nickname from ss_capital_log as a left join ss_member as b on a.member_id=b.uid where a.id={$id} ";
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
            $this->meta_title = '修改资金流水';
            $this->assign('_res',$capital_list[0]);
            $this->display();
        }
    }

    //删除
    public function changeStatus(){
        $id = I('id');
        $user_id = I('user_id');
        $data['status'] = 3;
        if(M('capital_log')->where('id='.$id)->save($data)){
            $this->success('删除成功！',"/admin.php?s=/Capital/index/id/{$user_id}");
        }else{
            $this->error('删除失败！');
        }
    }

    //月结返息 列表
    public function monthInterest(){
        //获得左边营业部门和对应用户（账户人员）
        $menu_list = D('User')->get_left_menu_sales(UID,'Capital');
        $this->assign('_menu_list',$menu_list);

        $user_id = I('id');
        $startTime = I('startTime');
        $endTime = I('endTime');
        if(empty($startTime) && empty($endTime)){//默认这个月记录
            $startTime = date('Y-m-01', strtotime(date("Y-m-d")));
            $endTime = date('Y-m-d', strtotime("$startTime +1 month -1 day"));
        }
        $resList = M('return_interest_log')->where("date>='{$startTime}' and date<='{$endTime}' and user_id={$user_id}")->select();
        $map = array(
            'status'=>array(
                1=>'未返息',
                2=>'已返息',
            )
        );
        int_to_string($resList,$map);
        $this->assign('_uid',$user_id);
        $this->assign('_startTime',$startTime);
        $this->assign('_endTime',$endTime);
        $this->assign('_list',$resList);
        $this->display();
    }

    //返息
    public function returnInterest(){
        $id = I('id');
        $user_id = I('get.user_id');
        $startTime = I('get.startTime');
        $endTime = I('get.endTime');
        if(is_array($id)){
            foreach($id as $item){
                $bool = $this->oneReturnInterest($item);
                if(!$bool){
                  $this->error('返息失败！');
                }
            }
        }else{
            $bool = $this->oneReturnInterest($id);
            if(!$bool){
                $this->error('返息失败！');
            }
        }
        $this->success('返息成功！',"/admin.php?s=/Capital/monthInterest/id/{$user_id}/startTime/{$startTime}/endTime/{$endTime}");
    }

    //返息调用方法
    public function oneReturnInterest($id){
        $returnInfo = M('return_interest_log')->where('id='.$id)->find();
        //账户表金额修改
        $userInfo = M('user')->where('id='.$returnInfo['user_id'])->find();
        $udata['ensure_money'] = $userInfo['ensure_money']+$returnInfo['return_interest'];
        $udata['able_money'] = $userInfo['able_money']+$returnInfo['return_interest']*$userInfo['pledge'];
        if(!M('user')->where('id='.$returnInfo['user_id'])->save($udata)){
            return false;
        }

        //资金流水表添加
        $data['user_id'] = $returnInfo['user_id'];
        $data['happen_money'] = $returnInfo['return_interest'];
        $data['do_time'] = time();
        $data['ensure_money'] = $udata['ensure_money'];
        $data['able_money'] =  $udata['able_money'];
        $yestedayNight = strtotime(date('Y-m-d',time()));
        $preNum = M('capital_log')->where('user_id='.  $data['user_id'].' and do_time>'.$yestedayNight)->count();
        $number = sprintf("%04d",$preNum+1);
        $data['deal_code'] = date('Ymd',time()).$number;
        $data['member_id'] = UID;
        $data['type'] = 1;
        $data['status'] = 1;
        if(!M('capital_log')->add($data)){
          return false;
        }
        //返息表修改
        if(!M('return_interest_log')->where('id='.$id)->save(array('status'=>2,'update_time'=>time()))){
            return false;
        }
        return true;
    }
}