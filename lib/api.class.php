<?php
// +----------------------------------------------------------------------
// | Constructed by Jokin [ Think & Do & To Be Better ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 Jokin All rights reserved.
// +----------------------------------------------------------------------
// | Author: Jokin <Jokin@twocola.com>
// +----------------------------------------------------------------------
namespace PrivacyCloud;
/**
 * API Processor
 * @version 1.0.0
 * @author Jokin
**/
class api {

public static function run(){
  $a = (isset($_GET['a'])) ? $_GET['a'] : C('SP');
  if( isset($_GET['m']) && !empty($_GET['m'])
  && is_file("./lib/api/{$a}.class.php")
  ){
    include "./lib/api/{$a}.class.php";
    $api = new $a;
    if( method_exists($api, $_GET['m']) ){
      debug::header_json();
      // header('Content-Type:text/json;charset=utf-8');
      $m = $_GET['m'];
      $api->$m();
      // $api->$_GET['m']();
    }else{
      $err['code'] = "JPCAE001";
      $err['msg'] = "bad api.";
      $err['msg_zh'] = "无效的API访问请求";
      exit(json_encode($err));
    }
  }else{
    $err['code'] = "JPCAE002";
    $err['msg'] = "bad api.";
    $err['msg_zh'] = "无效的API访问请求";
    exit(json_encode($err));
  }
}

}
?>
