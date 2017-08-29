$(function() {
  $('#billing_address_country').change(function(e) {
    var url;
    if(this.value) {
      url = "billing_country_change?country=" + this.value;
      $.get(url);
    }
  })

  $('#shipping_address_country').change(function(e) {
    var url;
    if(this.value) {
      url = "shipping_country_change?country=" + this.value;
      $.get(url);
    }
  })

  $('#order_address_billing_country').change(function(e) {
    var url;
    var other_country = $('#order_address_shipping_country')[0].value;
    var other_phone = $('#order_address_shipping_phone')[0].value;
    if(this.value) {
      url = "checkout_addresses/order_billing_country_change?country=" + this.value + "&other_country=" + other_country + "&other_phone=" + other_phone;
      $.get(url);
    }
  })

  $('#order_address_shipping_country').change(function(e) {
    var url;
    var other_country = $('#order_address_billing_country')[0].value;
    var other_phone = $('#order_address_billing_phone')[0].value;
    if(this.value) {
      url = "checkout_addresses/order_shipping_country_change?country=" + this.value + "&other_country=" + other_country + "&other_phone=" + other_phone;
      $.get(url);
    }
  })
});
