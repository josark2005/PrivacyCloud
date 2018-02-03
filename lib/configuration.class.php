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
 * Configuration Core
 * @version 1.0.1
 * @author Jokin
**/
class configuration {
  private static $self = null;
  public static $configurations = null;

  private function __construct(){
    return false;
  }

  /**
   * initialize
   * @param  void
   * @return void
  **/
  public static function init(){
    if( self::$self === null ){
      return self::$self = new self;
    }else{
      return self::$self;
    }
  }

  /**
   * Analyze Configuration
   * @param  string path
   * @param  string var
   * @return boolean
  **/
  public static function analyzeConf($path="./config.inc.php", $var="config"){
    if( is_file($path) ){
      include($path);
      if( isset($$var) && is_array($$var) ){
        foreach($$var as $k=>$c){
          self::$configurations[mb_strtoupper($k)] = $c;
        }
      }
    }else{
      return false;
    }
  }

  /**
   * Read Configuration
   * @param  string conf
   * @return mixed
  **/
  public static function readConf($conf){
    $conf = mb_strtoupper($conf);
    if( isset( self::$configurations[$conf]) ){
      return self::$configurations[$conf];
    }else{
      return null;
    }
  }

  /**
   * Get Configuration
   * @param  string conf
   * @return mixed
  **/
  public static function getConf(){
    return self::$configurations;
  }

  /**
   * Set Configuration
   * @param  string conf
   * @return void
  **/
  public static function setConf($conf, $value){
    self::$configurations[$conf] = $value;
    return ;
  }

  /**
   * Delete Configuration
   * @param  string conf
   * @return void
  **/
  public static function delConf($conf){
    if( isset($configurations[$conf]) ){
      unset(self::$configurations[$conf]);
    }
    return ;
  }

  /**
   * Configuration Exists
   * @param  string conf
   * @return boolean
  **/
  public static function exists($conf){
    return isset( self::$configurations[strtoupper($conf)] );
  }


}
?>
