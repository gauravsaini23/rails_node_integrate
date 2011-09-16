var CONFIG = { last_message_time: 1
             };

function longPoll (data) {
  //process any updates we may have
  //data will be null on the first call of longPoll
  if (data && data.messages) {
    for (var i = 0; i < data.messages.length; i++) {
      var message = data.messages[i];

      //track oldest message so we only request newer messages from server
      if (message.timestamp > CONFIG.last_message_time)
        CONFIG.last_message_time = message.timestamp;

      updateDiv(message.id, message.text);
    }
  }

  $.ajax({
    dataType: 'jsonp',
    data: 'since=' + CONFIG.last_message_time,
    jsonpCallback: 'longPoll',
    url: 'http://122.176.52.224:8001/recv',
    error: function() {
      setTimeout(longPoll, 10*2000);
    }
  });
}

function updateDiv(id, text){
  //update the div
  $("div#value_" + id).html(text);
  $("#value_textbox_" + id).attr('value', text);
}

$(document).ready(function() {
  longPoll();
});

