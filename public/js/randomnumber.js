requirejs.config({ paths: { jquery: '/mojo/jquery/jquery' } });

require(['jquery', 'knockout', 'domReady!'], function ($, ko) {
  'use strict';

  var RandomNumberViewModel = function () {
    var self = this;

    self.randomNumber = ko.observable();
    self.rollResult = ko.observable();

    $.ajax('/randomnumber/get').done(function (data) {
      self.randomNumber(data);
    });

    self.rollD6 = function () {
      $.ajax('/randomnumber/d6').done(function (data) {
        self.rollResult(data);
      });
    };
  };

  ko.applyBindings(new RandomNumberViewModel());
});
