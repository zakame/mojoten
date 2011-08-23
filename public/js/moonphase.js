$(function() {
  $('#m').ajaxForm({
    datatype: 'json',
    clearForm: true,
    success: function(data) {
      var e = "<p>" + data.time + ": The moon is at " + data.illuminated
        + "% full and " + data.phase + ".</p>"
      $('#result').empty().hide().append(e).show('slow');
    },
    error: function() {
      var e = "<p>What, that's no date or time I recognize!</p>";
      $('#result').empty().hide().append(e).show('slow');
    }
  });
});
