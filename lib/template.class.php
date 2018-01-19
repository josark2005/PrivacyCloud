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
 * Template Processor
 * @version 1.1.1
 * @author Jokin
**/
class template {
  public static $page = "upload";
  public static function run(){
    if( !isset($_GET['page']) || $_GET['page'] == "index" ){
      self::$page = "index";
    }else{
      self::$page = $_GET['page'];
    }
    $page = self::$page;
    if( !is_file("./lib/tpl/{$page}.tpl") ){
      $page = "upload";  // 页面不存在自动跳转到首页
      self::$page = "upload";
    }
    $page = file_get_contents("./lib/tpl/{$page}.tpl");
    // download
    if( self::$page == "download" ){
      $files = sdk::getFiles();
      $_c = "<tr><td class=\"text-truncate\">1</td><td>2 M</td><td>";
      $_content = "";
      foreach ($files as $key => $file) {
        $_temp = $_c;
        $_handle = "<a class=\"text-primary\" href=\"//".DM."/".$file['key']."\" target=\"_blank\">下载</a> | <a class=\"text-danger\" onclick=\"javascript:del('".$file['key']."');\">删除</a>";
        $_temp = str_replace("1", $file['key'], $_temp);
        $_temp = str_replace("2", round($file['fsize']/1024/1024, 2), $_temp);
        $_temp .= $_handle."</td></tr>";
        $_content .= $_temp;
      }
      $page = str_replace("==list==", $_content, $page);
    }
    // _del
    if( self::$page == "_del" && isset($_GET['key']) && !empty($_GET['key']) ){
      $res = sdk::delFile($_GET['key']);
      if(!$res){
        echo "{\"message\":\"error.\"}";
        exit();
      }
    }
    // _update
    if( self::$page == "_update" && isset($_GET['version']) && !empty($_GET['version']) ){
      $basic_url = "http://pc.twocola.com/";
      $filename = $_GET['version'].".zip";
      $file = file_get_contents($basic_url."update/".$filename);
      if($file){
        file_put_contents("./_update.zip", $file);
        $file_md5 = mb_strtoupper(MD5($file), "utf-8");
        // 验证md5
        $_md5 = file_get_contents($basic_url."release/lastest.md");
        $_md5 = htmlspecialchars_decode($_md5);
        $_md5 = json_decode($_md5, true); // 解析为数组
        $_md5 = $_md5['md5'];
        if( $file_md5 != $_md5 ){
          echo "{\"message\":\"bad md5.\"}";
          exit();
        }
        $zip = new \ZipArchive;
        if( $zip->open("./_update.zip") ){
          if( $zip->extractTo("./") ){
            $zip->close();
            unlink("./_update.zip");
            echo "{\"message\":\"complete.\"}";
            exit();
          }else{
            echo "{\"message\":\"error.\"}";
            exit();
          }
        }else{
          echo "{\"message\":\"error.\"}";
          exit();
        }
      }else{
        echo "{\"message\":\"error.\"}";
        exit();
      }
    }
    $page = self::ConReference($page);
    echo $page;
  }

  /**
  * 常量引用
  * @param  string  $content 内容
  * @return string  $content
  **/
  static public function ConReference($content){
    $pattern = "/__(.+)__/U";
    $preg = preg_match_all($pattern,$content,$matches);
    if($preg!=0){
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
      for($i=0;$i<count($matches[0]);$i++){
        if( defined($matches[1][$i]) ){
          $const = constant($matches[1][$i]);
          $content = str_replace($matches[0][$i],$const,$content);
        }
      }
    }
    return $content;
  }
}
?>
