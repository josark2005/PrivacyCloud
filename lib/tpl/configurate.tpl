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
    <script type="text/javascript">
    var danger_code = "___DANGER__";
    var danger_msg = "___DANGER_MSG__";
    var danger_api = "?mode=api&a=___DANGER_API_FILE__&m=___DANGER_API_METHOD__";
    $(function(){
      var sp = "__SP__".toUpperCase();
      var flux = "__FLUX__" + "MB";
      document.getElementById("SP").innerHTML = (sp === "") ? "缺失" : sp;
      document.getElementById("flux").innerHTML = flux;
    });
    function accept_a(){
      $("div#s0").addClass("d-none");
      $("div#s1").addClass("d-none");
      $("div#s2").removeClass("d-none");
    }
    function back2a(){
      $("div#s0").removeClass("d-none");
      $("div#s1").removeClass("d-none");
      $("div#s2").addClass("d-none");
    }
    function accept_b(){
      var sp = $("#sp").val();
      var ak = $("#ak").val();
      var sk = $("#sk").val();
      var bkt = $("#bkt").val();
      if( sp === "null" || ak === "" || sk === "" || bkt === "" ){
        alert("请完整填写相关信息");
        return ;
      }
      $("div#s2").addClass("d-none");
      $("div#s3").removeClass("d-none");
      $("#domain_p").removeClass("d-none");
      var ajax = $.ajax({
        url: "?mode=api&install=true&a=install&m=getDomain",
        data: {"sp":sp, "ak":ak, "sk":sk, "bkt":bkt},
        type: "post",
        dataType: "json",
        timeout: 10000,
        complete: function(Http, status){
          if( status === "timeout" ){
            ajax.abort();
            alert("连接服务器超时");
            back2b();
            return ;
          }
        },
        success: function(data){
          console.log(data);
          if( data.code === "0" ){
            $("#domain_p").addClass("d-none");
            $("#dm").val(data.data[0]);
            var qd = data.data.join(",");
            $("#qd").val(qd);
            return ;
          }else{
            $("#domain_p").addClass("d-none");
            alert("获取域名失败：" + data.msg + " [" + data.code +"]");
            return ;
          }
        }
      });
    }
    function back2b(){
      $("div#s2").removeClass("d-none");
      $("div#s3").addClass("d-none");
    }
    function accept_c(){
      $("div#s3").addClass("d-none");
      $("div#s4").removeClass("d-none");
    }
    function back2c(){
      $("div#s3").removeClass("d-none");
      $("div#s4").addClass("d-none");
    }
    function accept(){
      var sp = $("#sp").val();
      var ak = $("#ak").val();
      var sk = $("#sk").val();
      var bkt = $("#bkt").val();
      var dm = $("#dm").val();
      var qd = $("#qd").val();
      var upd = $("#upd").val();
      if( sp === "null" || ak === "" || sk === "" || bkt === "" || dm ==="" || qd === "" || upd === "" ){
        alert("信息不完整，请返回重新填写");
        return ;
      }
      var ajax = $.ajax({
        url: "?mode=api&install=true&a=install&m=setOptions",
        data: {"sp":sp, "ak":ak, "sk":sk, "bkt":bkt, "dm":dm, "qd":qd, "upd":upd},
        type: "post",
        dataType: "json",
        timeout: 10000,
        complete: function(Http, status){
          if( status === "timeout" ){
            ajax.abort();
            alert("连接服务器超时");
            back2b();
            return ;
          }
        },
        success: function(data){
          console.log(data);
          if( data.code === "0" ){
            location.href="?page=index";
            return ;
          }else{
            ajax.abort();
            alert("设置失败：" + data.msg + " [" + data.code +"]");
            back2b();
            return ;
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

        <div class="col-md-12 col-sm-12 mb-2" id="s0">
          <div class="card">
            <div class="card-header bg-dark text-white">
              <span class="font-weight-bold">欢迎使用 / Welcome</span>
            </div>
            <div class="card-body table-responsive">
              <p>欢迎使用Privacy Cloud私人云存储解决方案。<br />
                请仔细阅读下方引导文案，并在下方的卡片中完成基本信息的填写一边Privacy Cloud对接您的存储中心。
              </p>
              <hr />
              <h3># 非首次安装出现此页面</h3>
              <ol>
                <li>没有完善设置，或系统无法读取设置。</li>
                <li>请查看根目录是否存在"config.inc.php"文件。</li>
              </ol>
              <hr />
              <h3># 首次安装程序</h3>
              <ol>
                <li>请按<a href="http://pc.twocola.com/manual/start.html" target="_blank">教程（版本信息请参考下方）</a>仔细填写下方信息表。</li>
              </ol>
              <hr />
              <h3># 版本信息</h3>
              <ol>
                <li>主程序版本：__VERSION__</li>
                <li>内核版本：__CORE_VERSION__</li>
              </ol>
              <hr />
              <h3># 许可与声明</h3>
              <ol>
                <li>License：MIT</li>
                <li>官网：<a href="http://pc.twocola.com/" target="_blank">pc.twocola.com</a></li>
                <li><strong>一旦您完成设置并开始使用，即视为您已阅读并接受免责声明！</strong></li>
              </ol>
            </div>
          </div>
        </div>

        <div class="col-md-12 col-sm-12">
          <div class="card">
            <div class="card-header bg-dark text-white">
              <span class="font-weight-bold">全局设置</span>
            </div>
            <div class="card-body table-responsive">

              <div class="" id="s1">
                <h3 class="text-center">免责声明</h3>
                <ol>
                  <li>本程序基础功能免费开源不收取任何资费（请于官网免费下载），由于第三方存储产生的资费请自行负责，与本程序开发组无关;</li>
                  <li>本程序不会向开发者递交任何隐私信息，使用自动更新后应及时查看根目录下的备份文件是否需要，及时确认后删除（1.3.2版本），内核版本2.0.0-beta.2后不会再生成备份文件;</li>
                  <li>本程序仅为第三方对象存储的管理方案，请自行确保文件托管的安全性，丢失损坏本程序开发组无法负责;</li>
                  <li>本程序页面中提供的第三方信息如流量等仅供参考，具体使用情况以用户自行选择的服务提供商（SP）提供的数据为准。</li>
                </ol>
                <button type="button" class="btn btn-outline-danger btn-block" onclick="accept_a();">我已阅读上方免责声明并接受，继续设置</button>
              </div>

              <div class="d-none" id="s2" name="s2">
                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <label class="input-group-text" for="sp">服务提供商 SP</label>
                  </div>
                  <select class="custom-select" id="sp">
                    <option value="null" selected>请选择服务提供商</option>
                    <option value="QINIU">七牛云</option>
                    <option value="null" disabled>待开放</option>
                  </select>
                </div>

                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span class="input-group-text" id="_ak">Access Key</span>
                  </div>
                  <input type="text" class="form-control" id="ak" aria-describedby="_ak" placeholder="请输入Access Key">
                </div>

                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span class="input-group-text" id="_sk">Secret Key</span>
                  </div>
                  <input type="text" class="form-control" id="sk" aria-describedby="_sk" placeholder="请输入Secret Key">
                </div>

                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span class="input-group-text" id="_bkt">Bucket名称 BKT</span>
                  </div>
                  <input type="text" class="form-control" id="bkt" aria-describedby="_bkt" placeholder="请输入Bucket名称">
                </div>

                <hr />

                <div class="clearfix">
                  <button type="button" class="btn btn-outline-danger float-right" onclick="accept_b();">继续设置</button>
                  <button type="button" class="btn btn-outline-secondary float-right mr-2" onclick="back2a();">上一步</button>
                </div>
              </div>

              <div class="d-none" id="s3" name="s3">
                <p class="text-center" id="domain_p"><i class="fa-spin fab fa-cloudscale"></i> 获取BKT信息中，请稍候。。。</p>

                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span class="input-group-text" id="_dm">使用域名 DM</span>
                  </div>
                  <input type="text" class="form-control" id="dm" aria-describedby="_dm" placeholder="请输入域名">
                </div>

                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span class="input-group-text" id="_qd">流量查询域名 QD</span>
                  </div>
                  <input type="text" class="form-control" id="qd" aria-describedby="_qd" placeholder="请输入域名">
                </div>

                <hr />

                <div class="clearfix">
                  <button type="button" class="btn btn-outline-danger float-right" onclick="accept_c();">继续设置</button>
                  <button type="button" class="btn btn-outline-secondary float-right mr-2" onclick="back2b();">上一步</button>
                </div>
              </div>

              <div class="d-none" id="s4" name="s4">

                <div class="alert alert-danger" role="alert">
                  不知道如何设置此项？默认即可！
                </div>

                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span class="input-group-text" id="_upd">更新地址 UPD</span>
                  </div>
                  <input type="text" class="form-control" id="upd" aria-describedby="_upd" placeholder="http://pc.twocola.com/" value="__update_basic_url__">
                </div>

                <hr />

                <div class="clearfix">
                  <button type="button" class="btn btn-outline-danger float-right" onclick="accept();">保存设置</button>
                  <button type="button" class="btn btn-outline-secondary float-right mr-2" onclick="back2c();">上一步</button>
                </div>
              </div>

            </div>
          </div>
        </div>

      </div>

    </div>

  </body>
</html>
