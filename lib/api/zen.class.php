<?php
// +----------------------------------------------------------------------
// | Constructed by Jokin [ Think & Do & To Be Better ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 Jokin All rights reserved.
// +----------------------------------------------------------------------
// | Author: Jokin <Jokin@twocola.com>
// +----------------------------------------------------------------------
/**
 * Zen API
 * @version  1.0.0
 * @author Jokin
**/
class zen {
  public function getZen(){
    $basic_url = C("update_basic_url");
    // 检查是否支持Zen
    $check = @file_get_contents($basic_url."check.md");
    if( !$check ){
      $err['code'] = "JPCAE04";
      $err['msg'] = "bad service info";
      $err['msg_zh'] = "获取服务信息失败";
      echo json_encode($err);
      exit();
    }
    $check = htmlspecialchars_decode($check);
    $check = json_decode($check, true); // 解析为数组
    if( !isset($check['zen']) ){
      $err['code'] = "JPCAE04";
      $err['msg'] = "bad service info";
      $err['msg_zh'] = "获取服务信息失败";
      echo json_encode($err);
      exit();
    }
    if( $check['zen'] !== true ){
      $err['code'] = "JPCAE05";
      $err['msg'] = "Zen is not being supported";
      $err['msg_zh'] = "不支持Zen服务";
      echo json_encode($err);
      exit();
    }
    // 检查Zen列表
    $count = @file_get_contents($basic_url."resources/zen/list.md");
    if( !$count ){
      $err['code'] = "JPCAE04";
      $err['msg'] = "bad service info";
      $err['msg_zh'] = "获取服务信息失败";
      echo json_encode($err);
      exit();
    }
    $count = htmlspecialchars_decode($count);
    $count = json_decode($count, true); // 解析为数组
    if( !isset($count['allCount']) || $count['allCount'] === 0 ){
      $err['code'] = "JPCAE05";
      $err['msg'] = "Zen is not being supported";
      $err['msg_zh'] = "不支持Zen服务";
      echo json_encode($err);
      exit();
    }
    $count = $count['allCount'];
    $zid = mt_rand(1, $count-1);
    // 获取Zen
    $zen = @file_get_contents($basic_url."resources/zen/json/{$zid}.md");
    if( !$zen ){
      $err['code'] = "JPCAE06";
      $err['msg'] = "bad zen";
      $err['msg_zh'] = "Zen服务错误";
      echo json_encode($err);
      exit();
    }
    $zen = htmlspecialchars_decode($zen);
    $zen = json_decode($zen, true); // 解析为数组
    if( !isset($zen['zen']) ){
      $err['code'] = "JPCAE06";
      $err['msg'] = "bad zen";
      $err['msg_zh'] = "Zen服务错误";
      echo json_encode($err);
      exit();
    }
    $zen['url'] = $basic_url."resources/zen/page/{$zid}.html";
    $err['code'] = "0";
    $err['msg'] = "success";
    $err['msg_zh'] = "成功获取Zen";
    $err['data'] = $zen;
    echo json_encode($err);
    exit();
  }

}
?>
