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
    <script src="./lib/tpl/js/main.js?ver=__VERSION__" charset="utf-8"></script>
    <script type="text/javascript">
      var update_basic_url = "__update_basic_url__";
      var danger_code = "___DANGER__";
      var danger_msg = "___DANGER_MSG__";
      var danger_api = "?mode=api&a=___DANGER_API_FILE__&m=___DANGER_API_METHOD__";
      $(function(){
        var sp = "__SP__".toUpperCase();
        var flux = "__FLUX__" + "MB";
        document.getElementById("SP").innerHTML = (sp === "") ? "缺失" : sp;
        document.getElementById("flux").innerHTML = flux;
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
            console.log(data);
            if( data.code === "0"){
              window.open(data.data);
            }else{
              alert(data.msg_zh+" "+data.code);
            }
          }
        });
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

    {_footer_}

  </body>
</html>
