$(function(){
  // 获取支持信息
  $.getJSON( "?mode=api&a=zen&m=getZen", function(data){
    console.log(data);
    if( data.code === "0" ){
      $("a#zen").html(data.data.zen);
      $("a#zen").attr("href", data.data.url);
    }else{
	    $("a#zen").html("Zen");
      $("a#zen").attr("href", "http://jokin1999.github.io/PrivacyCloud/resources/zen/page/0.html");
      console.log("[Zen]"+data.code+":"+data.msg);
      console.log("[Zen]"+data.msg_zh);
    }
  });
});
