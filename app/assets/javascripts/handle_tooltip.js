$(function() {
  $('i.fa.fa-question-circle').hover(
    function() {
      $('.tooltip-card').css('display', 'initial')
    }, function() {
      $('.tooltip-card').css('display', 'none')
    }
  )
});