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
    <script src="./lib/tpl/js/main.js" charset="utf-8"></script>
    <script type="text/javascript">
      $(function(){
        var sp = "__SP__".toUpperCase();
        var flux = "__FLUX__" + "MB";
        document.getElementById("SP").innerHTML = sp;
        document.getElementById("flux").innerHTML = flux;
        var items = "__ITEMS__";
      });
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

    <div class="jumbotron pb-2">
      <div class="container">
        <h1 class="display-4">Privacy Cloud</h1>
        <p class="lead">针对个人设计的私有云对象存储服务管理一站式解决方案。</p>
        <hr class="my-4">
        <p>如果有问题请先阅读<a href="//github.com/jokin1999/PrivacyCloud/blob/master/README.md" target="_blank">Readme</a>文档。</p>
        <p class="lead">
          <a class="btn btn-primary btn-md" href="//pc.twocola.com" target="_blank" role="button">官方网站</a>
          <a class="btn btn-success btn-md" href="//github.com/jokin1999/PrivacyCloud" target="_blank" role="button">项目源码</a>
        </p>
        <div class="alert alert-danger" role="alert">
          此版本仅供测试，请保护好个人私密信息！
        </div>
      </div>
    </div>

    <div class="container mt-4">
      <div class="row">
        <div class="col-md-6 col-sm-12">
          <div class="card">
            <div class="card-header bg-dark text-white">简略教程</div>
            <div class="card-body">
              <ol class="pl-4">
                <li>服务注册 | <small class="text-muted">请参考页脚Service Provider下方链接</small></li>
                <li>完善设置 | <a href="http://pc.twocola.com/manual/start.html" target="_blank">教程</a></li>
                <li>上传页面 | <a href="?page=upload" target="_blank">打开</a></li>
                <li>下载页面 | <a href="?page=download" target="_blank">打开</a></li>
              </ol>
            </div>
            <div class="card-footer text-muted">
              <small>当前版本：__VERSION__</small>
            </div>
          </div>
        </div>
      </div>
    </div>

    <hr class="mb-0 mt-4">

    <footer class="bg-dark pb-2 pt-4 text-white">
      <div class="container">
        <div class="row text-muted">
          <div class="col-md col-sm-12">
            <h3 class="text-white">Join Us</h3>
            <p>
              <span>后端研发-php</span><br />
              <span>美术设计</span><br />
              <span>前端设计-html/css</span><br />
              <span>前端工程-js</span><br />
            </p>
          </div>
          <div class="col-md col-sm-12">
            <h3 class="text-white">Relevant Files</h3>
            <p>
              <a href="//pc.twocola.com" target="_blank" class="text-muted">官方网站</a><br />
              <a href="//github.com/jokin1999/PrivacyCloud" target="_blank" class="text-muted">Github仓库</a><br />
            </p>
          </div>
          <div class="col-md col-sm-12">
            <h3 class="text-white">Staff</h3>
            <p>
              <a href="//weibo.com/jkweiyi" target="_blank" class="text-muted">@Jokin</a>
            </p>
          </div>
          <div class="col-md col-sm-12">
            <h3 class="text-white">Service Provider</h3>
            <p>
              <span>七牛云：</span><a href="//portal.qiniu.com/signup?code=3lgquci2quafm" target="_blank" class="text-muted">注册</a> <a href="//www.qiniu.com" target="_blank" class="text-muted">官网</a><br />
            </p>
            <small class="text-muted">*仅显示支持的sp</small>
          </div>
        </div>
        <hr class="my-1" />
        <span class="text-muted">如果您对以上内容有兴趣，您可以发送邮箱到Jokin@twocola.com联系我们。</span><br />
        <small class="text-muted">当前版本：
          <span id="current_version">__VERSION__</span>
        </small>
        <small class="text-muted">最新版本：
          <span id="lastest_version">获取失败</span>
          <span id="lastest_version_tip"></span>
        </small>
      </div>
    </footer>

  </body>
</html>
