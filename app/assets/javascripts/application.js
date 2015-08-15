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

	/* Zoom in and out profile shortcut */

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

	/* Infinite scrolling */

	var loadNextPage = function(url) {
		$.get(url, function(data) {
			$('#paginator').html('<div class="spinner"><div class="dot1"></div><div class="dot2"></div></div>');
			$.getScript(url).done(function() {
				if ($('#mosaic-display').hasClass('disabled')) mosaicView();
			});
		});
	}

	$(window).scroll(function() {
		if ($('#paginator').length) {
			var url = $('#load_more').attr('href');
			if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50 && $.active == 0) {
				loadNextPage(url);
			}
		}
	});

	/* Mosaic view and list view */

	list = $('#list-display');
	mosaic = $('#mosaic-display');
	var posts_wrapper = $('.posts-wrapper');
	var posts = posts_wrapper.children('.post');

	list.on('click', function() {
		if (!list.hasClass('disabled')) {
			$.cookie('mosaic', true);
			mosaic.removeClass('disabled');
			list.addClass('disabled');
			listView();
		}
	});

	mosaic.on('click', function() {
		if (!mosaic.hasClass('disabled')) {
			$.cookie('mosaic', true);
			list.removeClass('disabled');
			mosaic.addClass('disabled');
			mosaicView();
		}
	});

	var listView = function() {
		posts_wrapper = $('.posts-wrapper');
		posts = posts_wrapper.children('.post');

		posts.children('.post-head').show();
		posts.children('.post-bottom').show();
		posts.children('.comment-like-form').show();
		$('#posts').removeClass('col-sm-10 col-sm-offset-1 text-center');
		posts_wrapper.removeClass('col-md-4 col-sm-6 col-xs-12');
		posts_wrapper.removeClass('mosaic');
	}

	var mosaicView = function() {
		posts_wrapper = $('.posts-wrapper');
		posts = posts_wrapper.children('.post');

		if (posts_wrapper.length < 6) {
			var url = $('#load_more').attr('href');
			if (url) {
				loadNextPage(url);
				posts_wrapper = $('.posts-wrapper');
				posts = posts_wrapper.children('.post');
			}
		}

		posts.children('.post-head').hide();
		posts.children('.post-bottom').hide();
		posts.children('.comment-like-form').hide();
		$('#posts').addClass('col-sm-10 col-sm-offset-1 text-center');
		posts_wrapper.addClass('col-md-4 col-sm-6 col-xs-12');
		posts_wrapper.addClass('mosaic');

		$('.profile-float-wrapper').hide();
		$('.profile-nav-li').show();
	}

	/* Explore.search input and custom placeholder */

	$('.placeholder').on('click', function() {
		$('.search-input').focus();
	});

	if ($('.search-input').val()) {
		$('.placeholder').hide();
	}

	$('.search-input').on('blur', function() {
		if (!$('.search-input').val()) {
			$('.placeholder').show();
		}
	});

	$('.search-input').on('focus', function() {
		if (!$('.search-input').val()) {
			$('.placeholder').hide();
		}
	});

	$('.search-input').on('input', function() {
		if ($('.search-input').val()) {
			$('.placeholder').hide();
		}
	});

	/* Show image preview in upload image view when attaching a file */

	$('#post_image').on('change', function(event) {
		var img = $('#image-preview');
		var file = URL.createObjectURL(event.target.files[0]);
		img.attr("src", file);
		img.removeClass('hidden');
	});
};

$(document).ready(ready);
$(document).on('page:load', ready);