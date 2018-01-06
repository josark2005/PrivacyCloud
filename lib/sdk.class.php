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
 * SDK管理模块
 * @version 1.0.0
 * @author Jokin
**/
class sdk {

  // SDK路径
  const PATH_SDK = "./lib/SDK/";

  // SDK载入路径
  static private $sdk_autoload = array(
    "QINIU" => "qiniu/autoload.php",
  );

  // Calculated Path
  static private $sdkpath = false;

  /**
   * SDK载入器
   * @param  void
   * @return void
  **/
  public static function loader(){
    switch ( mb_strtoupper(SP) ) {
      case "QINIU":
        self::$sdkpath = self::PATH_SDK.self::$sdk_autoload[mb_strtoupper(SP)];
        break;

      default:
        exit("[ERROR]Forget to define service provider.");
        break;
    }
    include self::$sdkpath;
  }

  /**
   * getUpTolken
   * @param  void
   * @return void
  **/
  public static function getUpToken(){
    $auth = new \Qiniu\Auth(AK, SK);
    $expires = 3600;
    $policy = null;
    $upToken = $auth->uploadToken(BUK, null, $expires, $policy, true);
    define("UPTOKEN", $upToken);
  }

  /**
   * getUpTolken
   * @param  void
   * @return void
  **/
  public static function getFlux(){
    $auth = new \Qiniu\Auth(AK, SK);
    $cdnManager = new \Qiniu\Cdn\CdnManager($auth);
    $domains = explode(",", QD);
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
    $flux = round($flux/1024/1024, 2);
    define("FLUX", $flux);
  }

  /**
   * getFiles
   * @param  void
   * @return void
  **/
  public static function getFiles(){
    $auth = new \Qiniu\Auth(AK, SK);
    $bucketManager = new \Qiniu\Storage\BucketManager($auth);
    $prefix = '';
    $marker = '';
    $limit = 200;
    $delimiter = '/';

    // 列举文件
    list($ret, $err) = $bucketManager->listFiles(BUK, $prefix, $marker, $limit, $delimiter);
    if ($err !== null) {
        // echo "\n====> list file err: \n";
        // var_dump($err);
    } else {
        // if (array_key_exists('marker', $ret)) {
        //     echo "Marker:" . $ret["marker"] . "\n";
        // }
        // echo "\nList Iterms====>\n";
        // var_dump($ret['items']);
        return $ret['items'];
        // $json = json_encode($ret['items']);
        // return $json;
    }
  }

  /**
   * delFile
   * @param  key string
   * @return boolean
  **/
  public static function delFile($key){
    $auth = new \Qiniu\Auth(AK, SK);
    $config = new \Qiniu\Config();
    $bucketManager = new \Qiniu\Storage\BucketManager($auth, $config);
    $err = $bucketManager->delete(BUK, $key);
    if ($err === null) {
      return true;
    }else{
      return false;
    }
  }
}
?>
