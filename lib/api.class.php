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

public static $public_api = array(
  "main"  => array("login"),
  "zen"   => array("getZen"),
);

public static function run(){
  // 授权管理
  self::auth();
  $a = A;
  $m = M;
  if( is_file("./lib/api/{$a}.class.php") ){
    include "./lib/api/{$a}.class.php";
    $api = new $a;
    if( method_exists($api, $m) ){
      debug::header_json();
      $api->$m();
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

private static function auth(){
  $auth = safety::is_auth();
  if( !$auth ){
    if( !isset(self::$public_api[A]) ){
      $err['code'] = "JPCAE003";
      $err['msg'] = "bad token.";
      $err['msg_zh'] = "口令不合法或错误";
      exit(json_encode($err));
    }else if( !in_array(M, self::$public_api[A]) ){
      $err['code'] = "JPCAE004";
      $err['msg'] = "bad token.";
      $err['msg_zh'] = "口令不合法或错误";
      exit(json_encode($err));
    }
  }
}
}
?>
