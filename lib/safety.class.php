<?php
// +----------------------------------------------------------------------
// | Constructed by Jokin [ Think & Do & To Be Better ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 Jokin All rights reserved.
// +----------------------------------------------------------------------
// | Author: Jokin <Jokin@twocola.com>
// +----------------------------------------------------------------------
/**
 * Safety Core
 * @version 1.0.1
 * @author Jokin
**/
namespace PrivacyCloud;
class safety {
  public static function authorizate($pw){
    $pw = MD5(md5($pw.C("SAFE_ENCRYPTION")));
    return $pw;
  }
  public static function is_auth(){
    // 无密码放行
    if( !C("AUTH_PW") || C("AUTH_PW") === "" ){
      return true;
    }
    if( isset($_COOKIE['token']) && $_COOKIE['token'] === self::authorizate(C("AUTH_PW")) ){
      return true;
    }else{
      return false;
    }
  }
}
?>
