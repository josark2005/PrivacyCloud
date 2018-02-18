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
