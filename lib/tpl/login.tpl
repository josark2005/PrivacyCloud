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
    <script src="./lib/tpl/js/zen.js" charset="utf-8"></script>
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
          $("#msg").text("请输入授权密码后再登录");
          $("#msg").addClass("alert-warning");
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
              $("#msg").text("连接服务器超时，请稍候再试");
              $("#msg").addClass("alert-warning");
            }
          },
          success: function(data){
            console.log(data);
            if( data.code === "0"){
              location.href = "?page=index";
            }else{
              $("#msg").text(data.msg_zh+" "+data.code);
              $("#msg").addClass("alert-danger");
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
        <a class="navbar-text text-white" id="zen" href="javascript:;" target="_blank"></a>
      </div>
    </nav>

    <div class="container mt-4" id="container">
      <div class="row">

        <div class="col-md-6 col-sm-12 mx-auto">
          <div class="card">
            <div class="card-header bg-dark text-white"><i class="fas fa-sign-in-alt"></i> 登录 / Login</div>
            <div class="card-body">
              <div class="alert alert-primary" id="msg">欢迎使用Privacy Cloud！</div>
              <div class="input-group mb-3">
                <input type="password" id="pw" tabindex="0" class="form-control" autofocus="autofocus" placeholder="授权密码 Authorization Password" />
                <div class="input-group-sappend">
                  <button class="btn btn-outline-secondary" id="btn" type="button" onclick="javascript:login();">登录</button>
                </div>
              </div>
              <a class="text-muted small float-right" href="http://jokin1999.github.io/PrivacyCloud/manual/forgetAuthPW.html" target="_blank">忘记密码？</a>
            </div>
            <div class="card-footer text-muted">
              <small>当前版本：__VERSION__</small><br />
              <small>Powered by Jokin.</small><br />
              <hr />
              <small>
                <a class="text-muted" href="http://jokin1999.github.io/PrivacyCloud/" target="_blank">官方网站</a>
                |
                <a class="text-muted fab fa-github" href="http://github.com/Jokin1999/PrivacyCloud" target="_blank"> GitHub</a>
                |
                <a class="text-muted" href="https://coding.net/u/Jokin/p/PrivacyCloud/git" target="_blank">Coding</a>
              </small>
            </div>
          </div>
        </div>

      </div>
    </div>

  </body>
</html>
