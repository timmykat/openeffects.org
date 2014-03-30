// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {

  // User management
  $('#users input:checkbox').click(function(e) {
    if ($(this).hasClass('approved')) {
      var userId = $(e.currentTarget).attr('id');
      var data = { value: 'approved', id: userId.replace('user-','') };
      var successFn = function(status) {
        if (status == 'approved') {
          $('#' + userId).parent().parent().addClass('text-success').removeClass('text-danger');
        } else {
          $('#' + userId).parent().parent().removeClass('text-success').addClass('text-danger');
        }
      };
    } else if ($(this).hasClass('role')) {
      var targetId = $(e.currentTarget).attr('id');
      var role = $(e.currentTarget).attr('value');
      var params = targetId.split('-');
      var data = { value: 'role', id: params[2], role: params[1] }
      var successFn = function(status) {};
    }
    $.get('/ajax/users/toggle', data, successFn(status), 'text' );
  }); 
});


