# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@addParam = (url, param, value) ->
  a = document.createElement('a')
  regex = /[?&]([^=]+)=([^&]*)/g
  match = undefined
  str = []
  a.href = url
  value = value or ''
  while match = regex.exec(a.search)
    if encodeURIComponent(param) != match[1]
      str.push match[1] + '=' + match[2]
  str.push encodeURIComponent(param) + '=' + encodeURIComponent(value)
  a.search = (if a.search.substring(0, 1) == '?' then '' else '?') + str.join('&')
  a.href
  return



@upd_param = (param)->
  $.ajax
      url: '/ajax/upd_param'
      data: param
      type: 'POST'
      beforeSend: (xhr) ->
        xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
        return
      success: ->
        disable_input(false)
        show_ajax_message('успешно','notice')
        return
     return


@disable_input = (cancel=true) -> 
  item_id = $('.icon_apply').attr('item_id')
  $cells = $('.editable')
  $cells.each ->
    _cell = $(this)
    _cell.removeClass('editable')
    if cancel
      _cell.html _cell.attr('last_val')
    else
      _cell.html _cell.find('input').val()    
    return
 
  $cell = $('td.app_cancel')  
  $cell.removeClass('app_cancel')
  $cell.html '<span class="icon edit" item_id="'+item_id+'"></span><span class="icon delete" item_id="'+item_id+'"></span>' 
  return

$(document).ready ->

# редактирование данных в таблице
  $('.container').on 'click', 'span.check_img', ->
    item_id = $(this).attr('item_id')
    chk = $(this).attr('chk')
    model = $(this).closest('table').attr('model')
    tr = $(this).parents('tr')
    if $(this).hasClass('checked')
      $(this).removeClass 'checked'
      tr.removeClass 'checked'
      checked = false
    else
      checked = true
      $(this).addClass 'checked'    
      tr.addClass 'checked'
    upd={}
    upd_p = {}
    upd_p[chk] = checked
    upd['upd'] = upd_p
    upd_param(decodeURIComponent($.param(upd))+'&model='+model+'&id='+item_id)

  $('.container').on 'click', 'span.edit', ->
    item_id = $(this).attr('item_id')
    $row = $(this).parents('')
    disable_input()
    $cells = $row.children('td').not('.edit_delete').not('.td_chk')
    table = $(this).closest('table')
    $cells.each ->
      _cell = $(this)
      _cell.addClass('editable')
      val = _cell.html()      
      _cell.data('text', val).html ''
      _cell.attr('last_val',val)
      _cell.attr('ind', table.find('th:eq('+_cell.index()+')').attr('fld'))
      type = _cell.attr('type')
      type = if type == undefined then 'text' else type      
      $input = $('<input type="'+type+'" name=upd['+table.find('th:eq('+_cell.index()+')').attr('fld')+'] />').val(_cell.data('text')).width(_cell.width() - 16)
      _cell.append $input
      return

    $cell = $row.children('td.edit_delete')  
    $cell.addClass('app_cancel')
    $cell.html '<span class="icon icon_apply" item_id="'+item_id+'"></span><span class="icon icon_cancel" item_id="'+item_id+'"></span>'
    return
    
  # отмена редактирования
  $('.container').on 'click', 'span.icon_cancel', ->   
     disable_input()
     return

  $('#goal_name').focus()

  # отправка новых данных
  $('.container').on 'click', 'span.icon_apply', ->  
    model = $(this).closest('table').attr('model')
    item_id = $(this).attr('item_id')
    inputs = $('input[name^=upd]')
    upd_param(inputs.serialize()+'&model='+model+'&id='+item_id)
    return

  $('body').on 'keyup keypress', '#goal_name',(e) ->
    code = e.keyCode or e.which
    if e.type == 'keyup'
      if code == 13
        e.preventDefault()
        $('#btn-send').trigger 'click'
      else if code == 32 && e.ctrlKey
        $('#goal_personal').trigger 'click'
      return
  return
     