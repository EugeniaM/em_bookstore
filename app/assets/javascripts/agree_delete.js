$(function() {
  $('#delete-checkbox').change(function() {
    var checked = this.checked;

    if(checked) {
      $('#delete-btn').prop("disabled", false);
    } else {
      $('#delete-btn').prop("disabled", true);
    }
  })
});