$(function(){
  // height fixer
  var _nav = $("nav#navbar");
  var _container = $("div#container");
  var _window = $(window);
  var _footer = $("footer#footer");
  if( (_nav.outerHeight()+_container.outerHeight()+_footer.outerHeight()) < (_window.height() - 50) ){
    _container.outerHeight( _window.height() - _nav.outerHeight() - _footer.outerHeight() - 50 );
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
