// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
  $('.c_standard_changes tr').hide()
  klass = $('select').val()
  $('.c_standard_changes tr.' + klass).show()
  $('select').on('change', function(e) {
    if ($(this).val() == 'all') {
      $('tr').slideDown(1000);
    } else {
      $('tr').slideUp(1000);
      $('tr.' + $(this).val()).slideDown(1000);
    }
  });
});

