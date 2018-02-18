<?php
// +----------------------------------------------------------------------
// | Constructed by Jokin [ Think & Do & To Be Better ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 Jokin All rights reserved.
// +----------------------------------------------------------------------
// | Author: Jokin <Jokin@twocola.com>
// +----------------------------------------------------------------------

/**
 * Tool-UpdateTester-Server for Privacy Cloud
 * @author Jokin
**/
// 环境版本判断
if( version_compare(PHP_VERSION ,"5.6.0" ,"<") ){
  die("您的环境不支持运行tool-updatetester-server，要求PHP版本大于等于5.6.0");
}
// 环境适配
if( !is_file("./.htaccess") ){
  $file = <<<EOF
<IfModule mod_rewrite.c>
RewriteEngine on
RewriteCond %{REQUEST_FILENAME} !-d
RewriteCond %{REQUEST_FILENAME} !-f
RewriteRule ^(.*)$ index.php/$1 [QSA,PT,L]
</IfModule>
EOF;
  $res = file_put_contents("./.htaccess", $file);
  if( !$res ){
    die("无法放置入口Rewrite适配文件！");
  }
}
// 初始化
$support_status = @file_get_contents('./support_status.md');
if( isset($_GET['page']) && $_GET['page'] === "in" ){
  $msg = "success";
  if( isset($_POST['support_status']) ){
    header('Content-Type:text/json;charset=utf-8');
    @file_put_contents("./support_status.md", $_POST['support_status']);
  }
  if( isset($_POST['update']) ){
    if( isset($_FILES['update']) && $_FILES['update']['error'] === 0 && $_FILES['update']['type'] === "application/zip" ){
      if( !copy($_FILES['update']['tmp_name'], "./{$_FILES['update']['name']}") ){
        $msg = "failed_1";
      }
    }else{
      $msg = "failed_2";
    }
  }
  header("Location: ?page=show&msg={$msg}");
  // 不退出显示配制页
}else if( isset($_SERVER['PATH_INFO']) ){
  $pathinfo = $_SERVER['PATH_INFO'];
  if( $pathinfo === "/release/support_status.md" ){
    // 显示版本信息
    echo $support_status;
  }
  // 文件下载
  $pf = explode("/", $pathinfo);
  $method = $pf[1];
  if( $method === "update" ){
    if( is_file("./".$pf[2]) ){
      $file = file_get_contents("./".$pf[2]);
      echo $file;
    }
  }
  exit();
}else if( isset($_GET['page']) && $_GET['page'] === "del" ){
  if( isset($_GET['file']) && !empty($_GET['file']) ){
    if( is_file($_GET['file']) ){
      unlink($_GET['file']);
    }
  }
  header("Location: ?page=show");
}
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Update Tester for Privacy Cloud</title>
    <script src="./assets/jquery-3.2.1.min.js" charset="utf-8"></script>
    <script type="text/javascript">
      function getOfficialData(put=false){
        $.get("http://pc.twocola.com/release/support_status.md", function(data){
          $("#support_status").val(data);
          if(put === true){
            $("#btn-support_status").click();
          }
        });
      }
    </script>
  </head>
  <body>
    <h1>Update Tester <small style="font-size:13px;background-color:rgb(82, 82, 82);color:#FFF;padding:0 5px 0;">For Privacy Cloud Only</small></h1>

    <h3>可访问模块</h3>
    <p>/release/support_status.md</p>

    <hr />

    <span style="background-color:rgb(82, 82, 82);color:#FFF;">信息：<?php echo isset($_GET['msg']) ? $_GET['msg'] : "暂无信息"; ?></span>

    <hr />

    <h3>#1 support_status.md</h3>
    <form method="post" action="?page=in">
      <textarea id="support_status" type="text" style="width:80%;" rows="10" name="support_status" onchange="javascript:support_status();"><?php echo $support_status; ?></textarea>
      <br />
      <button type="submit" id="btn-support_status">提交</button>
      <button type="button" onclick="getOfficialData();">获取官方数据</button>
      <button type="button" onclick="getOfficialData(true);">同步官方数据</button>
    </form>
    <hr />

    <h3>#2 升级包</h3>
    <form method="post" action="?page=in" enctype="multipart/form-data">
      <input type="file" name="update" />
      <br />
      <button type="submit" name="update" value="update">提交</button>
    </form>

    <hr />

    <h3>#3 管理升级包</h3>
    <?php
    $files = scandir("./");
    $zips = array();
    foreach ($files as $key => $file) {
      if( $file !== "." && $file !== ".."){
        $suffix = explode(".", $file);
        $suffix = end($suffix);
        if($suffix === "zip"){
          $zips[] = $file;
        }
      }
    }
    foreach ($zips as $key => $file) {
      echo $file." <a href=\"?page=del&file={$file}\">删除</a><br />";
    }
    ?>

    <hr />
    Privacy Cloud 维运团队
  </body>
</html>
