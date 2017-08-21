$(function() {  
  $('.increment').on('click', function(e) {
    console.log("++++++++++++++++");
    var value = parseInt($('#quantity-input').val()) + 1;
    $('#quantity-input').val(value);
  })

  $('.decrement').on('click', function(e) {
    console.log("--------------------");
    if(parseInt($('#quantity-input').val()) === 1) return;
    var value = parseInt($('#quantity-input').val()) - 1;
    $('#quantity-input').val(value);
  })
});