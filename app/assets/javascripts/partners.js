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
//= require jquery/jquery.ui
//= require plugins/bootstrap
//= require_tree ./backend
//= require chosen/chosen.jquery.min
//= require wysihtml/dist/wysihtml5x-toolbar.min
//= require wysihtml/parser_rules/advanced_and_extended
//= require refile
//= require local_time
//= require turbolinks


/* # Endless_form*/
$(function()	{
	// Chosen 
	$(".chzn-select").chosen();
	
	// Datepicker
	$('.datepicker').datepicker();

	// Timepicker
	$('.timepicker').timepicker();
			
	// Slider		
	$('#sl1').slider();
	$('#sl2').slider();
	$('#sl3').slider();
	$('#sl4').slider();
	$('#sl5').slider();
			
	// Tags input
	$('.tag-demo1').tagsInput({
		'height':'auto',
		'width':'90%'
	});

	// Masked input
	$(".date").mask("99/99/9999");		
	$(".phone").mask("(999) 999-9999");
	$(".ssn").mask("999-99-9999");
	$(".eyescript").mask("~9.99 ~9.99 999");
	$(".product-key").mask("a*-999-a999");

	// Wysihtml5
	 var editor = new wysihtml5.Editor('editor', {
	     toolbar: 'toolbar',
	     parserRules:  wysihtml5ParserRules
	   });

	// Toggle border of control group
	$('#toggleLine').click(function()	{			
		if($(this).is(':checked'))	{
			$('#formToggleLine').addClass('form-border');
		}
		else	{
			$('#formToggleLine').removeClass('form-border');
		}
	});

	// Draggable Multiselect
	$('#btnSelect').click(function()	{
				
		$('#selectedBox1 option:selected').appendTo('#selectedBox2');  
		return false;
	});

	$('#btnRemove').click(function()	{
		$('#selectedBox2 option:selected').appendTo('#selectedBox1'); 
		return false;
	});

	$('#btnSelectAll').click(function()	{
			
		$('#selectedBox1 option').each(function() {               
           $(this).appendTo('#selectedBox2');                   
        });

		return false;
	});

	$('#btnRemoveAll').click(function()	{
			
		$('#selectedBox2 option').each(function() {                  
			$(this).appendTo('#selectedBox1');            
        });

		return false;
	});
});