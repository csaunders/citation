if(typeof(Citation) === 'undefined'){
  Citation = {};
}

Citation.Quote = function(data) {
  sendQuote = function(data) {
    var quote = "";
    if (window.getSelection) {
      quote = window.getSelection().toString();
    } else if (document.selection && document.selection.type !== 'Control') {
      quote = document.selection.createRange().text;
    }
    if (quote !== "") {
      url = document.location.toString();
      title = document.title;
      $.ajax({
        url: data.url,
        type: 'POST',
        jsonp: 'callback',
        dataType: 'jsonp',
        data: {
          token: data.token,
          quote: quote,
          url: url,
          title: title
        },
        success: function(response){
          console.log(response);
        }
      });
    }
  }
  if (typeof(jQuery) === 'undefined') {
    jq = document.createElement('script');
    jq.onload = (function(){sendQuote(data)});
    jq.src = '//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js';
    document.body.appendChild(jq);
  } else {
    sendQuote(data);
  }
}
