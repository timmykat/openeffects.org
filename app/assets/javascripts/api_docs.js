$(function() {
  // Preload running gif
  var runningImage = new Image();
  runningImage.src = $('.update-status').data('running')
  var termOut = function(line) { return '&gt; ' + line + '<br />'; }
  $('#pull-from-github button').on('click', function(e) {
    $('#terminal').modal('show')
    e.preventDefault();

    $form = $(e.currentTarget).parent().parent()
    var url = $form.attr('action') + '?' + $form.serialize();

    //AJAX call
    ajaxCall = function(url, eventResource) {
      $.ajax({
        url: url,
        success: function() {
          eventResource.close();
          $('.update-status').html('DONE').removeClass('text-warning').addClass('text-success');
        }
      });
    }    
    //Add streaming event listener
    if (!!window.EventSource) {
      var source = new EventSource(url);
      source.onmessage = function(e) {
        var $termWindow = $('#terminal .window')
        $termWindow.append(termOut(e.data));
        $termWindow.scrollTop($termWindow[0].scrollHeight);       
      }
      source.onerror = function(e) {
        if (e.readyState == EventSource.CLOSED) {
          $('#terminal .window').append(termOut('DONE (no need to do any copying)'));
          $('.update-status').html('DONE').removeClass('text-warning').addClass('text-success');
        }
      }      
    } else {
      $('.update-status').html('Running <img src="' + $('.update-status').data('running') + '" />').removeClass('text-danger', 'text-success').addClass('text-warning')
    }
    $.ajax({
      url: url,
      data: $form.serialize(),
      success: function() {
        source.close();
        $('#terminal .window').append('<p>DONE</p>');
        $('.update-status').html('DONE').removeClass('text-warning').addClass('text-success');
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
