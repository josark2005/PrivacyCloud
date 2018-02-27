<?php
// +----------------------------------------------------------------------
// | Constructed by Jokin [ Think & Do & To Be Better ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 Jokin All rights reserved.
// +----------------------------------------------------------------------
// | Author: Jokin <Jokin@twocola.com>
// +----------------------------------------------------------------------
namespace PrivacyCloud;
class initialize {
  public static function atCore(){
    // 安全头
    header('X-Frame-Options: Deny');
    // 注册行为
    if( C("MODE") === router::MODE_API ){
      // api
      define("A", isset($_GET['a'])?$_GET['a']:mb_strtolower(C("SP")));
      define("M", isset($_GET['m'])?$_GET['m']:false);
    }else{
      define("P", isset($_GET['page'])?$_GET['page']:"index");
    }
    // 安全码设置
    if( C("SAFE_ENCRYPTION") === false ){
      C("SAFE_ENCRYPTION", "PrivacyCloud2018", true);
    }
    // Cookie续期
    if( isset($_COOKIE['token']) ){
      setcookie("token", $_COOKIE['token'], time() + 3600);
    }
    C("FLUX", "-1", true);
    // 安全检测
    // 调试模式检测
    if( C("DEBUG") === true ){
      C("_DANGER", "R-5");
      C("_DANGER_MSG", "调试模式处于开启状态");
      C("_DANGER_API_FILE", "safety");
      C("_DANGER_API_METHOD", "toggleDebug");
    }
    // 1.3.1-1.3.2遗留问题
    if( is_file("./index.php.bak") ){
      C("_DANGER", "R-1");
      C("_DANGER_MSG", "可能存在重要备份文件被下载的隐患");
      C("_DANGER_API_FILE", "safety");
      C("_DANGER_API_METHOD", "delIndexBak");
    }
    // 备份包
    if( is_file("./_pcbkup.zip") ){
      C("_DANGER", "R-2");
      C("_DANGER_MSG", "可能存在重要备份文件被下载的隐患");
      C("_DANGER_API_FILE", "safety");
      C("_DANGER_API_METHOD", "delBak");
    }
    // 升级包
    if( is_file("./_update.zip") || is_file("./_update.php")){
      C("_DANGER", "R-3");
      C("_DANGER_MSG", "可能存在重要备份文件被下载的隐患");
      C("_DANGER_API_FILE", "safety");
      C("_DANGER_API_METHOD", "delUpd");
    }
  }
}
?>
