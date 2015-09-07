# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  $('.btn-toolbar').toolbar( {content: '#toolbar-options',animation: 'grow', event: 'click', hideOnClick: 'false'} );
  $('.tool-items a').on 'click', (event) ->
      #alert(event)
      event.preventDefault()
      return
  $('.settings-button').toolbar    
    content: '#user-options'
    position: 'bottom'
  $('.btn-toolbar').on 'toolbarItemClick', (e, el) ->
    #alert(12333)
    alert(e.target.attributes.getNamedItem('item_id').nodeValue)
    if el.href
      window.location.href = el.href
    return

