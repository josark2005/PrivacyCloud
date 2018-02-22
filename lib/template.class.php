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
 * Template Processor
 * @version 1.2.2
 * @author Jokin
**/
class template {
  public static $public_page = array("login");

  public static $page = "manager";

  public static function run(){
    // 授权管理
    self::auth();
    $page = self::$page = P;  // 初始页面在初始化类中设置
    // 默认跳转页
    if( !is_file("./lib/tpl/{$page}.tpl") ){
      $page = "manager";  // 页面不存在自动跳转到首页
      self::$page = "manager";
    }
    $page = file_get_contents("./lib/tpl/{$page}.tpl");

    // download
    if( self::$page == "manager" ){
      // 获取前缀定义
      C("PREFIX_LEN", 0, true);
      if( isset($_GET['prefix']) && !empty($_GET['prefix']) ){
        $prefix = $_GET['prefix'];
        C("PREFIX_LEN", mb_strlen($prefix), true);
        if( mb_substr($prefix, mb_strlen($prefix)-1, 1) === "/"  ){
          $_prefix = mb_substr($prefix, 0, mb_strlen($prefix)-1);
          C("BKTRS_PREFIX", json_encode(explode("/", $_prefix)));
        }
      }else{
        $prefix = "";
        C("BKTRS_PREFIX", json_encode($prefix));
      }
      // 获取标记
      if( isset($_GET['marker']) && !empty($_GET['marker']) ){
        $marker = $_GET['marker'];
      }else{
        $marker = "";
      }
      $files = sdk::getFiles($prefix, $marker);
      // 传入数据
      $d = json_encode($files);
      $d = str_replace("\"", "\\\"", $d);
      C("PAGE_MANAGER_DATA_FILELIST", $d);
    }
    // 处理
    $page = self::pageInclude($page);
    $page = self::conReference($page);
    echo $page;
  }

  /**
  * 常量引用
  * @param  string  content 内容
  * @return string  content
  **/
  public static function conReference($content){
    $pattern = "/__(.+)__/U";
    $preg = preg_match_all($pattern,$content,$matches);
    if($preg !== 0){
      //去除重复
      $matches[0] = array_unique($matches[0]);
      $matches[1] = array_unique($matches[1]);
      $i = 0;
      $res = "";
      foreach($matches[0] as $match){
        $res[0][$i] = $match;
        $i++;
      }
      $i = 0;
      foreach($matches[1] as $match){
        $res[1][$i] = $match;
        $i++;
      }
      $matches = $res;
      for($i=0; $i<count($matches[0]); $i++){
        $const = C($matches[1][$i]);
        $content = str_replace($matches[0][$i],$const,$content);
      }
    }
    return $content;
  }

  /**
  * 页面引用
  * @param  string  content 内容
  * @return string  content
  **/
  public static function pageInclude($content){
    $path = "./lib/tpl/public/";
    $suffix = ".tpl";
    $pattern = "/{_(.+)_}/U";
    $preg = preg_match_all($pattern,$content,$matches);
    if($preg !== 0){
      //去除重复
      $matches[0] = array_unique($matches[0]);
      $matches[1] = array_unique($matches[1]);
      for ($i=0; $i < count($matches[1]); $i++) {
        if( is_file($path.$matches[1][$i].$suffix) ){
          $c = file_get_contents($path.$matches[1][$i].$suffix);
          $content = str_replace($matches[0][$i], $c, $content);
        }
      }
    }
    return $content;
  }

  private static function auth(){
    $auth = safety::is_auth();
    if( !$auth && !in_array(P, self::$public_page, true) ){
      router::redirect("login");
      exit();
    }
    // 登录状态自动跳转
    if( $auth && C("PAGE") === "login" ){
      router::redirect("index", true);
      exit();
    }
  }

}
?>
