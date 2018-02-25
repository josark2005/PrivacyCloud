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
    <script src="./lib/tpl/js/manager.js" charset="utf-8"></script>
    <script type="text/javascript">
      var prefix = __BKTRS_PREFIX__;
      var prefix_len = __PREFIX_LEN__;
      var dm = "__DM__";
      $(function(){
        // 解析面包导航
        $.each(prefix, function(key, value){
          t_pf += value+"/";
          $("#prefix").append("/<a href=\"?page=manager&prefix="+t_pf+"\">"+value+"</a>");
        });
        // 解析文件数据
        fdata = $.parseJSON("__PAGE_MANAGER_DATA_FILELIST__");
        console.log(fdata);
        if( fdata !== false && fdata !== null ){
          if( typeof(fdata.commonPrefixes) !== 'undefined' ){
            analyzeFolders(fdata.commonPrefixes);
          }
          if( typeof(fdata.items) !== 'undefined' ){
            analyzeFiles(fdata.items);
          }
        }else{
          $("#no-file").removeClass("d-none");
        }
      });
      var uploader;
      var t_pf = "";  // 解析
      var fdata;
      $(function(){
        uploader = Qiniu.uploader({
          runtimes: 'html5,html4',
          browse_button: 'pickfiles',
          uptoken : '__UPTOKEN__',
          get_new_uptoken: false,
          domain: '__DM__',
          container: 'upload',
          max_file_size: '1024mb',
          max_retries: 3,
          dragdrop: true,
          drop_element: 'upload',
          chunk_size: '4mb',
          auto_start: true,
          init: {
            'FilesAdded': function(up, files) {
                plupload.each(files, function(file) {
                  var size = (file.size/1024/1024).toFixed(2);
                  // 文件添加进队列后，处理相关的事情
                  $("#upload_list").append("<li class=\"list-group-item float-none text-truncate bg-secondary text-white\" id=\"" + file.id + "\">" +
                  "</span><span>" +file.name +
                  "<button type=\"button\" id=\"tb_"+file.id+"\" class=\"close\" aria-label=\"Close\" onclick=\"rem('"+ file.id +"');\"><span aria-hidden=\"true\" id=\"ts_"+file.id+"\">&times;</span></button>" +
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
              console.log(file);
                  var filename = file.name
                  // var size = file.size/1024/1024;
                  // size = Math.floor(size * 100) / 100;
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
                  var data = {
                    0: {
                      "key": file.name,
                      "hash": hash,
                      "fsize": file.size
                    }
                  }
                  analyzeFiles(data, false);
                  // 清除无文件提示
                  $("#no-file").addClass("d-none");
            },
            'Error': function(up, file, errTip) {
                  //上传出错时，处理相关的事情
                  console.log(file);
                  $("li#" + file.file.id).removeClass("bg-primary");
                  $("li#" + file.file.id).removeClass("bg-success");
                  $("li#" + file.file.id).removeClass("bg-secondary");
                  $("li#" + file.file.id).addClass("bg-danger");
                  // 文件已存在
                  var err;
                  switch (file.status) {
                    case 400:
                      err = "[空文件]";
                      break;
                    case 401:
                      err = "[认证失败]";
                      break;
                    case 403:
                      err = "[无操作权限]";
                      break;
                    case 405:
                      err = "[请求方式错误]";
                      break;
                    case 406:
                      err = "[校验错误]";
                      break;
                    case 413:
                      err = "[文件太大]";
                      break;
                    case 419:
                      err = "[账户被冻结]";
                      break;
                    case 478:
                      err = "[回源失败]";
                      break;
                    case 502:
                      err = "[错误网关]";
                      break;
                    case 503:
                      err = "[服务端不可用]";
                      break;
                    case 504:
                      err = "[服务端超时]";
                      break;
                    case 573:
                      err = "[访问过频]";
                      break;
                    case 579:
                      err = "[回调失败]";
                      break;
                    case 599:
                      err = "[服务端错误]";
                      break;
                    case 608:
                      err = "[内容被修改]";
                      break;
                    case 612:
                      err = "[资源不存在]";
                      break;
                    case 630:
                      err = "[空间数量上限]";
                      break;
                    case 631:
                      err = "[指定空间不存在]";
                      break;
                    case 640:
                      err = "[错误的marker]";
                      break;
                    case 614:
                      err = "[文件已存在]";
                      break;
                    default:
                      err = "[未知错误]";
                  }
                  $("li#"+file.file.id + ">span").html(err+$("li#" + file.file.id + ">span").html());
                  rem(file.file.id, false);
            },
            'UploadComplete': function() {
                  $("#progress_info").text("暂无上传任务");
            },
            'Key': function(up, file) {
                console.log(file);
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
              <table class="table table-striped table-hover" id="file-manager">
                <thead>
                  <tr>
                    <th scope="col">名称</th>
                    <th scope="col" style="min-width:105px;">大小</th>
                    <th scope="col" style="min-width:105px;">操作</th>
                  </tr>
                </thead>
                <tbody id="file-list">
                  <tr id='tpl_folders' class="d-none">
                    <td class="text-truncate text-danger"><i class="fas fa-folder"></i> ~~#1!</td>
                    <td></td>
                    <td><a class="btn btn-info btn-sm" href="?page=manager&prefix=~~#3!" target="_self"><i class="fa-fw fas fa-list"></i> 打开</a></td>
                  </tr>
                  <tr id='tpl_files' class="d-none">
                    <td class="text-truncate">~~#1!</td>
                    <td>~~#2!</td>
                    <td><a class="btn btn-primary btn-sm" href="javascript:;" onclick="manager('~~#1!', '~~#4!','~~#5!', '~~#3!');"><i class="fa-fw far fa-caret-square-down"></i> 操作</a></td>
                  </tr>
                </tbody>
              </table>
              <div id="no-file" class="alert alert-info d-none">还没有文件哟~赶快上传吧！</div>
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

    <div class="modal fade" tabindex="-1" role="dialog" id="manager">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title">管理页</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          </div>
          <div class="modal-body">
              <a id="download_href" href="javascript:;" target="_blank" class="btn btn-primary btn-block">下载</a>
              <hr />
              <a id="rename_href" href="javascript:;" onclick="$('#manager').modal('hide');$('#rename').modal('show');" class="btn btn-primary btn-block">重命名</a>
              <hr />
              <a id="del_href_enter" href="javascript:;" class="btn btn-danger btn-block">删除</a>
          </div>
          <div class="modal-footer" width='100%'>
              <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <div class="modal fade" tabindex="-1" role="dialog" id="confirmer">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title">确认删除</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          </div>
          <div class="modal-body">
            <div class="alert alert-danger">您确定要删除<strong id="filekey">null</strong>吗？</div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            <button type="button" class="btn btn-danger" id="del_href">删除</button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <div class="modal fade" tabindex="-1" role="dialog" id="rename">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title">重命名</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          </div>
          <div class="modal-body">
            <div class="input-group mb-3">
              <input type="text" id="name" tabindex="0" class="form-control" autofocus="autofocus" placeholder="重命名" />
              <div class="input-group-sappend">
                <button class="btn btn-outline-danger" id="btn-rename" type="button">修改</button>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

  </body>
</html>
