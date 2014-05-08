$(document).ready(function(){
  init_grid_tiles();
  $(window).trigger('resize');
  //imagesLoaded
  $('.grid-tiles').imagesLoaded(function() {
    $(window).trigger('resize');
  });
});

$(document).ready(function() { $('#band_genre_ids').chosen({width: "50%"}); });

$(document).ready(function() {
  $('#b_genres').find("#band_genre_tokens").tokenInput("/genres.json", { theme: "facebook",
    prePopulate: $('#band_genre_tokens').data('load')}
    );
});