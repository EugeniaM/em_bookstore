$(function() {

  var score;

  $('.star').on('click', function(e) {
    score = this.attributes.value.value;
    var bookId = this.attributes.book.value;
    // console.dir(this.attributes);
    $.ajax({
      url: '/reviews/rating/' + bookId,
      type: 'POST',
      data: { score: score }
    }).done(function (data){
      for(var i = 1; i <= +score; i ++) {
        $('.star[value=' + i + ']').addClass("selected-star");
      }
      for(var j = 5; j > +score; j--) {
        $('.star[value=' + j + ']').removeClass("selected-star");
      }
    });
  })
});