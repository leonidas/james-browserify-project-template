$ = require 'jquery'

(->
  window.WebSocket = window.WebSocket || window.MozWebSocket
  connection = new WebSocket('ws://localhost:9002/')
  connection.onmessage = (msg) -> 
    refresh = () -> # Update stylesheets only
      $('link[rel="stylesheet"]').each () ->
        unless $(this).attr('data-href-origin')
          $(this).attr 'data-href-origin', $(this).attr 'href'
        $(this).attr 'href', $(this).attr('data-href-origin') + '?' + Date.now()

    refresh() if msg.data == 'refresh'
    location.reload() if msg.data == 'reload'
)()