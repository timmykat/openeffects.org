$(function() {
  // Preload running gif
  var runningImage = new Image();
  runningImage.src = $('.update-status').data('running')
  $('#pull-from-github button').on('click', function(e) {
    e.preventDefault();
    $('.update-status').html('Running <img src="' + $('.update-status').data('running') + '" />').removeClass('text-danger', 'text-success').addClass('text-warning')
    $form = $(e.currentTarget).parent().parent()
    var action = $form.attr('action')
    $.getJSON(action, $form.serialize(), function(data) {
      if (data.error) {
        $('.update-status').text('Error').removeClass('text-success').addClass('text-danger')
        $('form#pull-from-github input').parent().addClass('has-error');
      } else {
        $('.update-status').html('Done <span class="glyphicon glyphicon-thumbs-up"></span>').removeClass('text-warning', 'text-danger').addClass('text-success')
      }
    });
  });
  $('#insert-navbars button').on('click', function(e) {
    e.preventDefault()
    $('.insert-nav-status').html('Running <img src="' + $('.insert-nav-status').data('running') + '" />').removeClass('text-danger', 'text-success').addClass('text-warning')
    var $form = $(e.currentTarget).parent().parent()
    var action = $form.attr('action')
    $.getJSON(action, $form.serialize(), function(data) {
      $('.insert-nav-status').html('Done <span class="glyphicon glyphicon-thumbs-up"></span>').removeClass('text-warning', 'text-danger').addClass('text-success')
    });
  });  
});
