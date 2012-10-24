// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
// require jquery
// require jquery_ujs
//= require_tree .


// open a new window
function loadWindow(url) {
  popupWin = window.open(url, 'new_window', 'scrollbars=no,status=no,toolbar=no,location=no,directories=no,menubar=no,width=960, height=700, top=50, left=50, resizable=1, scrollbars=yes');
  popupWin.focus();
}

/* Create Menu Links */

function open_menu(dom_id){
  // arrow images
  $(dom_id + "_arrow_right").hide();
  $(dom_id + "_arrow_down").show();
  
  // stages 
  $(dom_id + "_stages").show();
}

function close_menu(dom_id){
  // arrow images
  $(dom_id + "_arrow_right").show();
  $(dom_id + "_arrow_down").hide();
  
  // stages 
  $(dom_id + "_stages").hide();
}

function open_menu_box(dom_id){
  // arrow images
  $(dom_id + "_arrow_right").hide();
  $(dom_id + "_arrow_down").show();
  
  // show box body 
  $(dom_id + "_open_content").show();
  
  // hide closed info
  $(dom_id + "_closed_content").hide();
}

function close_menu_box(dom_id){
  // arrow images
  $(dom_id + "_arrow_right").show();
  $(dom_id + "_arrow_down").hide();
  
  // show box body 
  $(dom_id + "_open_content").hide();
  
  // hide closed info
  $(dom_id + "_closed_content").show();
}