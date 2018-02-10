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
    <script type="text/javascript">
      $(function(){
        // height fixer
        var _nav = $("nav#navbar");
        var _container = $("div#container");
        var _window = $(window);
        if( (_nav.outerHeight()+_container.outerHeight()) < (_window.height() - 50) ){
          _container.outerHeight( _window.height() - _nav.outerHeight() - 50 );
        }
        $(document).keypress(function(e) {
          if(e.which == 13) {
            $("#btn").click();
          }
        });
      });
      function login(){
        var pw = $("#pw").val();
        if(pw === ""){
          alert("请输入授权密码");
          return ;
        }
        $.ajax({
          url: "?mode=api&a=main&m=login",
          type: "post",
          data: {"pw":pw},
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
              location.href = "?page=index";
            }else{
              alert(data.msg_zh+" "+data.code);
            }
          }
        });
      }
    </script>
  </head>
  <body class="bg-dark">

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark" id="navbar">
      <div class="container">
        <a class="navbar-brand" href="javascript:;">
          <img src="./lib/tpl/img/logo_pc.png" width="30" height="30" alt="logo">
          Privacy Cloud
        </a>
        <span class="navbar-text">
          授权页
        </span>
      </div>
    </nav>

    <div class="container mt-4" id="container">
      <div class="row" style="position:relative;top:50%;transform:translateY(-70%);">

        <div class="col-md-6 col-sm-12 mx-auto">
          <div class="card">
            <div class="card-header bg-primary text-white">登录 / Login</div>
            <div class="card-body">

              <div class="alert alert-primary">欢迎使用Privacy Cloud！</div>

              <div class="input-group mb-3">
                <input type="password" id="pw" class="form-control" placeholder="授权密码 Authorization Password" autofocus="autofocus" />
                <div class="input-group-append">
                  <button class="btn btn-outline-secondary" id="btn" type="button" onclick="javascript:login();">登录</button>
                </div>
              </div>

            </div>
            <div class="card-footer text-muted">
              <small>当前版本：__VERSION__</small><br />
              <small>Powered by Jokin.</small><br />
              <hr />
              <small>
                <a class="text-muted" href="http://pc.twocola.com/" target="_blank">官方网站</a>
                |
                <a class="text-muted" href="http://github.com/Jokin1999/PrivacyCloud" target="_blank">项目源码</a>
              </small>
            </div>
          </div>
        </div>

      </div>
    </div>

  </body>
</html>
