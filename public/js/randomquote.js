requirejs.config({ paths: { jquery: '/mojo/jquery/jquery' } });

require(['jquery', 'knockout', 'domReady!'], function ($, ko) {
  'use strict';

  var RandomQuotesViewModel = function () {
    var self = this;

    self.quote = ko.observable('');
    self.quotes = ko.observableArray([]);

    self.getQuote = function () {
      $.getJSON('/randomquote/quote')
        .done(function (data) { self.quote(data) });
    };
    self.getAllQuotes = function () {
      $.getJSON('/randomquote/show_all')
        .done(function (data) { self.quotes(data) });
    };
  };

  ko.applyBindings(new RandomQuotesViewModel());
});
