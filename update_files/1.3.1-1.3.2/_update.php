<?php
/**
 * Privacy Cloud Updater
 * @version 1.3.2
**/
// @ 中文
// 此文件必须与lib文件夹压缩在一起！
// 除了适用版本外的所有版本不可运行此更新器。
// 此更新器将在Privacy Cloud 适用版本的核心驱动中自动运行。
// @ English
// This file must be composed with folder "lib"!
// Except appropriate version, ALL ELSE can not use this updater.
// This updater will be executed by the core of Privacy Cloud in appropriate version automatically.

if( !defined("VERSION") ){
  // restore();
  die("您的Privacy Cloud缺少版本定义信息，建议您手动安装最新版本。");
}

if( version_compare(VERSION ,"1.3.2") === -1 ){
  // restore();
  die("您的版本不支持此项升级，本次升级不可撤销，请手动重新安装。");
}

$verify_array = array("SP", "AK", "SK", "BUK", "DM", "AA", "QD");
foreach ($verify_array as $value) {
  if( !defined($value) ){
    switch ($value) {
      case 'VERSION':
        // restore();
        exit("您的Privacy Cloud版本信息无法正确读取，请手动重新安装！[Unknown VERSION - JPCUD01]");
        break;

      default:
        // restore();
        exit("缺少参数：".$value."！请手动重新安装！[Lost arguement - JPCUD02]");
        break;
    }
  }
}
// 获取设置信息
$opts = array(
  "SP"  => SP,
  "AK"  => AK,
  "SK"  => SK,
  "BKT" => BUK,
  "DM"  => DM,
  "AA"  => AA,
  "QD"  => QD,
  "update_basic_url"  => "http://pc.twocola.com/",
);
// 输出设置信息
$linefeed = PHP_EOL;
$content = "<?php{$linefeed}\$config=".var_export($opts,true).";";
file_put_contents("./config.inc.php", $content);
// 替换index
$file = file_get_contents("./index.tpl");
file_put_contents("./index.php", $file);
unlink("./index.tpl");

// 还原
function restore(){
  $zip = new \ZipArchive;
  if( $zip->open("./_pcbkup.zip") ){
    if( $zip->extractTo("./") ){
      unlink("./_pcbkup.zip");
      $zip->close();
    }else{
      exit("无法打开备份文件！[Bad authorization - JPCUD04]");
    }
  }else{
    exit("无法打开备份文件！[Bad authorization - JPCUD04]");
  }
}

?>
