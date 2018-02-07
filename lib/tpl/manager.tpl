<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Privacy Cloud - 个人云存储</title>
    <link rel="shortcut icon" href="./lib/tpl/img/logo_pc.png">
    <link rel="stylesheet" href="./lib/tpl/css/bootstrap.min.css">
    <link rel="stylesheet" href="./lib/tpl/css/fontawesome-all.min.css">
    <script src="./lib/tpl/js/jquery-3.2.1.min.js" charset="utf-8"></script>
    <script src="./lib/tpl/js/bootstrap.bundle.min.js" charset="utf-8"></script>
    <script src="./lib/tpl/js/plupload.full.min.js" charset="utf-8"></script>
    <script src="./lib/tpl/js/qiniu.min.js" charset="utf-8"></script>
    {_common_var_}
    <script src="./lib/tpl/js/main.js?ver=__VERSION__" charset="utf-8"></script>
    <script type="text/javascript">
      var prefix = __BKTRS_PREFIX__;
      $(function(){
        // 解析面包导航
        var t_pf = ""; // 前缀记忆
        $.each(prefix, function(key, value){
          t_pf += value+"/";
          console.log(value);
          console.log(t_pf);
          $("#prefix").append("/<a href=\"?page=manager&prefix="+t_pf+"\">"+value+"</a>");
        });
      });
      function del(key,hash){
        $.ajax({
          url: "?mode=api&m=del&key="+key,
          dataType: "json",
          timeout: 10000,
          success: function(data){
            console.log(data);
            if( data.code === "0"){
              $("tr#"+hash).remove();
              alert(data.msg_zh);
            }else{
              alert(data.msg_zh+" "+data.msg);
            }
          }
        });
      }
      function downloader(url){
        $.ajax({
          url: "?mode=api&m=download&url="+url,
          dataType: "json",
          timeout: 10000,
          complete: function(XMLHttpRequest, status){
            if( status === "timeout" ){
              alert("连接服务器超时，请稍候再试");
            }
          },
          success: function(data){
            if( data.code === "0"){
              console.log(data);
              $("a#downloader").attr("href", data.data);
              document.getElementById("downloader").click();
            }else{
              alert(data.msg_zh+" "+data.code);
            }
          }
        });
      }
      function enter(prefix){
        location.href="?page=manager&prefix="+prefix;
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
              <span class="font-weight-bold">资源管理</span> <small class="badge badge-light">位置：<span id="prefix"><a href="?page=manager">根目录</a></span></small>
            </div>
            <div class="card-body table-responsive">
              <a id="downloader" class="d-none" href="javascript:;" target="_blank"></a>
              <table class="table table-striped table-hover">
                <thead>
                  <tr>
                    <th scope="col">名称</th>
                    <th scope="col" style="min-width:105px;">大小</th>
                    <th scope="col" style="min-width:105px;">操作</th>
                  </tr>
                </thead>
                <tbody>
                  ==list==
                </tbody>
              </table>
            </div>
            <div class="card-footer">
              <small class="text-muted">*[删除文件夹]：删除文件夹中的所有内容文件夹会自动清除。</small>
            </div>
          </div>
        </div>

      </div>

    </div>

    {_footer_}

  </body>
</html>
