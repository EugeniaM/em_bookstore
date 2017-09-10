$(function() {
  $('#order_delivery_5').change(function() {
    sendRequest(this.value);
  });
  $('#order_delivery_10').change(function() {
    sendRequest(this.value);
  });
  $('#order_delivery_15').change(function() {
    sendRequest(this.value);
  });

  function sendRequest(value) {
    $.ajax({
      url: $('.delivery-form-container form')[0].action,
      headers: {
        Accept : "text/javascript; charset=utf-8",
        "Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
      },
      type: 'POST',
      data: {
        'delivery': value,
      }
    });
  }
});