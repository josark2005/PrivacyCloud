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
        $("#auto_lastest_version_tip").html("有新版本，请及时更新<a href=\"?page=update\">[点击更新]</a>");
      }
    },
  });
});
