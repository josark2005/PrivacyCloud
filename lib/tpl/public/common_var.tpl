<link rel="stylesheet" href="./lib/tpl/css/fontawesome-all.min.css">
<script type="text/javascript">
  var sp = "__SP__".toUpperCase();
  var flux = "__FLUX__" + "MB";
  var update_basic_url = "__update_basic_url__";
  var danger_code = "___DANGER__";
  var danger_msg = "___DANGER_MSG__";
  var danger_api = "?mode=api&a=___DANGER_API_FILE__&m=___DANGER_API_METHOD__";
  $(function(){
    document.getElementById("SP").innerHTML = (sp === "") ? "缺失" : sp;
    document.getElementById("flux").innerHTML = flux;
    // get lastest version
    $.ajax({
      url: "?mode=api&a=main&m=getLastestVer",
      dataType: "json",
      timeout: 10000,
      complete: function(xml, status){
        console.log(status);
      },
      success: function(data){
        // current version
        var current_version = $("#current_version").text();
        console.log(current_version);
        var lastest_version = data;
        $("#auto_lastest_version").text(lastest_version);
        // version compare
        if( current_version != lastest_version){
          $("#auto_lastest_version_tip").html("有新版本@<a class=\"text-muted\" href=\"?page=update\">[更新]</a>");
        }
      },
    });
    // 危险提示
    if( danger_code !== "" ){
      var danger_alert = "<div class=\"alert alert-danger text-center\" role=\"alert\">" + "["+danger_code+"]" + danger_msg + " <a class=\"text-danger\" href=\"javascript:;\" onclick=\"safetyAssistant();\">修复</a></div>";
      $("div#container").html(danger_alert + $("div#container").html());
    }
  });
  function safetyAssistant(){
    $.ajax({
      url: danger_api,
      dataType: "json",
      timeout: 10000,
      complete: function(XMLHttpRequest, status){
        console.log(XMLHttpRequest);
        if( status === "timeout" ){
          alert("连接服务器超时，请稍候再试");
        }
      },
      success: function(data){
        console.log(data);
        if( data.code === "0"){
          location.href = "";
        }else{
          alert(data.msg_zh+" "+data.code);
        }
      }
    });
  }
</script>
