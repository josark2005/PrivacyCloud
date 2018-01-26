<?php
// +----------------------------------------------------------------------
// | Twocola PHP Engine [ DO IT　EASY ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2017 Twocola Studio All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: Jokin <327928971@qq.com>
// +----------------------------------------------------------------------
/**
 * Read Configuration
 * @param  string name
 * @param  string value
 * @param  string is_write
 * @return mixed
**/
function C($name, $value = "", $is_write = false){
  $conf = \PrivacyCloud\configuration::init();
  if( empty($value) && $value !== false && $is_write === false ){
    if(!$conf->exists($name)){
      return ( defined(strtoupper($name)) ) ? constant( strtoupper($name) ) : false;
    }else{
      return $conf->readConf($name);
    }
  }else{
    $conf->setConf($name,$value);
  }
}
?>
