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

$(document).ready(function() {
    init_grid_tiles();
    $(window).trigger('resize');
    //imagesLoaded
    $('.grid-tiles').imagesLoaded(function() {
        $(window).trigger('resize');
    });
});

$(document).ready(function() {
    // apply dropdownHover to all elements with the data-hover="dropdown" attribute
    $('[data-hover="dropdown"]').dropdownHover();
});

$(document).ready(function() {
    var maxValue = 0;
    var total = 0;
    if ($('.tagscloud li').length > 0) {
        $('.tagscloud li').each(function(index, item) {
            if (parseInt($(item).attr('value')) > maxValue)
                maxValue = parseInt($(item).attr('value'));

            total = total + parseInt($(item).attr('value'));
        });
        if (maxValue > total * 0.25) {
            maxValue = Math.round(total * 0.25);
        }
        $('.tagscloud li').each(function(index, item) {
            var value = parseInt($(item).attr('value'))
            if (value >= maxValue)
                $(item).find('a').addClass('tagsize6');
            else if (value >= maxValue * 0.75 && value < maxValue)
                $(item).find('a').addClass('tagsize5');
            else if (value >= maxValue * 0.50 && value < maxValue * 0.75)
                $(item).find('a').addClass('tagsize4');
            else if (value >= maxValue * 0.25 && value < maxValue * 0.50)
                $(item).find('a').addClass('tagsize3');
            else if (value >= maxValue * 0.1 && value < maxValue * 0.25)
                $(item).find('a').addClass('tagsize2');
            else
                $(item).find('a').addClass('tagsize1');

        });
    }
});