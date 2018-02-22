<?php
// +----------------------------------------------------------------------
// | Constructed by Jokin [ Think & Do & To Be Better ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 Jokin All rights reserved.
// +----------------------------------------------------------------------
// | Author: Jokin <Jokin@twocola.com>
// +----------------------------------------------------------------------
/**
 * Read Configuration
 * @param  string name
 * @param  string value
 * @param  boolean is_write
 * @return mixed
**/
function C($name, $value = "", $is_write = false){
  $name = strtoupper($name);
  $conf = \PrivacyCloud\configuration::init();
  if( empty($value) && $value !== false && $is_write === false ){
    if(!$conf->exists($name)){
      return ( defined($name) ) ? constant($name) : false;
    }else{
      return $conf->readConf($name);
    }
  }else{
    $conf->setConf($name,$value);
  }
}
?>
