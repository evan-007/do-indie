$(document).ready(function(){
	$('#change_image').click(function(){
		console.log('clicked)');
		$(this).closest('#image_area').append('<p>'+
			'<label for="post_slide_attributes_image">Image</label>'+
			'<input id="post_slide_attributes_image" type="file" name="post[slide_attributes][image]">'+
			'</p>');
	});
});