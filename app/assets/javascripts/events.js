
$(document).ready(function() { $('#event_band_ids').chosen({width: "50%"}); });
$(document).ready(function() { $('#event_venue_id').chosen({width: "50%"}); });
$(document).ready(function() { $('#event_city_id').chosen({width: "50%"}); });


$(document).ready(function() {
	$('.date').datepicker({format: 'yyyy/mm/dd'});
});

$(document).ready(function() {
	$('#en_bands').find('#event_band_tokens').tokenInput("/bands.json", { theme: "facebook",
		resultsFormatter: function(item){ return '<li>' + item.name +' '+ item.korean_name+'</li>'},
		prePopulate: $('#event_band_tokens').data('load')}
		);
});

$(document).ready(function() {
	$('#en_venue').find('#event_venue_tokens').tokenInput("/venues.json", { theme: "facebook",
		resultsFormatter: function(item){ return '<li>' + item.name +' '+ item.korean_name+'</li>'},
		tokenLimit: 1, prePopulate: $('#event_venue_tokens').data('load')}
		);
});

$(document).ready(function() {
	$('#city').find('#event_city_tokens').tokenInput("/cities.json", { theme: "facebook",
		propertyToSearch: "en_name",
		resultsFormatter: function(item){ return '<li>' + item.en_name +' '+ item.ko_name+'</li>'},
		tokenLimit: 1, prePopulate: $('#event_city_tokens').data('load')}
		);
});


$(document).ready(function(){
  $('#raw_data').toggle();
  console.log('loaded');
  $('#showData').click(function(){
    $('#raw_data').toggle();
  });
});


$(document).ready(function(){
  init_grid_tiles();
  $(window).trigger('resize');
  //imagesLoaded
  $('.grid-tiles').imagesLoaded(function() {
    $(window).trigger('resize');
  });
});