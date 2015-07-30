// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets
//= require jquery.cookie

ready = function() {
	var hide_float = $.cookie('profile-float-hidden');
	if (hide_float == 'true') {
		$('.profile-float-wrapper').hide();
		$('.profile-nav-li').show();
	} else if (hide_float == 'false') {
		$('.profile-float-wrapper').show();
		$('.profile-nav-li').hide();
	}

	$('.minimize').on('click', function() {
		$.cookie('profile-float-hidden', 'true');
		$('.profile-float-wrapper').fadeOut();
		$('.profile-nav-li').fadeIn();
	});

	$('.maximize').on('click', function() {
		$.cookie('profile-float-hidden', 'false');
		$('.profile-nav-li').fadeOut();
		$('.profile-float-wrapper').fadeIn();
	});
};

$(document).ready(ready);
$(document).on('page:load', ready);