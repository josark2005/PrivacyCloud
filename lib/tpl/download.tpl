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
      $(function(){
        var sp = "__SP__".toUpperCase();
        var flux = "__FLUX__" + "MB";
        document.getElementById("SP").innerHTML = sp;
        document.getElementById("flux").innerHTML = flux;
        var items = "__ITEMS__";
      });
      function del(key){
        $.ajax({
          url: "?page=del&key="+key,
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

        <div class="collapse navbar-collapse" id="nav"></div>
      </div>
    </nav>

    <div class="container">

      <div class="row mt-4">

        <div class="col-md-3 col-sm-12 mb-4">
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

        <div class="col-md-9 col-sm-12">
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
