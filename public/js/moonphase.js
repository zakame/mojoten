requirejs.config({ paths: { jquery: '/mojo/jquery/jquery' } });

require(['jquery', 'knockout', 'domReady!'], function ($, ko) {
  'use strict';

  var MoonPhaseViewModel = function () {
    var self = this;

    self.time = ko.observable('');
    self.result = ko.observable(false);
    self.error = ko.observable(false);

    self.checkMoonPhase = function () {
      self.result(false);
      self.error(false);
      $.ajax('/moonphase/check', {
        data: ko.toJSON({ time: this.time() }),
        dataType: 'json',
        type: 'post',
        contentType: 'application/json'
      }).done(function (data) {
        if (data.error) {
          self.error(data);
        }
        else {
          self.result(data);
        }
      }).fail(function (jqXHR, textStatus, errorThrown) {
        self.error({ error: jqXHR.status + ' ' + errorThrown });
        self.result(false);
      }).always(function () { self.time('') });
    };
  };

  ko.applyBindings(new MoonPhaseViewModel());
});
