// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
  $('select').on('change', function(e) {
    console.log('Got it');
    if ($(this).val() == 'all') {
      $('tr').slideDown(1000);
    } else {
      $('tr').slideUp(1000);
      $('tr.' + $(this).val()).slideDown(1000);
    }
  });
});

