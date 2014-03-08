$(window).load(function () {
  var setIframeHeight = function(iframe) {
    if (iframe) {
      var iframeWin = iframe.contentWindow || iframe.contentDocument.parentWindow;
      if (iframeWin.document.body) {
        iframe.height = iframeWin.document.documentElement.scrollHeight || iframeWin.document.body.scrollHeight;
      }
    }
  } 
  setIframeHeight(document.getElementById('api-docs'));
});