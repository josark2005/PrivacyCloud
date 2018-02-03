<?php
// +----------------------------------------------------------------------
// | Constructed by Jokin [ Think & Do & To Be Better ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 Jokin All rights reserved.
// +----------------------------------------------------------------------
// | Author: Jokin <Jokin@twocola.com>
// +----------------------------------------------------------------------
/**
 * Router Core
 * @version 1.0.0
 * @author Jokin
**/
namespace PrivacyCloud;
class router {
  const MODE_APP = 1801300;
  const MODE_API = 1801301;
  static public $analyzed = null;
  /**
   * Analyze Path
   * @param  string path
   * @return mixed
  **/
  static public function analyze($path){
    $analyzed = null; // initialize
    if( isset($path['mode']) && $path['mode'] === "api"){
      $analyzed['mode'] = self::MODE_API;
      C("MODE", self::MODE_API);
    }
    if( isset($path['page']) ){
      C("PAGE", $path['page']);
    }
    self::$analyzed = $analyzed;
  }
  /**
   * redirect
   * @param  string path
   * @return void
  **/
  static public function redirect($path){
    header("Location: ?page={$path}");
  }

}
?>
