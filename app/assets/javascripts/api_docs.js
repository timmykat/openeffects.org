$(function() {
  // Preload running gif
  if ($('body').hasClass('c_admin')) {
    var runningImage = new Image();
    runningImage.src = '/assets/ajax-running.gif';
  }
  // Format the output
  var termOut = function(line) { return '&gt; ' + line + '<br />'; }
  
  var startListening = function() {
    
    
    return source;
  };
  var stopListening = function(source) {
    source.close();
  }
  
  $('#pull-from-github button').on('click', function(e) {
    $('#terminal').modal('show')
    e.preventDefault();
    $('.update-status').html('Running <img src="' + $('.insert-nav-status').data('running') + '" />').removeClass('text-danger', 'text-success').addClass('text-warning')
    
    $form = $(e.currentTarget).parent().parent()
    var url = $form.attr('action') + '?' + $form.serialize();
    
    var source = new EventSource(url);
    source.addEventListener('terminal-output', function(e) {
      var $termWindow = $('#terminal .window')
      $termWindow.append(termOut(e.data));
      $termWindow.scrollTop($termWindow[0].scrollHeight);
    });
    source.addEventListener('eof', function(e) {
      source.close();
      $('.update-status').html('DONE <span class="glyphicon glyphicon-thumbs-up"></span>').removeClass('text-warning').addClass('text-success');
    });
  });
  $('#insert-navbars button').on('click', function(e) {
    var id = $(this).attr('id')
    $('#terminal').modal('show')
    e.preventDefault()
    
    $('.insert-nav-status').html('Running <img src="' + $('.insert-nav-status').data('running') + '" />').removeClass('text-danger', 'text-success').addClass('text-warning')
    $form = $(e.currentTarget).parent().parent()
    
    var url = $form.attr('action') + '?' + $form.serialize() + '&process_doc=' + id + '&timestamp=' + Date.now();

    var source = new EventSource(url);
    source.addEventListener('terminal-output', function(e) {
      var $termWindow = $('#terminal .window')
      $termWindow.append(termOut(e.data));
      $termWindow.scrollTop($termWindow[0].scrollHeight);
    });
    source.addEventListener('eof', function(e) {
      source.close();
      $('.insert-nav-status').html('DONE <span class="glyphicon glyphicon-thumbs-up"></span>').removeClass('text-warning').addClass('text-success');
    });
  });  
});
