# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#table_tasks').on 'click', '.task.btn', ->
    $('.task.btn').removeClass 'active'
    $(this).addClass 'active'
    return
  $('#table_type').on 'click', '.btn', ->
    $('.btn').removeClass 'active'
    $(this).addClass 'active'
    return
  $(document).on 'click', '.del', ->
    item_id = $(this).attr('el_id')
    del_url = '/used_times/' + item_id
    op = $('.opened').map(->
      $(this).attr('id').substr 5
    ).get().join()
    del = confirm('Действительно удалить?')
    if !del
      return
    $.ajax
      url: del_url
      data: '_method': 'delete'
      dataType: 'json'
      type: 'POST'
      complete: ->
        $('#table_seconds').load 'used_times?op=' + op + ' #table_seconds > *', toggle_details
        return
    return
  return	