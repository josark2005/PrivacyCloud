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
    C("FLUX", "-1", true);
    // 安全检测
    // 1.3.1-1.3.2遗留问题
    if( is_file("./index.php.bak") ){
      C("_DANGER", "R-1");
      C("_DANGER_MSG", "可能存在重要备份文件被下载的隐患");
      C("_DANGER_API_FILE", "safety");
      C("_DANGER_API_METHOD", "delIndexBak");
    }
    // 备份包
    if( is_file("./__pcbkup.zip") ){
      C("_DANGER", "R-2");
      C("_DANGER", "可能存在重要备份文件被下载的隐患");
      C("_DANGER_MSG", "可能存在重要备份文件被下载的隐患");
      C("_DANGER_API_FILE", "safety");
      C("_DANGER_API_METHOD", "delBak");
    }
  }
}
?>
