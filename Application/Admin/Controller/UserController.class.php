<?php
// +----------------------------------------------------------------------
// | 股票管理平台 [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.股票管理平台.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Admin\Controller;
use User\Api\UserApi;

/**
 * 后台用户控制器
 * @author 麦当苗儿 <zuojiazi@vip.qq.com>
 */
class UserController extends AdminController {

    /**
     * 用户管理首页
     * @author 麦当苗儿 <zuojiazi@vip.qq.com>
     */
    public function index(){

        $nickname       =   I('nickname');
        $map['status']  =   array('egt',0);
        if(is_numeric($nickname)){
            $map['uid|nickname']=   array(intval($nickname),array('like','%'.$nickname.'%'),'_multi'=>true);
        }else{
            $map['nickname']    =   array('like', '%'.(string)$nickname.'%');
        }

        $list   = $this->lists('Member', $map,'sort desc');
        //营业部门
        $user = D('user');
        $salesMap = $user->getSalesText();
        $map = array(
            'status'=>array(1=>'正常',-1=>'删除',0=>'禁用',2=>'未审核',3=>'草稿'),
            'sales_id'=>$salesMap
        );
        int_to_string($list,$map);
        //先查权限
        $user_info = M('member')->where('uid='.UID)->find();
        if($user_info['level']==3){
            $lists = $list;
            $list = array();
            foreach($lists as $key=>$item){
                if($item['uid']==UID){
                    $list[] = $lists[$key];
                }
            }
        }else if($user_info['level']==2){
            array_shift($list);
        }

        $this->assign('_list', $list);
        $this->meta_title = '用户信息';
        $this->display();
    }

    /**
     * 修改昵称初始化
     * @author huajie <banhuajie@163.com>
     */
    public function updateNickname(){
        $nickname = M('Member')->getFieldByUid(UID, 'nickname');
        $this->assign('nickname', $nickname);
        $this->meta_title = '修改昵称';
        $this->display('updatenickname');
    }

    /**
     * 修改昵称提交
     * @author huajie <banhuajie@163.com>
     */
    public function submitNickname(){
        //获取参数
        $nickname = I('post.nickname');
        $password = I('post.password');
        empty($nickname) && $this->error('请输入昵称');
        empty($password) && $this->error('请输入密码');

        //密码验证
        $User   =   new UserApi();
        $uid    =   $User->login(UID, $password, 4);
        ($uid == -2) && $this->error('密码不正确');

        $Member =   D('Member');
        $data   =   $Member->create(array('nickname'=>$nickname));
        if(!$data){
            $this->error($Member->getError());
        }

        $res = $Member->where(array('uid'=>$uid))->save($data);

        if($res){
            $user               =   session('user_auth');
            $user['username']   =   $data['nickname'];
            session('user_auth', $user);
            session('user_auth_sign', data_auth_sign($user));
            $this->success('修改昵称成功！');
        }else{
            $this->error('修改昵称失败！');
        }
    }

    /**
     * 修改密码初始化
     * @author huajie <banhuajie@163.com>
     */
    public function updatePassword(){
        $this->meta_title = '修改密码';
        $this->display('updatepassword');
    }

    /**
     * 修改密码提交
     * @author huajie <banhuajie@163.com>
     */
    public function submitPassword(){
        //获取参数
        $password   =   I('post.old');
        empty($password) && $this->error('请输入原密码');
        $data['password'] = I('post.password');
        empty($data['password']) && $this->error('请输入新密码');
        $repassword = I('post.repassword');
        empty($repassword) && $this->error('请输入确认密码');

        if($data['password'] !== $repassword){
            $this->error('您输入的新密码与确认密码不一致');
        }

        $Api    =   new UserApi();
        $res    =   $Api->updateInfo(UID, $password, $data);
        if($res['status']){
            $this->success('修改密码成功！');
        }else{
            $this->error($res['info']);
        }
    }

    /**
     * 用户行为列表
     * @author huajie <banhuajie@163.com>
     */
    public function action(){
        //获取列表数据
        $Action =   M('Action')->where(array('status'=>array('gt',-1)));
        $list   =   $this->lists($Action);
        int_to_string($list);
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);

