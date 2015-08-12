ready = function() {

	/* Show image preview in upload image view when attaching a file */

	var loadFile = function(event) {
		var output = document.getElementById('image-preview');
		output.src = URL.createObjectURL(event.target.files[0]);
	};
}

$(document).ready(ready);
$(document).on('page:load', ready);