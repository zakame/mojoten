$(function() {
  $('#getquote').click(function() {
    $.getJSON("/randomquote/quote", function(data) {
      $('blockquote').empty().hide().append(data).show('slow');
    });
  });
  $('#getallquotes').click(function() {
    $.getJSON("/randomquote/show_all", function(data) {
      var items = [];
      $('#allquotes').empty();
      $.each(data, function() {
        items.push('<li>' + this + '</li>');
      });
      $('#allquotes').append(items.join(''));
    });
  });
});
