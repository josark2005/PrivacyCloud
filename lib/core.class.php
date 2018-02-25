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
 * @author Jokin
**/
class Core {
  /**
   * 初始化系统
   * @param  void
   * @return void
  **/
  public static function initialize(){
    // 环境版本判断
    if( version_compare(PHP_VERSION ,"5.6.0" ,"<") ){
      die("您的环境不支持运行Privacy Cloud，要求PHP版本大于等于5.6.0");
    }
    // 版本信息
    define("VERSION", "1.5.0");
    define("CORE_VERSION", "2.0.0");
    // 注册autoload方法
    spl_autoload_register("PrivacyCloud\Core::autoload");
    // 载入系统配置
    configuration::init()->analyzeConf("./config.inc.php", "config");
    // 载入系统方法
    include("./lib/function.php");
    // 关闭报错
    debug::error_report();
    // 安装更新
    self::exec_update();
    // 检查系统完整性
    self::verify();
    // 解析路径
    router::analyze($_GET);
    // 初始化
    initialize::atCore();
    // 载入SDK
    sdk::loader();
    if( C("MODE") === router::MODE_API ){
      api::run();
    }else{
      template::run();
    }
  }


  /**
   * Autoload
   * @param  class string
   * @return void
  */
  public static function autoload($class){
    $root_path = "./";
    $class_exploded = explode("\\", $class);
    if( $class_exploded[0] == "PrivacyCloud" ){
      $root_path = "./lib/";
    }
    $path = $root_path.$class_exploded[1].".class.php";
    if ( !is_file($path) ){
      return false;
    }
    include $path;
  }

  /**
   * verify
   * @param  void
   * @return void
  **/
  public static function verify($is_again = false){
    // 检查配置文件
    if( !is_file("./config.inc.php") ){
      if( !is_file("./lib/assets/configuration/config.inc.php.tpl") ){
        exit("[ERROR]Lost configuration file.");
      }else if( $is_again === false ){
        $conf = file_get_contents("./lib/assets/configuration/config.inc.php.tpl");
        file_put_contents("./config.inc.php", $conf);
        self::verify(true);
      }else{
        exit("[ERROR]Failed to create the configuration file.");
      }
    }
  }

  /**
   * Execute Update
   * @param  void
   * @return void
  **/
  public static function exec_update(){
    if( is_file("./_update.php") ){
      include("./_update.php");
      unlink("./_update.php");
    }
  }
}

?>
