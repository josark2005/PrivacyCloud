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
 * @version  1.0.0
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
}
?>
