$(function(){
  // get lastest version
  $.ajax({
    url: "//pc.twocola.com/release/lastest.json",
    complete: function(xml, status){
      console.log(status);
    },
    success: function(data){
      // current version
      var current_version = $("#current_version").text();
      console.log(current_version);
      // lastest version
      data = jQuery.parseJSON(data);
      var lastest_version = data.version;
      console.log(lastest_version);
      $("#lastest_version").text(lastest_version);
      // version compare
      if( current_version != lastest_version){
        $("#lastest_version_tip").text("有新版本，请及时更新。");
      }
    },
  });
});
