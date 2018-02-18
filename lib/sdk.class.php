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
 * SDK管理模块
 * @version 1.1.0
 * @author Jokin
**/
class sdk {

  // SDK路径
  const PATH_SDK = "./lib/SDK/";

  // SDK载入路径
  private static $sdk_autoload = array(
    "QINIU" => "qiniu/autoload.php",
  );

  // Calculated Path
  private static $sdkpath = false;

  /**
   * SDK载入器
   * @param  void
   * @return void
  **/
  public static function loader(){
    switch ( mb_strtoupper(C("SP")) ) {
      case "QINIU":
        self::$sdkpath = self::PATH_SDK.self::$sdk_autoload[mb_strtoupper(C("SP"))];
        break;

      default:
        if( C("PAGE") !== "configurate" ){
          if( !isset($_GET['install']) || $_GET['install'] !== "true" ){
            router::redirect("configurate");
          }else{
            // 兼容 install API
            if( isset($_POST['sp']) && !empty($_POST['sp']) ){
              self::$sdkpath = self::PATH_SDK.self::$sdk_autoload[mb_strtoupper($_POST['sp'])];
            }
          }
        }
        break;
    }
    if( self::$sdkpath ){
      include self::$sdkpath;
      // 获取FLUX
      sdk::getFlux();
      // 获取UPTOKEN
      sdk::getUpToken();
    }
  }

  /**
   * getUpTolken
   * @param  void
   * @return string
  **/
  public static function getUpToken(){
    $auth = new \Qiniu\Auth(C("AK"), C("SK"));
    $expires = 3600;
    $policy = null;
    $upToken = $auth->uploadToken(C("BKT"), null, $expires, $policy, true);
    C("UPTOKEN", $upToken);
    return $upToken;
  }

  /**
   * getUpTolken
   * @param  void
   * @return string
  **/
  public static function getFlux(){
    $auth = new \Qiniu\Auth(C("AK"), C("SK"));
    $cdnManager = new \Qiniu\Cdn\CdnManager($auth);
    $domains = explode(",", C("QD"));
    $startDate = date("Y-m-01");
    $endDate = date("Y-m-d");
    $granularity = "day";
    list($fluxData, $getFluxErr) = $cdnManager->getFluxData($domains, $startDate, $endDate, $granularity);
    if ($getFluxErr != null) {
        $flux = "获取失败";
    } else {
        $flux = 0;
        foreach ($fluxData['data'] as $domain) {
          foreach ($domain as $key => $value) {
            foreach ($value as $key => $value2) {
              $flux += $value2;
            }
          }
        }
    }
    $flux = (int) round($flux/1024/1024, 2);
    C("FLUX", $flux, true);
    return $flux;
  }

  /**
   * getFiles
   * @param  void
   * @return mixed
  **/
  public static function getFiles($prefix="", $marker=""){
    $auth = new \Qiniu\Auth(C("AK"), C("SK"));
    $bucketManager = new \Qiniu\Storage\BucketManager($auth);
    $limit = 200;
    $delimiter = '/';
    // 列举文件
    $res = null;
    do {
        list($ret, $err) = $bucketManager->listFiles(C("BKT"), $prefix, $marker, $limit, $delimiter);
        if ($err !== null) {
            return false;
        } else {
            $marker = null;
            if (array_key_exists('marker', $ret)) {
                $marker = $ret['marker'];
            }
            if( array_key_exists('items', $ret) ){
              foreach ($ret['items'] as $value) {
                $res['items'][] = $value;
              }
            }
            if( array_key_exists('commonPrefixes', $ret) ){
              foreach ($ret['commonPrefixes'] as $value) {
                $res['commonPrefixes'][] = $value;
              }
            }
        }
    } while (!empty($marker));
    return $res;
  }

  /**
   * delFile
   * @param  string key
   * @return mixed
  **/
  public static function delFile($key){
    $auth = new \Qiniu\Auth(C("AK"), C("SK"));
    $config = new \Qiniu\Config();
    $bucketManager = new \Qiniu\Storage\BucketManager($auth, $config);
    $err = $bucketManager->delete(C("BKT"), $key);
    return $err;
  }

  /**
   * getDoamin
   * @param  string ak
   * @param  string sk
   * @param  string bkt
   * @return mixed
  **/
  public static function getDoamin($ak, $sk, $bkt){
    $auth = new \Qiniu\Auth($ak, $sk);
    $config = new \Qiniu\Config();
    $bucketManager = new \Qiniu\Storage\BucketManager($auth, $config);
    list($domains, $err) = $bucketManager->domains($bkt);
    if ($err) {
        return $err;
    } else {
        return $domains;
    }
  }

  /**
   * getBkt
   * @param  string ak
   * @param  string sk
   * @return mixed
  **/
  public static function getBkt($ak, $sk){
    $auth = new \Qiniu\Auth($ak, $sk);
    $config = new \Qiniu\Config();
    $bucketManager = new \Qiniu\Storage\BucketManager($auth, $config);
    list($buckets, $err) = $bucketManager->buckets(true);
    if ($err) {
        return false;
    } else {
        return $buckets;
    }
  }

  /**
   * getDownloadUrl
   * @param  string ak
   * @param  string sk
   * @param  string bkt
   * @return mixed
  **/
  public static function getDownloadUrl($url){
    $auth = new \Qiniu\Auth(C("AK"), C("SK"));
    $signedUrl = $auth->privateDownloadUrl($url);
    return $signedUrl;
  }
}
?>
