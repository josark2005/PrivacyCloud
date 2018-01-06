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
    <script type="text/javascript">
      var uploader;
      $(function(){
        var sp = "__SP__".toUpperCase();
        var flux = "__FLUX__" + "MB";
        document.getElementById("SP").innerHTML = sp;
        document.getElementById("flux").innerHTML = flux;
        uploader = Qiniu.uploader({
            runtimes: 'html5,html4',      // 上传模式，依次退化
            browse_button: 'pickfiles',         // 上传选择的点选按钮，必需
            uptoken : '__UPTOKEN__', // uptoken是上传凭证，由其他程序生成
            get_new_uptoken: false,             // 设置上传文件的时候是否每次都重新获取新的uptoken
            domain: '__DM__',     // bucket域名，下载资源时用到，必需
            container: 'upload',             // 上传区域DOM ID，默认是browser_button的父元素
            max_file_size: '500mb',             // 最大文件体积限制
            max_retries: 3,                     // 上传失败最大重试次数
            dragdrop: true,                     // 开启可拖曳上传
            drop_element: 'upload',          // 拖曳上传区域元素的ID，拖曳文件或文件夹后可触发上传
            chunk_size: '4mb',                  // 分块上传时，每块的体积
            auto_start: true,                   // 选择文件后自动上传，若关闭需要自己绑定事件触发上传
            init: {
                'FilesAdded': function(up, files) {
                    plupload.each(files, function(file) {
                      var size = (file.size/1024/1024).toFixed(2);
                      // 文件添加进队列后，处理相关的事情
                      $("#upload_list").append("<li class=\"list-group-item float-none text-truncate bg-secondary text-white\" id=\"" + file.id + "\">" +
                      "</span><span>" +file.name +
                      "<button type=\"button\" id=\"tb_"+file.id+"\" class=\"close\" aria-label=\"Close\" onclick=\"rem('"+ file.id +"')\"><span aria-hidden=\"true\" id=\"ts_"+file.id+"\">&times;</span></button>" +
                      "<span id=\"p_"+file.id+"\" class=\"float-right\">0%</span>");
                    });
                },
                'BeforeUpload': function(up, file) {
                      // 每个文件上传前，处理相关的事情
                      $("#progress_info").text("正在上传 " + file.name);
                },
                'UploadProgress': function(up, file) {
                       // 每个文件上传时，处理相关的事情
                       $("li#" + file.id).removeClass("bg-secondary");
                       $("li#" + file.id).addClass("bg-primary");
                       $("span#p_"+file.id).text(file.percent+"%");
                },
                'FileUploaded': function(up, file, info) {
                      $("li#" + file.id).removeClass("bg-primary");
                      $("li#" + file.id).addClass("bg-success");
                      $("li#" + file.id).addClass("bg-success");
                      $("button#tb_" + file.id).remove();
                      $("span#ts_" + file.id).remove();
                      setTimeout(function(){
                         $("li#" + file.id).remove();
                       }, 3000);
                },
                'Error': function(up, file, errTip) {
                      //上传出错时，处理相关的事情
                      alert(errTip);
                      $("li#" + file.id).removeClass("bg-primary");
                      $("li#" + file.id).addClass("bg-danger");
                },
                'UploadComplete': function() {
                      $("#progress_info").text("暂无上传任务");
                },
            }
        });
      });
      function rem(id){
        uploader.stop();
        for(var i in uploader.files){
          if(uploader.files[i].id === id){
            var toremove = i;
          }
        }
        var file = uploader.files.splice(toremove, 1);
        $("li#" + file[0].id).remove();
        uploader.start();
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

        <div class="collapse navbar-collapse" id="nav"></div>
      </div>
    </nav>

    <div class="jumbotron pb-2">
      <div class="container">
        <h1 class="display-4">欢迎使用Privacy Cloud！</h1>
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

    <div class="container">
      <div class="row">

        <div class="col-md-6 col-sm-12 mb-2">
          <div class="card">
            <div class="card-header bg-dark text-white">
              <span class="font-weight-bold">当前SP信息</span>
            </div>
            <div class="card-body">
              <span>服务提供商：</span><span id="SP">null</span><br />
              <span>本月已使用流量：</span><span id="flux">null</span><br />
              <hr />
              <a class="btn btn-primary btn-md" href="?page=index" target="_self" role="button">首页</a>
              <a class="btn btn-success btn-md" href="?page=download" target="_self" role="button">下载页</a>
            </div>
            <div class="card-footer text-muted">
              <small>*数据仅供参考</small>
            </div>
          </div>
        </div>

        <div class="col-md-6 col-sm-12 mb-2">
          <div class="card">
            <div class="card-header bg-dark text-white">
              <span class="font-weight-bold">数据上传</span>
            </div>
            <div class="card-body" id="upload">
              <button class="btn btn-primary btn-block mb-2" id="pickfiles">选择文件或拖动到这里上传</button>
              <ul class="list-group" id="upload_list"></ul>
            </div>
            <div class="card-footer text-muted">
              <small id="progress_info" class="text-truncate">暂无上传任务</small>
            </div>
          </div>
        </div>

      </div>

      <div class="row">
        <div class="col-sm-12">
          <div class="card">
            <div class="card-header bg-dark text-white">
              <span class="font-weight-bold">离线下载(未开通)</span>
            </div>
            <div class="card-body">
              <form>
                <div class="input-group mb-3">
                  <input type="url" class="form-control" placeholder="请输入源文件地址" aria-label="请输入源文件地址" aria-describedby="basic-addon2">
                  <div class="input-group-append">
                    <button class="btn btn-outline-secondary" type="submit">离线下载</button>
                  </div>
                </div>
              </form>
            </div>
            <div class="card-footer text-muted">
              <small>*每次只能同时下载一个文件，获取大型文件可能会出现失败/超时。</small>
            </div>
          </div>
        </div>
      </div>

    </div>

    <hr class="mb-0 mt-4">

    <footer class="bg-dark pb-2 pt-4 text-white">
      <div class="container">
        <div class="row">
          <div class="col-md col-sm-12">
            <h3>Join Us</h3>
            <p>
              <span>研发</span><br />
              <span>美术设计</span><br />
              <span>前端设计</span><br />
            </p>
          </div>
          <div class="col-md col-sm-12">
            <h3>Relevant Files</h3>
            <p>
              <a href="//pc.twocola.com" target="_blank" class="text-white">官方网站</a><br />
              <a href="//github.com/jokin1999/PrivacyCloud" target="_blank" class="text-white">Github仓库</a><br />
            </p>
          </div>
          <div class="col-md col-sm-12">
            <h3>Staff</h3>
            <p>
              <a href="//weibo.com/jkweiyi" target="_blank" class="text-white">@Jokin</a>
            </p>
          </div>
          <div class="col-md col-sm-12">
            <h3>Service Provider</h3>
            <p>
              <span>七牛云：</span><a href="//portal.qiniu.com/signup?code=3lgquci2quafm" target="_blank" class="text-white">注册</a> <a href="//www.qiniu.com" target="_blank" class="text-white">官网</a><br />
            </p>
            <small class="text-muted">*仅显示支持的sp</small>
          </div>
        </div>
        <hr class="my-1" />
        <span>如果您对以上内容有兴趣，您可以发送邮箱到Jokin@twocola.com联系我们。</span><br />
        <small class="text-muted">当前版本：__VERSION__</small>
      </div>
    </footer>

  </body>
</html>
