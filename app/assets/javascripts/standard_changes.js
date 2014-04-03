// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
  $('.c_standard_changes tr').hide()
  klass = $('select').val()
  $('.c_standard_changes tr.' + klass).show()
  $('select').on('change', function(e) {
    if ($(this).val() == 'all') {
      $('tr').slideDown(1000);
    } else {
      $('tr').slideUp(1000);
      $('tr.' + $(this).val()).slideDown(1000);
    }
  });
  
  //TinyMCE Inline editing of comments
  tinymce.init({
    selector: '.editable',
    inline: true,
    menubar: false,
    plugins: [ "lists autolink link table paste save" ],
    toolbar: "undo redo | bold italic | alignleft aligncenter alignright | bullist numlist outdent indent | link | save",
    save_onsavecallback: function() {
      var id = $(this.bodyElement).parent().attr('id').replace('cid-','');
      var comment = $(this)[0].bodyElement.innerHTML;
      var postData = "comment[comment]=" + encodeURIComponent(comment)
      $.ajax({
        method: 'put',
        url: "/comments/#{id}", 
        data: postData
      });
    }
  });
  $('.glyphicon-trash').on('click', function(e) {
    var $commentBody = $(e.currentTarget).parent().parent()
    var id = $commentBody.attr('id').replace('cid-','');
    $.ajax({
      method: 'delete',
      url: "/comments/" + id,
      success: function (data) {
        $commentBody.parent().remove();
      }
    });
  });
});

