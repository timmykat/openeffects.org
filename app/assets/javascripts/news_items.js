// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
    // Implement datepicker across date fields
  $('.input-group.date').datepicker({
    format: 'dd-M-yyyy',
    orientation: 'top'
  });
});