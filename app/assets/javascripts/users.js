// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {

  // Approving users
  $('#user button').click(function(e) {
    targetId = $(e.currentTarget).attr('id')
    $.get('/ajax/users/toggle_approved', { id: targetId.replace('user-','') }, function(status) {
      if (status == 'approved') {
        $('#' + targetId).addClass('approved btn-success');
        $('#' + targetId).removeClass('btn-warning');
        $('#' + targetId).text('Unapprove');
        $('#' + targetId).parent().siblings().find('input:checkbox').removeAttr('disabled')
      } else {
        $('#' + targetId).removeClass('approved btn-success');
        $('#' + targetId).addClass('btn-warning');
        $('#' + targetId).text('Approve');
        $('#' + targetId).parent().siblings().find('input:checkbox').attr('disabled', true)
      }
    }, 'text' );
  }); 
  //Changing roles
  $('#user input:checkbox').change(function(e) {
    var targetId = $(e.currentTarget).attr('id');
    var role = $(e.currentTarget).attr('value');
    var params = targetId.split('-');
    $.get('/ajax/users//toggle_role', { id: params[2], role: params[1] }, function(status) {
      if (status == 'added') {
        $('#' + targetId).attr('checked', 'checked')
      } else {
        $('#' + targetId).removeAttr('checked')
      }
    }, 'text' );
  });
});


