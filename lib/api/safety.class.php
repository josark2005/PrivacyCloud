<?php
// +----------------------------------------------------------------------
// | Constructed by Jokin [ Think & Do & To Be Better ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 Jokin All rights reserved.
// +----------------------------------------------------------------------
// | Author: Jokin <Jokin@twocola.com>
// +----------------------------------------------------------------------
/**
 * Safety API
 * @version  1.1.0
 * @author Jokin
**/
class safety {
  public function delBak(){
    if( is_file("./_pcbkup.zip") ){
      if( !unlink("./_pcbkup.zip") ){
        $err['code'] = "JPCAD01";
        $err['msg'] = "failed to delete the backup";
        $err['msg_zh'] = "删除备份文件失败";
        echo json_encode($err);
      }else{
        $err['code'] = "0";
        $err['msg'] = "success";
        $err['msg_zh'] = "删除成功！";
        echo json_encode($err);
      }
    }else{
      $err['code'] = "JPCAD02";
      $err['msg'] = "could not find the backup";
      $err['msg_zh'] = "找不到备份文件";
      echo json_encode($err);
    }
  }

  public function delIndexBak(){
    if( is_file("./index.php.bak") ){
      if( !unlink("./index.php.bak") ){
        $err['code'] = "JPCAD01";
        $err['msg'] = "failed to delete the backup";
        $err['msg_zh'] = "删除备份文件失败";
        echo json_encode($err);
      }else{
        $err['code'] = "0";
        $err['msg'] = "success";
        $err['msg_zh'] = "删除成功！";
        echo json_encode($err);
      }
    }else{
      $err['code'] = "JPCAD02";
      $err['msg'] = "could not find the backup";
      $err['msg_zh'] = "找不到备份文件";
      echo json_encode($err);
    }
  }

  public function delUpd(){
    if( is_file("./_update.zip") ){
      if( !unlink("./_update.zip") ){
        $err['code'] = "JPCAD01";
        $err['msg'] = "failed to delete the backup";
        $err['msg_zh'] = "删除备份文件失败";
        echo json_encode($err);
      }else{
        $err['code'] = "0";
        $err['msg'] = "success";
        $err['msg_zh'] = "删除成功！";
        echo json_encode($err);
      }
    }else if( is_file("./_update.php") ){
      if( !unlink("./_update.php") ){
        $err['code'] = "JPCAD01";
        $err['msg'] = "failed to delete the backup";
        $err['msg_zh'] = "删除备份文件失败";
        echo json_encode($err);
      }else{
        $err['code'] = "0";
        $err['msg'] = "success";
        $err['msg_zh'] = "删除成功！";
        echo json_encode($err);
      }
    }else{
      $err['code'] = "JPCAD02";
      $err['msg'] = "could not find the backup";
      $err['msg_zh'] = "找不到备份文件";
      echo json_encode($err);
    }
  }

  public function chgUpd(){
    $domains = @file_get_contents("http://jokin1999.github.io/PrivacyCloud/release/update_verified.md");
    $domains = htmlspecialchars_decode($domains);
    $domains = json_decode($domains, true); // 解析为数组
    $domain = $domains[0];
    include "./config.inc.php";
    $config["UPDATE_BASIC_URL"] = $domain;
    $linefeed = PHP_EOL;
    $content = "<?php{$linefeed}\$config=".var_export($config,true).";";
    $res = file_put_contents("./config.inc.php", $content);
    if( $res ){
      $err['code'] = "0";
      $err['msg'] = "success";
      $err['msg_zh'] = "设置成功";
      exit(json_encode($err));
    }else{
      $err['code'] = "JPCAD04";
      $err['msg'] = "failed to write confinguration file";
      $err['msg_zh'] = "设置文件无法写入，请删除配置页->升级地址中的数据";
      exit(json_encode($err));
    }
  }

  public function toggleDebug(){
    include "./config.inc.php";
    if( isset($config["DEBUG"]) ){
      unset($config["DEBUG"]);
    }
    $linefeed = PHP_EOL;
    $content = "<?php{$linefeed}\$config=".var_export($config,true).";";
    $res = file_put_contents("./config.inc.php", $content);
    if( $res ){
      $err['code'] = "0";
      $err['msg'] = "success";
      $err['msg_zh'] = "设置成功";
      exit(json_encode($err));
    }else{
      $err['code'] = "JPCAD04";
      $err['msg'] = "failed to write confinguration file";
      $err['msg_zh'] = "设置文件无法写入";
      exit(json_encode($err));
    }
  }
}
?>
