jQuery(document).ready(function($){
	//open popup
	$('.cd-popup-trigger').on('click', function(event){
		event.preventDefault();
		$('.cd-popup').addClass('is-visible');
	});
	
	//close popup
	$('.cd-popup').on('click', function(event){
		if( $(event.target).is('.cd-popup-close') || $(event.target).is('.cd-popup') ) {
			event.preventDefault();
			$(this).removeClass('is-visible');
		}
	});
	//close popup when clicking the esc keyboard button
	$(document).keyup(function(event){
    	if(event.which=='27'){
    		$('.cd-popup').removeClass('is-visible');
	    }
    });

	$('.two-popup-trigger').on('click', function(event){
		event.preventDefault();
		$('.two-popup').addClass('is-visible');
	});
	
	//close popup
	$('.two-popup').on('click', function(event){
		if( $(event.target).is('.two-popup-close') || $(event.target).is('.two-popup') ) {
			event.preventDefault();
			$(this).removeClass('is-visible');
		}
	});
	//close popup when clicking the esc keyboard button
	$(document).keyup(function(event){
    	if(event.which=='27'){
    		$('.two-popup').removeClass('is-visible');
	    }
    });

	$('.three-popup-trigger').on('click', function(event){
		event.preventDefault();
		$('.three-popup').addClass('is-visible');
	});
	
	//close popup
	$('.three-popup').on('click', function(event){
		if( $(event.target).is('.three-popup-close') || $(event.target).is('.three-popup') ) {
			event.preventDefault();
			$(this).removeClass('is-visible');
		}
	});
	//close popup when clicking the esc keyboard button
	$(document).keyup(function(event){
    	if(event.which=='27'){
    		$('.three-popup').removeClass('is-visible');
	    }
    });


});