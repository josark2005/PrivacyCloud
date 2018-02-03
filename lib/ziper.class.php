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
 * Ziper
 * @version 1.1.0
 * @author Jokin
**/
class ziper {
  public $zip = null;
  public $errcode = null;
  public $errlog = null;
  public $errnum = 0;
  /**
   * initializey
   * @param  string file
   * @return mixed
  **/
  public function __construct($file, $type="w"){
    $this->zip = new \ZipArchive();
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
    $res = $this->zip->open($file, $type);
    if( $res !== TRUE ){
      $this->errcode = $res;
      return FALSE;
    }else{
      return $this;
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
            $this->addFolder($path."/".$value);
          }else{
            if(!$this->zip->addFile($path."/".$value)){
              $this->errlog[] = "[AddM]".$path."/".$value;
              $this->errnum ++;
            }
          }
        }
      }
    }
    return $this;
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
    if(!$this->zip->addFile($basepath)){
      $this->errlog[] = "[AddS]".$path;
      $this->errnum ++;
    }
    return $this;
  }

  /**
   * extract
   * @param  string path
   * @return object
  **/
  public function extract($path){
    if(!$this->zip->extractTo($path."/".$value, $basepath."/".$value)){
      $this->errlog[] = "[Ext2]".$path."/".$value;
      $this->errnum ++;
    }
    return $this;
  }

  /**
   * destory
   * @param  void
   * @return void
  **/
  public function __destruct(){
    $this->zip->close();
  }

}

?>
