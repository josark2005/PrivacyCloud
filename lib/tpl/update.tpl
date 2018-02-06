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
    <script type="text/javascript">
      var version = "__VERSION__";
      var lastest_version = "__VERSION__";
      var danger_code = "___DANGER__";
      var danger_msg = "___DANGER_MSG__";
      var danger_api = "?mode=api&a=___DANGER_API_FILE__&m=___DANGER_API_METHOD__";
      function getLastestVer(){
        var ajax = $.ajax({
          url: "?mode=api&a=main&m=getLastestVer",
          dataType: "json",
          timeout: 10000,
          complete: function(Http, status){
            if( status === "timeout" ){
              ajax.abort();
              alert("连接服务器超时");
              return ;
            }
          },
          success: function(data){
            lastest_version = data;
            $("#lastest_version").text(lastest_version);
            if( version !== lastest_version ){
              $("button#update").removeClass("d-none")
              $("button#glv").addClass("d-none");
            }
          }
        });
      }
      function update(){
        $("#update").addClass("d-none");
        $("#progress").removeClass("d-none");
        var progress = $("#prog");
        progress.text("备份当前文档与下载更新文件中，此过程耗时可能较长，请耐心等待！");
        var ajax = $.ajax({
          url: "?mode=api&a=main&m=update&version="+lastest_version,
          dataType: "json",
          timeout: 60000,
          complete: function(Http, status){
            if( status === "timeout" ){
              ajax.abort();
              alert("连接服务器超时");
              return ;
            }
          },
          success: function(data){
            if( data.code === "0" ){
              $("#complete").removeClass("d-none");
              progress.text("升级就绪，点击上方完成按钮以确认。");
            }else{
              $("#update").removeClass("d-none");
              $("#complete").addClass("d-none");
              $("#progress").addClass("d-none");
              progress.text("");
              alert(data.msg_zh+" ["+data.code+"]");
              return ;
            }
          }
        });
      }
      function complete(){
        location.href="?page=index";
      }
    </script>
  </head>
  <body>

    <div class="container mt-4" id="container">

      <div class="row">

        <div class="col-md-12 col-sm-12">
          <div class="card">
            <div class="card-header bg-dark text-white">
              <span class="font-weight-bold">Privacy Cloud 版本管理中心</span>
            </div>
            <div class="card-body table-responsive">
              <p>当前版本：__VERSION__<br />可更新版本：<span id="lastest_version">等待检查</spn></p>
              <button type="button" class="btn btn-outline-danger" id="glv" onclick="getLastestVer();">检查新版本</button>
              <button type="button" class="btn btn-outline-success d-none" id="update" onclick="update();">立即更新</button>
              <button type="button" class="btn btn-outline-success d-none" id="complete" onclick="complete();">完成</button>
              <div id="progress" class="d-none">
                <hr />
                <strong>更新进度：</strong><span id="prog"></span>
              </div>
            </div>
          </div>
        </div>

      </div>

    </div>

  </body>
</html>
