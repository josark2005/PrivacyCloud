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
 * @version 1.2.1
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
      $page = "upload";  // 页面不存在自动跳转到首页
      self::$page = "upload";
    }
    $page = file_get_contents("./lib/tpl/{$page}.tpl");

    // download
    if( self::$page == "manager" ){
      // 获取前缀定义
      if( isset($_GET['prefix']) && !empty($_GET['prefix']) ){
        $prefix = $_GET['prefix'];
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
      $_c = "<tr id='~~#3!'><td class=\"text-truncate text-danger\"><i class=\"fas fa-folder\"></i> ~~#1!</td><td>~~#2!</td><td>";
      $_content = "";
      if( is_array($files) ){
        if( isset($files['commonPrefixes']) && is_array($files['commonPrefixes']) ){
          foreach ($files['commonPrefixes'] as $key => $folder) {
            $folder_name = mb_substr($folder, mb_strlen($prefix), mb_strlen($folder) - mb_strlen($prefix) );
            $fix = "";
            if( mb_substr($folder, mb_strlen($folder)-1, 1) === "/" ){
              $folder = mb_substr($folder, 0, mb_strlen($folder)-1);
              $fix = "/";
            }
            $_temp = $_c;
            $_handle = "<a class=\"text-primary\" href=\"javascript:;\" onclick=\"enter('".$folder.$fix."');\">进入</a>";
            $_temp = str_replace("~~#1!", $folder_name, $_temp);
            $_temp = str_replace("~~#2!", "文件夹", $_temp);
            $_temp = str_replace("~~#3!", base64_encode($folder), $_temp);
            $_temp .= $_handle."</td></tr>";
            $_content .= $_temp;
          }
        }
        // 获取文件
        $_c = "<tr id='~~#3!'><td class=\"text-truncate\">~~#1!</td><td>~~#2!</td><td>";
        if( isset($files['items']) && is_array($files['items']) ){
          foreach ($files['items'] as $key => $file) {
            $file['name'] = mb_substr($file['key'], mb_strlen($prefix), mb_strlen($file['key']) - mb_strlen($prefix) );
            $_temp = $_c;
            $_handle = "<a class=\"text-primary\" href=\"javascript:;\" onclick=\"downloader('http://".C("DM")."/".$file['key']."');\">下载</a> | <a class=\"text-danger\" href=\"javascript:;\" onclick=\"javascript:del('{$file['key']}','{$file['hash']}');\">删除</a>";
            $_size = round($file['fsize']/1024/1024, 2) === (float)0 ? round($file['fsize']/1024, 2)." K" :round($file['fsize']/1024/1024, 2)." M";
            $_temp = str_replace("~~#1!", $file['name'], $_temp);
            $_temp = str_replace("~~#2!", $_size, $_temp);
            $_temp = str_replace("~~#3!", $file['hash'], $_temp);
            $_temp .= $_handle."</td></tr>";
            $_content .= $_temp;
          }
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
