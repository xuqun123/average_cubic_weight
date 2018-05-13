App.api_request_notifications = App.cable.subscriptions.create "ApiRequestNotificationsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) -> 
    if data["category"] != undefined
      $('#average-cubic-weight').html '<div class="alert alert-success text-center"><h6>Average Cubic Weight:</h6><h4>' +  data["weight"] + '<h5>(' + data["category"] + ')</h5>' + '</h4></div>'
    else
      $('#average-cubic-weight').html '<div class="alert alert-success text-center"><h6>Average Cubic Weight:</h6><h4>' +  data["weight"] + '</h4></div>'

    $.getScript '/reload', () ->