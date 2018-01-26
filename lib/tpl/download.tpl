<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Privacy Cloud - 个人云存储</title>
    <link rel="shortcut icon" href="./lib/tpl/img/logo_pc.png">
    <link rel="stylesheet" href="./lib/tpl/css/bootstrap.min.css">
    <script src="./lib/tpl/js/jquery-3.2.1.min.js" charset="utf-8"></script>
    <script src="./lib/tpl/js/bootstrap.bundle.min.js" charset="utf-8"></script>
    <script src="./lib/tpl/js/plupload.full.min.js" charset="utf-8"></script>
    <script src="./lib/tpl/js/qiniu.min.js" charset="utf-8"></script>
    <script src="./lib/tpl/js/main.js" charset="utf-8"></script>
    <script type="text/javascript">
      $(function(){
        var sp = "__SP__".toUpperCase();
        var flux = "__FLUX__" + "MB";
        document.getElementById("SP").innerHTML = sp;
        document.getElementById("flux").innerHTML = flux;
      });
      function del(key){
        $.ajax({
          url: "?page=_del&key="+key,
          dataType: "json",
          timeout: 10000,
          success: function(data){
            console.log(data);
            if( data.message == "success."){
              location.href = ""; // 刷新页面
            }else{
              alert("删除失败");
            }
          }
        });
      }
    </script>
  </head>
  <body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
      <div class="container">
        <a class="navbar-brand" href="javascript:;">
          <img src="./lib/tpl/img/logo_pc.png" width="30" height="30" alt="logo">
          Privacy Cloud
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#nav" aria-controls="nav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="nav">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item">
              <a class="nav-link" href="?page=upload">上传</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="?page=download">下载</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="?page=start">教程</a>
            </li>
          </ul>
          <span class="navbar-text text-white">
            服务：<span id="SP">null</span> | 流量：<span id="flux">null</span>
          </span>
        </div>
      </div>
    </nav>

    <div class="container mt-4">

      <div class="row">

        <div class="col-md-12 col-sm-12">
          <div class="card">
            <div class="card-header bg-dark text-white">
              <span class="font-weight-bold">资源管理</span>
            </div>
            <div class="card-body table-responsive">
              <table class="table table-striped table-hover">
                <thead>
                  <tr>
                    <th scope="col">文件</th>
                    <th scope="col" style="min-width:105px;">大小</th>
                    <th scope="col" style="min-width:105px;">操作</th>
                  </tr>
                </thead>
                <tbody>
                  ==list==
                </tbody>
              </table>
            </div>
          </div>
        </div>

      </div>

    </div>

  </body>
</html>
