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
      var $commentWell = $(this.bodyElement).parent().parent()
      var editorId = $(this.bodyElement).attr('id')
      var id = $(this.bodyElement).parent().attr('id').replace('cid-','');
      var comment = $(this)[0].bodyElement.innerHTML;
      var postData = "comment[comment]=" + encodeURIComponent(comment)
      $.ajax({
        method: 'patch',
        url: "/comments/" + id, 
        data: postData,
        success: function(data) {
          console.log($commentWell)
          $commentWell.switchClass(null, 'confirmed', 50, null, function() {
              $commentWell.switchClass('confirmed', null, 2000);
            }
          );
        }
      });
    }
  });
  //Fix id here.
  $('.glyphicon-trash').on('click', function(e) {
    var $commentBody = $(e.currentTarget).parent().parent()
    var id = $commentBody.attr('id').replace('cid-','');
    $.ajax({
      method: 'delete',
      url: "/comments/" + id,
      success: function (data) {
        $commentBody.parent().addClass('deleted').remove();
      }
    });
  });
});

