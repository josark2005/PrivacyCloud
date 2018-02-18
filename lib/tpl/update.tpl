<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Privacy Cloud - 个人云存储</title>
    <link rel="shortcut icon" href="./lib/tpl/img/logo_pc.png">
    <link rel="stylesheet" href="./lib/tpl/css/bootstrap.min.css">
    <!-- Special Page -->
    <link rel="stylesheet" href="./lib/tpl/css/fontawesome-all.min.css">
    <script src="./lib/tpl/js/jquery-3.2.1.min.js" charset="utf-8"></script>
    <script src="./lib/tpl/js/bootstrap.bundle.min.js" charset="utf-8"></script>
    {_common_var_}
    <script type="text/javascript">
      $(function(){
        // 认证地址检测
        var status = 0;
        var finish = 0;
        $.getJSON("http://pc.twocola.com/release/update_verified.md", function(data){
          finish ++;
          $.each(data, function(key, value){
            if( value === $("#updUrl").text() ){
              $("#update_verified").removeClass("d-none");
              status ++;
              return false; // jump out
            }
          });
        });
        // 调试地址检测
        $.getJSON("http://pc.twocola.com/release/update_debug.md", function(data){
          finish ++
          $.each(data, function(key, value){
            if( value === $("#updUrl").text() ){
              $("#update_debug").removeClass("d-none");
              status ++;
              return false; // jump out
            }
          });
        });
        var t = setInterval(function(){
          if( finish === 2 ){
            clearInterval(t);
            if( status === 0 ){
              $("#update_unknown").removeClass("d-none");
              $("#urlSafer").removeClass("d-none");
            }
          }
        }, 1000);
      });
      function getLastestVer(){
        var btn_glv = $("#glv").text();
        $("#glv").attr("disabled", "disabled");
        $("#glv").text("请稍候。。。");
        var ajax = $.ajax({
          url: "?mode=api&a=main&m=getLastestVer",
          dataType: "json",
          timeout: 10000,
          complete: function(Http, status){
            $("#glv").text(btn_glv);
            $("#glv").removeAttr("disabled");
            if( status === "timeout" ){
              ajax.abort();
              alert("连接服务器超时");
              return ;
            }
          },
          success: function(data){
            $("#glv").text(btn_glv);
            $("#glv").removeAttr("disabled");
            lastest_version = data;
            $("#lastest_version").text(lastest_version);
            if( "__version__" !== lastest_version ){
              $("button#update").removeClass("d-none")
              $("button#glv").addClass("d-none");
            }
          }
        });
      }
      function update(version=null){
        if( version !== null ){
          lastest_version = version;
        }
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
      function urlSafer(){
        $.get("?mode=api&a=safety&m=chgUpd");
        location.href = "";
      }
    </script>
  </head>
  <body>

    {_nav_}

    <div class="container mt-4" id="container">

      <div class="row">

        <div class="col-md-12 col-sm-12">
          <div class="card">
            <div class="card-header bg-dark text-white">
              <span class="font-weight-bold">Privacy Cloud 版本管理中心</span>
            </div>
            <div class="card-body table-responsive">
              <div class="alert alert-info"><strong>提醒！</strong>推荐使用带有<strong>认证地址</strong>绿色标识的更新地址！（调试地址与非认证地址同样存在安全风险，请获悉！）</div>
              <p>
                升级服务提供：<span id="update_verified" class="d-none badge badge-success">认证地址</span><span id="update_debug" class="d-none badge badge-warning">调试地址</span><span id="update_unknown" class="d-none badge badge-danger">[R-4]未知地址</span><span id="updUrl">__UPDATE_BASIC_URL__</span> <a id="urlSafer" class="d-none text-sm text-danger" href="javascript:;" onclick="javascript:urlSafer();">修改为官方地址</a><br />
                当前版本：__VERSION__<br />
                可更新版本：<span id="lastest_version">等待检查</span>
              </p>
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
