App.products = App.cable.subscriptions.create "ProductsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

    # This code looks for an HTML element with an id of main that's contained inside another element with class of store. If it's found, this function will replace the HTML contents of that element with the data received from the channel.
  received: (data) ->
    $(".store #main").html(data.html)
