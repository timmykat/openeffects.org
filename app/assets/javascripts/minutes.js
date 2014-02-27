// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
  $('.publishing button').click(function(e) {
    targetId = $(e.currentTarget).attr('id')
    $.get('/minutes/ajax/toggle_published', { id: targetId.replace('pub-','') }, function(status) {
      if (status == 'published') {
        $('#' + targetId).addClass('published btn-success')
        $('#' + targetId).removeClass('btn-warning')
        $('#' + targetId).text('Unpublish');
      } else {
        $('#' + targetId).removeClass('published btn-success')
        $('#' + targetId).addClass('btn-warning')
        $('#' + targetId).text('Publish');
      }
    }, 'text' );
  }); 
});
