$(function() {
  $('#m').ajaxForm({
    data: {format: 'json'},
    dataType: 'json',
    clearForm: true,
    success: function(data) {
      var div = $('<div></div>');
      if (!data.error) {
        data.forEach(function(item) {
          var img = $('<img>');
          img.attr('title', item.title);
          img.attr('alt', item.title);
          img.attr('src', item.url);

          var a = $('<a>');
          a.attr('href', 'https://www.goodreads.com/book/show/' + item.id);
          a.append(img);

          div.append(a);
        });

        $('#result').empty().hide().append(div).show('slow');
      }
      else {
        var p = $('<p></p>');
        var e = data.error;
        $('#result').empty().hide().append(p.append(e)).show('slow');
      }
    },
    error: function(jqXHR, textStatus, errorThrown) {
      var e = jqXHR.status + " " + textStatus + ": " + errorThrown;
      $('#result'). empty().hide().append(p.append(e)).show('slow');
    }
  });
});
