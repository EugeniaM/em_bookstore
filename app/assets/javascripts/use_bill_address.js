$(function() {
  $('#use-billing-address').change(function() {
    var checked = this.checked;

    if(checked) {
      $('.shipping-address-container-checkout .wrapper').css("display", "none");
    } else {
      $('.shipping-address-container-checkout .wrapper').css("display", "initial");
    }
  })
});