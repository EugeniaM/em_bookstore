$(function() {
  var counter = 1;

  $('#view-more').on('click', function(e) {
    var path = window.location.pathname;
    var search = window.location.search ? window.location.search + '&' : '?';
    console.log(counter);
    var url = path + search + "page=" + (counter + 1);
    $.get(url);
    counter++;
  })
});