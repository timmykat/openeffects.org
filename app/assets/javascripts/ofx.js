$(function() {
  
  // Implement datepicker across date fields
  $('.input-group.date').datepicker({
    format: 'dd-M-yyyy'
  });
  
  //Implement smooth scrolling per page links (requires offset for top bar)
  $('a').smoothScroll({ offset: -60 })

  // Toggle button for tinyMCE
  $('body').on('click', '.toggle-mce', function(e) {
    e.preventDefault();
    var editor_id = $(e.currentTarget).attr('class').split(' ').pop();
    tinymce.execCommand('mceToggleEditor',false, editor_id);
  }); 

  tinymce.settings.setup = function(ed) { 
    ed.on('init', function(ed) {
      $editor = $(ed.target.contentAreaContainer).parent().parent().parent();
      $editor.append('<br><p><a href="#" class="btn btn-primary toggle-mce ' + ed.target.id + '"><span>Toggle WYSIWIG/Source</span></a></p>')
     }); 
  }
});
