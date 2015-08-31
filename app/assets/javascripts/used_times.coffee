# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
	$('#table_tasks').on 'click','.task.btn', ->
		$('.task.btn').removeClass('active')
		$(this).addClass('active')
	$('#table_type').on 'click','.btn', ->
		$('.btn').removeClass('active')
		$(this).addClass('active')