<?php
/**
 * Created by PhpStorm.
 * User: fang
 * Date: 2017/1/10
 * Time: 11:01
 */
namespace Admin\Model;
use Think\Model;

/**
 * User模型
 * @author yhy <494044011@qq.com>
 */

class UserModel extends Model {

    //获取营业部选项文档
    public function getSalesText(){

        $salesArr = M('sales')->field('id,title')->select();
        $salesMap = array();
        foreach($salesArr as $item){
            $salesMap[$item['id']] = $item['title'];
        }
        return $salesMap;
    }

    //获取营业员选项文档
    public function getUserText(){

        $memberArr = M('member')->field('uid,nickname')->select();
        $memberMap = array();
        foreach($memberArr as $item){
            $memberMap[$item['uid']] = $item['nickname'];
        }
        return $memberMap;
    }

    /**
     * 获得左边营业部门和对应用户（账户人员）
     * @param $uid
     * @param $controller  控制器
     */
    public function get_left_menu_sales($uid,$controller){

        $user_info = M('member')->where('uid='.$uid)->find();
        if($user_info['level']==1){ //老板
            $salesList = M('sales')->field('id,title')->select();
        }else{//主管或普通业务员
            $salesList = M('sales')->where('id='.$user_info['sales_id'])->field('id,title')->select();
        }

        $data = array();
        foreach($salesList as $item){
            if($user_info['level']==3){
                $res = M('user')->where('status=1 and member_id='.$user_info['uid'].' and sales_id='.$item['id'])->field('id,name as title')->select();
            }else{
                $res = M('user')->where('status=1 and sales_id='.$item['id'])->field('id,name as title')->select();
            }
            foreach($res as $key=>$val){ 
                if($controller=='Account' ){
                    $res[$key]['url'] = "/".$controller."/un_deal_list/id/".$val['id'];
                    $num = M('summary_log')->where("user_id={$val['id']} and (status=2 or status=6)")->count();
                    if($num>0){
                        $res[$key]['have_summary'] = 1;
                    }else{
                        $res[$key]['have_summary'] = 2;
                    }
                }else{
                    $res[$key]['url'] = "/".$controller."/index/id/".$val['id'];
                    $res[$key]['have_summary'] = 2;
                }
            }
            $data[$item['title']] = $res;
        }  
        return $data;
    }

    /**
     * 查询股票价格接口
     * @param $shares_code  股票代码  前面要加好字段 深圳：sz 上海：sh
     * @return string
     */
    public function sharesApi($shares_code){
        header('Content-type:text/html;charset=utf-8');
        //配置您申请的appkey
        $appkey = C('JH_APPKEY');

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
                return $result;
            }else{
                return $result['error_code'].":".$result['reason'];
            }
        }else{
            return "请求失败";
        }
    }

    /**
     * 计算印花税
     * @param $deal_money  成交金额
     * 买不用交，卖要交   1%。算
     */
    public function count_stamp_duty($deal_money){

        if(empty($deal_money)){return 0;}
        $stamp_duty = $deal_money*C('STAMP_DUTY_RATE')/1000;
        if($stamp_duty<C('STAMP_DUTY_MIN')) $stamp_duty = C('STAMP_DUTY_MIN');
        return $stamp_duty;
    }

    /**
     * 计算过户费
     * @param $deal_amount  成交金额
     */
    public function count_transfer_fee($deal_money){

        if($deal_money<0){return 0;}
        $fee = $deal_money*C('TRANSFER_FEE_RATE')/1000;
        if($fee<C('TRANSFER_FEE_MIN')) $fee = C('TRANSFER_FEE_MIN');
        return $fee;
    }

    /**
     * 计算委托费
     * @param $pen 成交金额
     * @param $type 1为深圳 2为上海
     * 委托费：	成交金额*0。暂时不收取，今后修改就可以收取
     */
    public function count_entrust_fee($type=1,$pen=1)
    {
        $fee = C('ENTRUST_FEE_RATE');
        $val = ($pen*$fee)/1000;
        return $val;
    }

    /**
     * 计算佣金
     * @param $deal_money  成交金额
     * @param $rate  佣金利率
     */
    public function count_commission($buy_money,$rate){

        if($buy_money<0){return 0;}
        $fee = $buy_money*$rate/1000;
        if($fee<C('COMMISSION_MIN')) $fee = C('COMMISSION_MIN');
        return $fee;
    }


}