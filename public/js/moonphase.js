requirejs.config({
  paths: { jquery: '/mojo/jquery/jquery' },
  shim: { 'jquery.form': ['jquery'] }
});

requirejs(['jquery', 'jquery.form', 'domReady!'], function ($) {
  $('#m').ajaxForm({
    data: { format: 'json' },
    dataType: 'json',
    clearForm: true,
    success: function (data) {
      // input string parsed as date (with optional time)
      var p = $('<p></p>');
      if (!data.error) {
        $('#result').attr('class', 'success');
        var e = data.time +
          ": The moon is at " + data.illuminated + "% full and " + data.phase;
      }
      else {
        // bad input, emit error message 
        $('#result').attr('class', 'error');
        var e = data.error;
      }
      $('#result').empty().hide().append(p.append(e)).show('slow');
    },
    error: function (jqXHR, textStatus, errorThrown) {
      var p = $('<p></p>').addClass('error');
      var e = jqXHR.status + " " + textStatus + ": " + errorThrown;
      $('#result').empty().hide().append(p.append(e)).show('slow');
    }
  });
});
