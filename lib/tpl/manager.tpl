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
                  var filename = file.name
                  var size = file.size/1024/1024;
                  size = Math.floor(size * 100) / 100;
                  var hash = $.parseJSON(info.response).hash;
                  var filekey = $.parseJSON(info.response).key;
                  $("li#" + file.id).removeClass("bg-primary");
                  $("li#" + file.id).addClass("bg-success");
                  $("li#" + file.id).addClass("bg-success");
                  $("button#tb_" + file.id).remove();
                  $("span#ts_" + file.id).remove();
                  setTimeout(function(){
                     $("li#" + file.id).remove();
                   }, 3000);
                  // 显示数据
                  var temp = "<tr id='"+ hash +"'><td class=\"text-truncate\">"+ filename +"</td><td>"+ size +" M</td><td>";
                  var temp2 = "<a class=\"text-primary\" href=\"javascript:;\" onclick=\"downloader('http://__DM__/"+filekey+"');\">下载</a> | <a class=\"text-danger\" href=\"javascript:;\" onclick=\"javascript:del('"+ filekey +"','"+hash+"');\">删除</a>";
                  $("#file-list").append(temp+temp2+"</td></tr>");
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
            'Key': function(up, file) {
                // 若想在前端对每个文件的key进行个性化处理，可以配置该函数
                // 该配置必须要在unique_names: false，save_key: false时才生效
                var t_pf = "";
                $.each(prefix, function(key, value){
                  t_pf += value+"/";
                });
                var key = t_pf + file.name;
                // do something with key here
                return key;
            }
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
      function newFloder(){
        // 创建并进入新文件夹
        var floderName = $("#newFloderName").val();
        if( floderName === "" ){
          alert("请输入完整的文件夹名称");
          return ;
        }
        var t_pf = "";
        $.each(prefix, function(key, value){
          t_pf += value+"/";
        });
        location.href="?page=manager&prefix="+t_pf+floderName+"/";
      }
    </script>
  </head>
  <body>

    {_nav_}

    <div class="container mt-4" id="container">

      <div class="row">

        <div class="col-md-4 col-sm-12">
          <div class="card">
            <div class="card-header bg-dark text-white">
              <span class="font-weight-bold">数据上传</span>
            </div>
            <div class="card-body" id="upload">
              <button class="btn btn-primary btn-block my-4" id="pickfiles">选择文件或拖动到这里上传</button>
              <button class="btn btn-success btn-block my-4" data-toggle="modal" data-target="#newFloder">新建文件夹</button>
              <ul class="list-group" id="upload_list"></ul>
            </div>
            <div class="card-footer text-muted">
              <small id="progress_info" class="text-truncate">上传至当前目录</small>
            </div>
          </div>
        </div>

        <div class="col-md-8 col-sm-12">
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
                <tbody id="file-list">
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

    <div class="modal fade" tabindex="-1" role="dialog" id="newFloder">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title">新建文件夹</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          </div>
          <div class="modal-body">
            <div class="alert alert-danger"><strong>警告！</strong>请勿使用斜杠"/"以避免创建其子文件夹。</div>
            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span class="input-group-text" id="inputGroup-sizing-default">新文件夹名称</span>
              </div>
              <input type="text" id="newFloderName" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default">
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            <button type="button" class="btn btn-primary" onclick="newFloder();">创建并进入</button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

  </body>
</html>
