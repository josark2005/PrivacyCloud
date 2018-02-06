<?php
// +----------------------------------------------------------------------
// | Constructed by Jokin [ Think & Do & To Be Better ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 Jokin All rights reserved.
// +----------------------------------------------------------------------
// | Author: Jokin <Jokin@twocola.com>
// +----------------------------------------------------------------------
/**
 * Debug Controller
 * @version 1.0.1
 * @author Jokin
**/
namespace PrivacyCloud;
class debug {

  public static function error_report(){
    if( C("DEBUG") === false ){
      error_reporting(0);
    }
  }

  public static function header_json(){
    if( C("DEBUG") === false ){
      header('Content-Type:text/json;charset=utf-8');
    }
  }

}

?>