        $this->assign('_list', $list);
        $this->meta_title = '用户行为';
        $this->display();
    }

    /**
     * 新增行为
     * @author huajie <banhuajie@163.com>
     */
    public function addAction(){
        $this->meta_title = '新增业务员';
        $this->assign('data',null);
        $this->display('editaction');
    }

    /**
     * 编辑行为
     * @author huajie <banhuajie@163.com>
     */
    public function editAction(){
        $id = I('get.id');
        empty($id) && $this->error('参数不能为空！');
        $data = M('Action')->field(true)->find($id);

        $this->assign('data',$data);
        $this->meta_title = '编辑行为';
        $this->display('editaction');
    }

    /**
     * 更新行为
     * @author huajie <banhuajie@163.com>
     */
    public function saveAction(){
        $res = D('Action')->update();
        if(!$res){
            $this->error(D('Action')->getError());
        }else{
            $this->success($res['id']?'更新成功！':'新增成功！', Cookie('__forward__'));
        }
    }

    /**
     * 会员状态修改
     * @author 朱亚杰 <zhuyajie@topthink.net>
     */
    public function changeStatus($method=null){
        $id = array_unique((array)I('id',0));
        if( in_array(C('USER_ADMINISTRATOR'), $id)){
            $this->error("不允许对超级管理员执行该操作!");
        }
        $id = is_array($id) ? implode(',',$id) : $id;
        if ( empty($id) ) {
            $this->error('请选择要操作的数据!');
        }
        $map['uid'] =   array('in',$id);
        switch ( strtolower($method) ){
            case 'forbiduser':
                $this->forbid('Member', $map );
                break;
            case 'resumeuser':
                $this->resume('Member', $map );
                break;
            case 'deleteuser':
                $this->delete('Member', $map );
                break;
            default:
                $this->error('参数非法');
        }
    }

    public function add($username = '', $password = '', $repassword = '', $email = ''){
        if(IS_POST){
            /* 检测密码 */
            if($password != $repassword){
                $this->error('密码和重复密码不一致！');
            }
            if(strlen($password)<6){
                $this->error('密码需要至少6位数！');
            }
            /* 调用注册接口注册用户 */
//            $User   =   new UserApi;
//            $uid    =   $User->register($username, $password, $email);
            $data = array();
            $data['nickname'] = I('nickname');
            $data['sales_id'] = I('sales_id');
            $data['yonjin_rate'] = I('yonjin_rate');
            $data['lixi_rate'] = I('lixi_rate');
            $data['telephone'] = I('telephone');
            $data['level'] = I('level');
            $data['sex'] = I('sex');
            $data['sort'] = I('sort');
            $data['status'] = I('status');
            $udata = array();
            $udata['username'] = I('nickname');
            $udata['mobile'] = I('telephone');
            $udata['password'] = think_ucenter_md5($password, UC_AUTH_KEY);
            $udata['status'] = I('status');
            $uid = M('ucenter_member')->add($udata);
            if($uid){ //注册成功
                $data['uid'] = $uid;
                if(!M('Member')->add($data)){
                    $this->error('业务员添加失败！');
                } else {
                    $this->success('业务员添加成功！',U('index'));
                }
            } else { //注册失败，显示错误信息
                $this->error($this->showRegError($uid));
            }
        } else {
            $salesArr = M('sales')->field('id,title')->select();
            $this->assign('_sales_list',$salesArr);
            $this->meta_title = '新增业务员';
            $this->display();
        }
    }

    //业务员信息修改
    public function edit(){
        $is_edit = I('is_eidt');
        $uid = I('uid');
        if($is_edit){
            $password = I('password');
            $repassword = I('repassword');
            $udata = array();
            /* 检测密码 */
            if(!empty($password)){
                if($password != $repassword){
                    $this->error('密码和重复密码不一致！');
                }
                if(strlen($password)<6){
                    $this->error('密码需要至少6位数！');
                }
                if($uid!=1){
                    $udata['password'] = think_ucenter_md5($password, UC_AUTH_KEY);
                }
            }
            $data = array();
            if($uid!=1){
                $data['status'] = I('status');
                $udata['status'] = I('status');
            }
            $data['nickname'] = I('nickname');
            $data['sales_id'] = I('sales_id');
            $data['yonjin_rate'] = I('yonjin_rate');
            $data['lixi_rate'] = I('lixi_rate');
            $data['telephone'] = I('telephone');
            $data['level'] = I('level');
            $data['sex'] = I('sex');
            $data['sort'] = I('sort');
            $udata['username'] = I('nickname');
            $udata['mobile'] = I('telephone');
            $bool = M('ucenter_member')->where('id='.$uid)->save($udata);
            $bool2 = M('Member')->where('uid='.$uid)->save($data);
            if($bool || $bool2){ //修改成功
                $this->success('业务员信息修改成功！',U('index'));
            } else { //注册失败，显示错误信息
                $this->error('业务员信息修改失败！');
            }
        }else{
            $salesArr = M('sales')->field('id,title')->select();
            $this->assign('_sales_list',$salesArr);
            $res = M('member')->where('uid='.$uid)->find();
            $this->assign('_res',$res);
            $this->display();
        }
    }

    /**
     * 获取用户注册错误信息
     * @param  integer $code 错误编码
     * @return string        错误信息
     */
    private function showRegError($code = 0){
        switch ($code) {
            case -1:  $error = '用户名长度必须在16个字符以内！'; break;
            case -2:  $error = '用户名被禁止注册！'; break;
            case -3:  $error = '用户名被占用！'; break;
            case -4:  $error = '密码长度必须在6-30个字符之间！'; break;
            case -5:  $error = '邮箱格式不正确！'; break;
            case -6:  $error = '邮箱长度必须在1-32个字符之间！'; break;
            case -7:  $error = '邮箱被禁止注册！'; break;
            case -8:  $error = '邮箱被占用！'; break;
            case -9:  $error = '手机格式不正确！'; break;
            case -10: $error = '手机被禁止注册！'; break;
            case -11: $error = '手机号被占用！'; break;
            default:  $error = '未知错误';
        }
        return $error;
    }

    //营业部列表
    public function sales_list(){

        $list = M('sales')->order('sort desc')->select();
        int_to_string($list,array('status'=>array(1=>'正常',-1=>'删除',2=>'禁用',3=>'草稿')));
        $this->assign('_list', $list);
        $this->meta_title = '营业部列表';
        $this->display();
    }

    //添加营业部
    public function sales_add(){
        if(IS_POST){
            $data['title'] = I('title');
            $data['dali_rate'] = I('dali_rate');
            $data['yongjin_rate'] = I('yongjin_rate');
            $data['name'] = I('name');
            $data['telephone'] = I('telephone');
            $data['address'] = I('address');
            $data['sort'] = I('sort');
            $data['status'] = I('status');
            foreach($data as $item){
                if(empty($item)){
                    $this->error('营业部信息请填写完整！');
                }
            }
            if(!M('sales')->add($data)){
                $this->error('营业部添加失败！');
            } else {
                $this->success('营业部添加成功！',U('sales_list'));
            }

        }else {
            $this->meta_title = '新增营业部';
            $this->display();
        }

    }

    //修改营业部
    public function sales_edit(){
        $id = I('id');
        $is_eidt = I('is_eidt');
        if(!empty($is_eidt)){
            $data['title'] = I('title');
            $data['dali_rate'] = I('dali_rate');
            $data['yongjin_rate'] = I('yongjin_rate');
            $data['name'] = I('name');
            $data['telephone'] = I('telephone');
            $data['address'] = I('address');
            $data['sort'] = I('sort');
            $data['status'] = I('status');
            foreach($data as $item){
                if(empty($item)){
                    $this->error('营业部信息请填写完整！');
                }
            }
            $bool = M('sales')->where('id='.$id)->save($data);
            if(!$bool){
                $this->error('营业部修改失败！');
            } else {
                $this->success('营业部修改成功！',U('sales_list'));
            }
        }else{
            $result = M('sales')->where('id='.$id)->find();
            $this->assign('_res',$result);
            $this->meta_title = '修改营业部';
            $this->display();
        }
    }

    //删除营业部
    public function sales_del(){
        $id = I('id');
        if(is_array($id)){
            $bool = true;
            foreach($id as $item){
                if(!M('sales')->where('id='.$item)->delete()){
                    $bool = false;
                }
            }
            if($bool){
                $this->success('营业部删除成功！',U('sales_list'));
            }else{
                $this->error('营业部删除失败！');
            }
        }else{
            if(M('sales')->where('id='.$id)->delete()){
                $this->success('营业部删除成功！',U('sales_list'));
            }else{
                $this->error('营业部删除失败！');
            }
        }
    }

    //账户列表
    public function user_list(){
        //账户列表
        $user = D('user');
        $salesMap = $user->getSalesText();
        $memberMap = $user->getUserText();
        $map = array(
            'status'=>array(1=>'正常',-1=>'删除',0=>'禁用',2=>'未审核',3=>'草稿'),
            'sales_id'=>$salesMap,
            'member_id'=>$memberMap
        );
        $search = I('nickname');
        $where = '1=1';
        if(!empty($search)){
            if(!is_numeric($search)){
                $where .= " and name like '%{$search}%'";
            }elseif(strlen($search)>11){
                $where .= " and body_card='{$search}'";
            }else{
                $where .= " and telephone like '%{$search}%'";
            }

        }
        $list = M('user')->where($where)->order('sort desc')->select();
        int_to_string($list,$map);
        //先查权限
        $user_info = M('member')->where('uid='.UID)->find();
        if($user_info['level']==3){
            $lists = $list;
            $list = array();
            foreach($lists as $key=>$item){
                if($item['member_id']==UID){
                    $list[] = $lists[$key];
                }
            }
        }else if($user_info['level']==2){
            $lists = $list;
            $list = array();
            foreach($lists as $key=>$item){
                if($item['sales_id']==$user_info['sales_id']){
                    $list[] = $lists[$key];
                }
            }
        }
        $this->assign('_list', $list);
        $this->meta_title = '账户列表';
        $this->display();
    }

    //账户登记
    public function user_add(){
        if(IS_POST){
            $data['name'] = I('name');
            $data['pledge'] = I('pledge');
            $data['rate'] = I('rate');
            $data['yongjin_rate'] = I('yongjin_rate');
            $data['capital_waring'] = I('capital_waring');
            $data['flat'] = I('flat');
            $data['transfer'] = I('transfer');
            $data['return_rate'] = I('return_rate');
            $data['hand_cost'] = I('hand_cost');
            $data['sales_id'] = I('sales_id');
            $data['member_id'] = I('member_id');
            $data['body_card'] = I('body_card');
            $data['email'] = I('email');
            $data['telephone'] = I('telephone');
            $data['telephone2'] = I('telephone2');
            $data['sex'] = I('sex');
            $data['child'] = I('child');
            $data['phone'] = I('phone');
            $data['address'] = I('address');
            $data['sort'] = I('sort');
            $data['status'] = I('status');
            //时间
            $year = I('year');
            $month = I('month');
            $day = I('day');
            $data['birthday'] = strtotime($year.'-'.$month.'-'.$day);
            $data['add_time'] = time();
            //地址
            $province1 = I('province1');
            $city1 = I('city1');
            $area1 = I('area1');
            $province2 = I('province2');
            $city2 = I('city2');
            $area2 = I('area2');
            $data['jiguan'] = $province1.'#'.$city1.'#'.$area1;
            $data['hukou'] = $province2.'#'.$city2.'#'.$area2;
            if(!M('user')->add($data)){
                $this->error('账户添加失败！');
            } else {
                $this->success('账户添加成功！',U('user_list'));
            }

        }else {
            //先查权限
            $user_info = M('member')->where('uid='.UID)->find();
            if($user_info['level']==1){
                $where = '1=1';
                $where2 = '1=1';
            }else{
                $where = 'sales_id='.$user_info['sales_id'];
                $where2 = 'id='.$user_info['sales_id'];
            }
            $memberArr = M('member')->where($where)->field('uid,nickname')->select();  
            $this->assign('_member_list',$memberArr);
            $salesArr = M('sales')->where($where2)->field('id,title')->select();
            $this->assign('_sales_list',$salesArr);
            $this->meta_title = '账户添加';
            $this->display();
        }
    }

    //账户修改
    public function user_edit(){
        $id = I('id');
        $is_eidt = I('is_eidt');
        if(!empty($is_eidt)){
            $data['name'] = I('name');
            $data['pledge'] = I('pledge');
            $data['rate'] = I('rate');
            $data['yongjin_rate'] = I('yongjin_rate');
            $data['capital_waring'] = I('capital_waring');
            $data['flat'] = I('flat');
            $data['transfer'] = I('transfer');
            $data['return_rate'] = I('return_rate');
            $data['hand_cost'] = I('hand_cost');
            $data['sales_id'] = I('sales_id');
            $data['member_id'] = I('member_id');
            $data['body_card'] = I('body_card');
            $data['email'] = I('email');
            $data['telephone'] = I('telephone');
            $data['telephone2'] = I('telephone2');
            $data['sex'] = I('sex');
            $data['child'] = I('child');
            $data['phone'] = I('phone');
            $data['address'] = I('address');
            $data['sort'] = I('sort');
            $data['status'] = I('status');
            //时间
            $year = I('year');
            $month = I('month');
            $day = I('day');
            $data['birthday'] = strtotime($year.'-'.$month.'-'.$day);
            //地址
            $province1 = I('province1');
            $city1 = I('city1');
            $area1 = I('area1');
            $province2 = I('province2');
            $city2 = I('city2');
            $area2 = I('area2');
            $data['jiguan'] = $province1.'#'.$city1.'#'.$area1;
            $data['hukou'] = $province2.'#'.$city2.'#'.$area2;

            $bool = M('user')->where('id='.$id)->save($data);
            if(!$bool){
                $this->error('账户修改失败！');
            } else {
                $this->success('账户修改成功！',U('user_list'));
            }
        }else{
            //先查权限
            $user_info = M('member')->where('uid='.UID)->find();
            if($user_info['level']==1){
                $where = '1=1';
                $where2 = '1=1';
            }else{
                $where = 'sales_id='.$user_info['sales_id'];
                $where2 = 'id='.$user_info['sales_id'];
            }
            $memberArr = M('member')->where($where)->field('uid,nickname')->select();
            $this->assign('_member_list',$memberArr);
            $salesArr = M('sales')->where($where2)->field('id,title')->select();
            $this->assign('_sales_list',$salesArr);
            $result = M('user')->where('id='.$id)->find();
            //时间处理
            $result['year'] = date('Y',$result['birthday']);
            $result['month'] = date('Y',$result['birthday']);
            $result[''] = date('Y',$result['birthday']);
            //地址
            $address1 = explode('#',$result['jiguan']);
            $address2 = explode('#',$result['hukou']);
            $result['province1'] = $address1[0];
            $result['city1'] = $address1[1];
            $result['area1'] = $address1[2];
            $result['province2'] = $address2[0];
            $result['city2'] = $address2[1];
            $result['area2'] = $address1[2];
            $this->assign('_res',$result);
            $this->meta_title = '修改账户';
            $this->display();
        }
    }

    public function user_del(){
        $id = I('id');
        if(is_array($id)){
            $bool = true;
            foreach($id as $item){
                if(!M('user')->where('id='.$item)->delete()){
                    $bool = false;
                }
            }
            if($bool){
                $this->success('账户删除成功！',U('user_list'));
            }else{ $this->error('账户删除失败！');
               
            }
        }else{
            if(M('user')->where('id='.$id)->delete()){
                $this->success('账户删除成功！',U('user_list'));
            }else{
                $this->error('账户删除失败！');
            }
        }
    }

    public function test(){  
        header('Content-type:text/html;charset=utf-8');
        $shares_code = 'sz300219';
        //配置您申请的appkey
        $appkey = 'e2b809cd2059dcb53f59faa01b8e523b';

        //************1.沪深股市************
        $url = "http://web.juhe.cn:8080/finance/stock/hs";
        $params = array(
            "gid" => $shares_code,//股票编号，上海股市以sh开头，深圳股市以sz开头如：sh601009
            "key" => $appkey,//APP Key
        );
        $paramstring = http_build_query($params);
        $content = juhecurl($url,$paramstring);
        $result = json_decode($content,true);
        if($result){
            if($result['error_code']=='0'){
                print_r($result);
            }else{
                echo $result['error_code'].":".$result['reason'];
            }
        }else{
            echo "请求失败";
        }
    }

}