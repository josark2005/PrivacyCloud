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
    {_common_var_}
    <script src="./lib/tpl/js/main.js?ver=__VERSION__" charset="utf-8"></script>
    <script type="text/javascript">
      var uploader;
      $(function(){
        uploader = Qiniu.uploader({
            runtimes: 'html5,html4',      // 上传模式，依次退化
            browse_button: 'pickfiles',         // 上传选择的点选按钮，必需
            uptoken : '__UPTOKEN__', // uptoken是上传凭证，由其他程序生成
            get_new_uptoken: false,             // 设置上传文件的时候是否每次都重新获取新的uptoken
            domain: '__DM__',     // bucket域名，下载资源时用到，必需
            container: 'upload',             // 上传区域DOM ID，默认是browser_button的父元素
            max_file_size: '1024mb',             // 最大文件体积限制
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

    {_nav_}

    <div class="container mt-4" id="container">
      <div class="row">

        <div class="col-md-6 col-sm-12 mb-2">
          <div class="card">
            <div class="card-header bg-dark text-white">
              <span class="font-weight-bold">数据上传</span>
            </div>
            <div class="card-body" id="upload">
              <button class="btn btn-primary btn-block my-4" id="pickfiles">选择文件或拖动到这里上传</button>
              <ul class="list-group" id="upload_list"></ul>
            </div>
            <div class="card-footer text-muted">
              <small id="progress_info" class="text-truncate">暂无上传任务</small>
            </div>
          </div>
        </div>

        <div class="col-md-6 col-sm-12 mb-2">
          <div class="card">
            <div class="card-header bg-dark text-white">
              <span class="font-weight-bold">友情提示</span>
            </div>
            <div class="card-body">
              <ul>
                <li>请勿滥用，所有对资源操作的行为都是计费的；（以下免费额度信息以七牛为例）</li>
                <li>未实名账户为10w次GET（可以理解为下载），1w次PUT（可以理解为对资源的操作）；</li>
                <li>已实名账户为100w次GET，10w次PUT;</li>
                <li>*即日起实测非实名用户不可创建Bucket。</li>
              </ul>
            </div>
            <div class="card-footer text-muted">
              <small>*一切数据以存储服务提供商提供的最终数据为准。</small>
            </div>
          </div>
        </div>

      </div>

    </div>

    {_footer_}

  </body>
</html>
