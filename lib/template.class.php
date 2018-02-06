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
 * @version 1.2.0
 * @author Jokin
**/
class template {
  public static $public_page = array("login");

  public static $page = "upload";

  public static function run(){
    // 授权管理
    self::auth();
    $page = self::$page = P;  // 初始页面在初始化类中设置
    // 默认跳转页
    if( !is_file("./lib/tpl/{$page}.tpl") ){
      $page = "upload";  // 页面不存在自动跳转到首页
      self::$page = "upload";
    }
    $page = file_get_contents("./lib/tpl/{$page}.tpl");

    // download
    if( self::$page == "manager" ){
      $files = sdk::getFiles();
      $_c = "<tr id='~~#3!'><td class=\"text-truncate\">~~#1!</td><td>~~#2! M</td><td>";
      $_content = "";
      if( is_array($files) ){
        foreach ($files as $key => $file) {
          $_temp = $_c;
          $_handle = "<a class=\"text-primary\" href=\"javascript:;\" onclick=\"downloader('http://".C("DM")."/".$file['key']."');\">下载</a> | <a class=\"text-danger\" href=\"javascript:;\" onclick=\"javascript:del('{$file['key']}','{$file['hash']}');\">删除</a>";
          $_temp = str_replace("~~#1!", $file['key'], $_temp);
          $_temp = str_replace("~~#2!", round($file['fsize']/1024/1024, 2), $_temp);
          $_temp = str_replace("~~#3!", $file['hash'], $_temp);
          $_temp .= $_handle."</td></tr>";
          $_content .= $_temp;
        }
      }
      $page = str_replace("==list==", $_content, $page);
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
  static public function conReference($content){
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
  static public function pageInclude($content){
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
  }

}
?>
