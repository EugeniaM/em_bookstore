$(function() {
  $("tr[data-link]").click(function() {
    console.log(this.dataset.link);
    window.location = this.dataset.link
  })
});