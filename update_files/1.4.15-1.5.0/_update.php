<?php
/**
 * Privacy Cloud Updater
 * @version 1.5.0
**/
// @ 中文
// 此文件必须与lib文件夹压缩在一起！
// 除了适用版本外的所有版本不可运行此更新器。
// 此更新器将在Privacy Cloud 适用版本的核心驱动中自动运行。
// @ English
// This file must be composed with folder "lib"!
// Except appropriate version, ALL ELSE can not use this updater.
// This updater will be executed by the core of Privacy Cloud in appropriate version automatically.
include "./config.inc.php";
if( !isset($config['SAFE_ENCRYPTION']) ){
  $config['SAFE_ENCRYPTION'] = false;
}
// 输出设置信息
$linefeed = PHP_EOL;
$content = "<?php{$linefeed}\$config=".var_export($config,true).";";
file_put_contents("./config.inc.php", $content);

?>
