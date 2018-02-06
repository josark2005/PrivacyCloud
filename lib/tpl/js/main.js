$(function(){
  // height fixer
  var _nav = $("nav#navbar");
  var _container = $("div#container");
  var _window = $(window);
  var _footer = $("footer#footer");
  if( (_nav.outerHeight()+_container.outerHeight()+_footer.outerHeight()) < (_window.height() - 50) ){
    _container.outerHeight( _window.height() - _nav.outerHeight() - _footer.outerHeight() - 50 );
  }
  // get lastest version
  $.ajax({
    url: update_basic_url+"release/support_status.md",
    complete: function(xml, status){
      console.log(status);
    },
    success: function(data){
      // current version
      var current_version = $("#current_version").text();
      console.log(current_version);
      // lastest version
      data = jQuery.parseJSON(data);
      console.log(data);
      var lastest_version = data[current_version].version;
      console.log(lastest_version);
      $("#auto_lastest_version").text(lastest_version);
      // version compare
      if( current_version != lastest_version){
        $("#auto_lastest_version_tip").html("有新版本@<a class=\"text-muted\" href=\"?page=update\">[更新]</a>");
      }
    },
  });
  // 危险提示
  if( danger_code !== "" ){
    var danger_alert = "<div class=\"alert alert-danger text-center\" role=\"alert\">" + "["+danger_code+"]" + danger_msg + " <a class=\"text-danger\" href=\"javascript:;\" onclick=\"safetyAssistant();\">删除文件</a></div>";
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
        alert(data.msg_zh + "（刷新页面可清除警告）");
      }else{
        alert(data.msg_zh+" "+data.code);
      }
    }
  });
}
