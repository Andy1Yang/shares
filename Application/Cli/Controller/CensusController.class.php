<?php
namespace Cli\Controller;
use Think\Controller;
/**
 * 金币兑换率方法
 */

class CensusController extends CliController{

    //统计每天返息
    public function returnInterest(){
        //交易流水里取占用金额
        $sql = "SELECT sum(occupy_money) as occupy_money_total,user_id,member_id FROM `ss_deal_log` where status=1 group by user_id";
        $Model = new \Think\Model();
        $occupyList = $Model->query($sql);
        $now = time();
        $date = date('Y-m-d',$now);
        $startTime = strtotime($date);
        $endTime = $startTime+24*3600;
        $i = 0;
        foreach($occupyList as $item){
            $userArr = M('user')->where('id='.$item['user_id'])->field('rate,ensure_money,member_id')->find();
            $ensureArr = M('capital_log')->where("do_time>={$startTime} and do_time<{$endTime} and user_id={$item['user_id']}")->order('ensure_money')->field('ensure_money')->find();
            if(empty($ensureArr)){
                $ensure_money = $userArr['ensure_money'];
            }else{
                $ensure_money = $ensureArr['ensure_money'];
            }
            $differ = $item['occupy_money_total']-$ensure_money;
            if($differ>=0){
                $returnInterest = $ensure_money*$userArr['rate']/10000;
            }else{
                $returnInterest = $item['occupy_money_total']*$userArr['rate']/10000;
            }
            $dayInterest = $item['occupy_money_total']*$userArr['rate']/10000;
            //添加到返息表里去
            $data['user_id'] = $item['user_id'];
            $data['member_id'] = $item['member_id'];
            $data['return_interest'] = $returnInterest;
            $data['day_interest'] = $dayInterest;
            $data['date'] = $date;
            $data['add_time'] = $now;
            $bool = M('return_interest_log')->add($data);
            if($bool){
                $i++;
            }
        }
        echo "成功添加返息{$i}条";

    }

}