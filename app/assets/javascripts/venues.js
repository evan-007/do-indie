$(document).ready(function(){
  init_grid_tiles();
  $(window).trigger('resize');
  //imagesLoaded
  $('.grid-tiles').imagesLoaded(function() {
    $(window).trigger('resize');
  });
});

$(document).ready(function() { $('#venue_city_id').chosen({width: "50%"}); });