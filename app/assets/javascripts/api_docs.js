$(function() {
  // Preload running gif
  if ($('body').hasClass('c_admin')) {
    var runningImage = new Image();
    runningImage.src = '/assets/ajax-running.gif';
  }
  var termOut = function(line) { return '&gt; ' + line + '<br />'; }
  $('#pull-from-github button').on('click', function(e) {
    $('#terminal').modal('show')
    e.preventDefault();

    $form = $(e.currentTarget).parent().parent()
    var url = $form.attr('action') + '?' + $form.serialize();

    //AJAX call
    var ajaxCall = function(url, eventResource) {
      $.ajax({
        url: url,
        success: function() {
          eventResource.close();
          $('.update-status').html('DONE <span class="glyphicon glyphicon-thumbs-up"></span>').removeClass('text-warning').addClass('text-success');
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
          $('.update-status').html('DONE <span class="glyphicon glyphicon-thumbs-up"></span>').removeClass('text-warning').addClass('text-success');
        }
      }      
      ajaxCall(url, source);
    } else {
      ajaxCall(url);
      $('.update-status').html('Running <img src="' + $('.update-status').data('running') + '" />').removeClass('text-danger', 'text-success').addClass('text-warning')
    }
  });
  $('#insert-navbars button').on('click', function(e) {
    var id = $(this).attr('id')
    $('#terminal').modal('show')
    e.preventDefault()
    $('.insert-nav-status').html('Running <img src="' + $('.insert-nav-status').data('running') + '" />').removeClass('text-danger', 'text-success').addClass('text-warning')
    $form = $(e.currentTarget).parent().parent()
    var url = $form.attr('action') + '?' + $form.serialize() + '&process_doc=' + id;

    //AJAX call
    var ajaxCall = function(url, eventResource) {
      $.ajax({
        url: url,
        success: function(data) {
          eventResource.close();
          $('.insert-nav-status').html('DONE <span class="glyphicon glyphicon-thumbs-up"></span>').removeClass('text-warning').addClass('text-success');
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
          $('.insert-nav-status').html('DONE <span class="glyphicon glyphicon-thumbs-up"></span>').removeClass('text-warning').addClass('text-success');
        }
      }      
      ajaxCall(url, source);
    } else {
      ajaxCall(url);
      $('.insert-nav-status').html('DONE <span class="glyphicon glyphicon-thumbs-up"></span>').removeClass('text-warning', 'text-danger').addClass('text-success')
    }
  });  
});
