requirejs.config({ paths: { jquery: '/mojo/jquery/jquery' } });

require(['jquery', 'knockout', 'domReady!'], function ($, ko) {
  'use strict';

  var get = function (route, observable) {
    $.ajax(route).done(function (data) {
      observable(data);
    }).fail(function (jqXHR, textStatus, errorThrown) {
      observable(errorThrown + ' :p');
    });
  };

  var RandomNumberViewModel = function () {
    var self = this;

    self.randomNumber = ko.observable();
    self.rollResult = ko.observable();

    get('/randomnumber/get', self.randomNumber);

    self.rollD6 = function () {
      self.rollResult('rolling...');
      get('/randomnumber/d6', self.rollResult);
    };
  };

  ko.applyBindings(new RandomNumberViewModel());
});
