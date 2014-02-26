$(function() {
  
  // Implement datepicker across date fields
  $('.input-group.date').datepicker({
    format: 'dd-M-yyyy'
  });
  
  //Implement smooth scrolling per page links (requires offset for top bar)
  $('a').smoothScroll({ offset: -60 })
});