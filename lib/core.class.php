<?php
// +----------------------------------------------------------------------
// | Writed by Jokin [ Think & Do & To Be Better ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 Jokin All rights reserved.
// +----------------------------------------------------------------------
// | Author: Jokin <Jokin@twocola.com>
// +----------------------------------------------------------------------
namespace PrivacyCloud;
/**
 * Core
 * @version 1.0.0
 * @author Jokin
**/
class Core {
  /**
   * 初始化系统
   * @param  void
   * @return void
  **/
  public static function initialize(){
    // 版本信息
    define("VERSION", "1.3.0");
    // 关闭报错
    error_reporting(0);
    // 注册autoload方法
    spl_autoload_register("PrivacyCloud\Core::autoload");
    // 载入SDK
    sdk::loader();
    // 获取FLUX
    sdk::getFlux();
    // 获取UPTOKEN
    sdk::getUpToken();
    // 页面处理
    template::run();
  }


  /**
   * Autoload
   * @param  class string
   * @return void
  */
  static public function autoload($class){
    $root_path = "./";
    // var_dump($class);
    $class_exploded = explode("\\", $class);
    // var_dump($class_exploded);
    if( $class_exploded[0] == "PrivacyCloud" ){
      $root_path = "./lib/";
    }
    $path = $root_path.$class_exploded[1].".class.php";
    if ( !is_file($path) ){
      return false;
    }
    // var_dump($path);
    include $path;
  }
}

?>
