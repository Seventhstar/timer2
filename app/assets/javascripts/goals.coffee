# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@toolbar_pressed = (e,el) ->
    item_id = e.target.attributes.getNamedItem('item_id').nodeValue
    url = '/'+$('form').attr('action').split('/')[1]      
    if el.firstChild.className=='icon toolbar-delete'
      del_url = url + '/' + item_id
      del = confirm('Действительно удалить?')
      if !del
        return
      $.ajax
        url: del_url
        data: '_method': 'delete'
        dataType: 'json'
        type: 'POST'
        complete: ->
          $.get url, null, null, 'script'
          return
      $('.animate-grow').hide()
      return
    else if el.firstChild.className=='icon toolbar-edit'
      location = url+'/'+item_id+'/edit'
      $('.animate-grow').hide()
      $('#modal-holder').spin("modal")
      $.get location, (data)->
        $('#modal-holder').html(data).
        find('.modal').modal()
        return
      return

    #if el.href
    #  window.location.href = el.href
    #return


$(document).ready ->
  $('.btn-toolbar').toolbar( {content: '#toolbar-options', animation: 'none', event: 'click', hideOnClick: 'true'} );
  $('.btn-toolbar').on 'toolbarItemClick', (e, el) ->
    toolbar_pressed(e,el)
    return
  
