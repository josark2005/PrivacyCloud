<?php
// +----------------------------------------------------------------------
// | Constructed by Jokin [ Think & Do & To Be Better ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 Jokin All rights reserved.
// +----------------------------------------------------------------------
// | Author: Jokin <Jokin@twocola.com>
// +----------------------------------------------------------------------
/**
 * Main API
 * @version  1.0.0
 * @author Jokin
**/
class install {
  public function getDomain(){
    if( isset($_POST['ak'], $_POST['sk'], $_POST['bkt'], $_POST['sp']) ){
      $domain = PrivacyCloud\sdk::getDoamin($_POST['ak'], $_POST['sk'], $_POST['bkt']);
      if( method_exists($domain, "message") ){
        $err['code'] = "JPCAE02";
        $err['msg'] = $domain->message();
        $err['msg_zh'] = "获取Domain失败";
        exit(json_encode($err));
      }else{
        $err['code'] = "0";
        $err['msg'] = "success";
        $err['msg_zh'] = "成功获取";
        $err['data'] = $domain;
        exit(json_encode($err));
      }
    }else{
      $err['code'] = "JPCAE01";
      $err['msg'] = "bad infomation";
      $err['msg_zh'] = "提交的数据不合法";
      exit(json_encode($err));
    }
  }
  public function setOptions(){
    if( isset($_POST['ak'], $_POST['sk'], $_POST['bkt'], $_POST['sp'], $_POST['dm'], $_POST['qd'], $_POST['upd'], $_POST['auth_pw']) ){
      if( !is_file("./config.inc.php") ){
        $err['code'] = "JPCAD03";
        $err['msg'] = "confinguration file lost";
        $err['msg_zh'] = "设置文件丢失";
        exit(json_encode($err));
      }
      include "./config.inc.php";
      $config["SP"] = $_POST['sp'];
      $config["AK"] = $_POST['ak'];
      $config["SK"] = $_POST['sk'];
      $config["BKT"] = $_POST['bkt'];
      $config["DM"] = $_POST['dm'];
      $config["QD"] = $_POST['qd'];
      $config["AUTH_PW"] = $_POST['auth_pw'];
      $config["UPDATE_BASIC_URL"] = $_POST['upd'];
      $linefeed = PHP_EOL;
      $content = "<?php{$linefeed}\$config=".var_export($config,true).";";
      $res = file_put_contents("./config.inc.php", $content);
      if( $res ){
        $err['code'] = "0";
        $err['msg'] = "success";
        $err['msg_zh'] = "设置成功";
        exit(json_encode($err));
      }else{
        $err['code'] = "JPCAD04";
        $err['msg'] = "failed to write confinguration file";
        $err['msg_zh'] = "设置文件无法写入";
        exit(json_encode($err));
      }
    }else{
      $err['code'] = "JPCAE01";
      $err['msg'] = "bad infomation";
      $err['msg_zh'] = "提交的数据不合法";
      exit(json_encode($err));
    }
  }
}
?>
