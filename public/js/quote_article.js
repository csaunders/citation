if(typeof(Citation) === 'undefined'){
  Citation = {};
}

Citation.Success = function(data) {
  console.log(data)
}

Citation.Modal = function(data, callback) {
  modal = document.createElement('div')
  modal.setAttribute('style', "width:50%;height:500px;z-index:500;margin-left:0 auto;margin-right:0 auto;background-color:red;position:fixed;left:25%;top:15%");
  modal.setAttribute('id', 'citation-add-tags');
  modal.setAttribute('class', 'citation-add-article');

  jQuery(modal).fadeIn().fadeOut();
  document.body.appendChild(modal);
  callback(data);
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
      jQuery.ajax({
        url: data.url,
        type: 'POST',
        jsonp: 'Citation.Success',
        dataType: 'jsonp',
        data: {
          token: data.token,
          quote: quote,
          url: url,
          title: title,
          tagstring: ""
        },
        success: function(response){
          console.log(response);
        }
      });
    }
  }
  if (typeof(jQuery) === 'undefined') {
    jq = document.createElement('script');
    jq.onload = (function(){Citation.Modal(data, sendQuote)});
    jq.src = '//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js';
    document.body.appendChild(jq);
  } else {
    Citation.Modal(data, sendQuote);
  }
}
