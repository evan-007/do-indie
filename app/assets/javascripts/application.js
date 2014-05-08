// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery.tokeninput
//= require ckeditor/override
//= require ckeditor/init
//= require underscore
//= require gmaps/google
//= require turbolinks
//= require bootstrap
//= require bootstrap-datepicker
//= require chosen-jquery
//= require nprogress
//= require nprogress-turbolinks
//= require 'jquery.jplayer'
//= require cocoon
//= require_tree .

$(document).ready(function () {
  // apply dropdownHover to all elements with the data-hover="dropdown" attribute
  $('[data-hover="dropdown"]').dropdownHover();
});

// workaround of jQuery tokeninput for Korean characters
setTimeout(function() {
  $('input[id^="token-input"]').bind('input.autocomplete',function (){
    $(this).trigger('keydown');
  });
},500);