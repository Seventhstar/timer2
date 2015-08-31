# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  $(document).on 'click', '#btn-send', ->
    valuesToSubmit = $('form').serialize()
    values = $('form').serialize()
    url = $('form').attr('action')
    return empty_name = false
    each q2ajx(values), (i, a) ->
      if i.indexOf('[name]') > 0 and a == ''
        empty_name = true
        return false
      return
    if !empty_name
      $.ajax
        url: url
        data: valuesToSubmit
        dataType: 'json'
        type: 'POST'
        complete: ->
          $.get url, null, null, 'script'
          alert $('input[name^=name]')
          return
    return
  return
