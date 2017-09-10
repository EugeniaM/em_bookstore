$(function() {

  $('#new-review-tab').on('click', function(e) {
    var url = window.location.pathname;
    $.get(url);
  });

  $('#reviews-list-tab').on('click', function(e) {
    var url = window.location.pathname + '?reviews=true';
    $.get(url);
  })
});