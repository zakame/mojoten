requirejs.config({ paths: { jquery: '/mojo/jquery/jquery' } });

require(['jquery', 'knockout', 'domReady!'], function ($, ko) {
  'use strict';

  ko.components.register('cover-images', {
    viewModel: function (params) {
      this.result = params.result;
      this.error = params.error;
      this.visible = params.visible;
    },
    template: { require: 'text!tmpl/cover-images.html' }
  });

  var CoverImagesViewModel = function () {
    var self = this;

    self.coverTitle = ko.observable('');
    self.result = ko.observable(false);
    self.error = ko.observable(false);

    self.isLoading = ko.observable(false);

    self.getCoversForTitle = function () {
      self.result(false);
      self.error(false);
      self.isLoading(true);

      $.ajax('/covers/title', {
        data: ko.toJSON({ title: this.coverTitle() }),
        dataType: 'json',
        type: 'post',
        contentType: 'application/json'
      }).done(function (data) {
        if (data.error)
          self.error(data);
        else
          self.result(data);
      }).fail(function (jqXHR, textStatus, errorThrown) {
        self.error({ error: jqXHR.status + ' ' + errorThrown });
        self.result(false);
      }).always(function () {
        self.coverTitle('');
        self.isLoading(false);
      });
    };
  };

  ko.applyBindings(new CoverImagesViewModel());
});
