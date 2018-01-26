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
 * Ziper
 * @version 1.0.0
 * @author Jokin
**/
class ziper {
  public $zip = null;
  public $errcode = null;
  public $errlog = null;
  public $errnum = 0;
  /**
   * initialize
   * @param  string file
   * @return mixed
  **/
  public function __construct($file, $type="w"){
    self::$zip = new \ZipArchive();
    switch ($type) {
      case 'w':
        $type = \ZipArchive::OVERWRITE;
        break;
      case 'c':
        $type = \ZipArchive::CREATE;
        break;

      default:
        $type = \ZipArchive::OVERWRITE;
        break;
    }
    $res = $zip->open($file, $type);
    if( $res !== TRUE ){
      self::$errcode = $res;
      return FALSE;
    }else{
      return self;
    }
  }

  /**
   * addFolder
   * @param  string path
   * @return object
  **/
  public function addFolder($path){
    // 修正目录
    $path = str_replace("\\", "/", $path);
    $starter = mb_substr($path, 0, 1);
    $starter2 = mb_substr($path, 0, 2);
    $starter3 = mb_substr($path, 0, 3);
    if($starter3 == "../"){
      $basepath = mb_substr($path, 3);
    }else if($starter2 == "./"){
      $basepath = mb_substr($path, 2);
    }else if($starter == "/"){
      $basepath = mb_substr($path, 1);
    }
    if( is_dir($path) ){
      $dirs = scandir($path);
      foreach ($dirs as $key => $value) {
        if( $value != "." && $value != ".." ){
          if( is_dir($path."/".$value) ){
            addFolder($zip, $path."/".$value);
          }else{
            if(!self::$zip->addFile($path."/".$value, $basepath."/".$value)){
              self::$errlog[] = "[AddM]".$path."/".$value;
              self::$errnum ++;
            }
          }
        }
      }
    }
    return self;
  }

  /**
   * addFile
   * @param  string path
   * @return object
  **/
  public function addFile($path){
    // 修正目录
    $path = str_replace("\\", "/", $path);
    $starter = mb_substr($path, 0, 1);
    $starter2 = mb_substr($path, 0, 2);
    $starter3 = mb_substr($path, 0, 3);
    if($starter3 == "../"){
      $basepath = mb_substr($path, 3);
    }else if($starter2 == "./"){
      $basepath = mb_substr($path, 2);
    }else if($starter == "/"){
      $basepath = mb_substr($path, 1);
    }
    if(!self::$zip->addFile($path."/".$value, $basepath."/".$value)){
      self::$errlog[] = "[AddS]".$path."/".$value;
      self::$errnum ++;
    }
    return self;
  }

  /**
   * extract
   * @param  string path
   * @return object
  **/
  public function extract($path){
    if(!self::$zip->extractTo($path."/".$value, $basepath."/".$value)){
      self::$errlog[] = "[Ext2]".$path."/".$value;
      self::$errnum ++;
    }
    return self;
  }

  /**
   * destory
   * @param  void
   * @return void
  **/
  public function __destruct(){
    self::$zip->close();
  }

}

?>
