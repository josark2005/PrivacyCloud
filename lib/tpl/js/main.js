$(function(){
  // get lastest version
  $.ajax({
    url: "//raw.githubusercontent.com/jokin1999/PrivacyCloud/master/docs/release/support_status.md",
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
        $("#auto_lastest_version_tip").html("有新版本，请及时更新<a href=\"?page=_update&version="+lastest_version+"\" target=\"_blank\">[点击更新]</a>。");
      }
    },
  });
});
