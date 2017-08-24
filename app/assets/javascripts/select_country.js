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
});