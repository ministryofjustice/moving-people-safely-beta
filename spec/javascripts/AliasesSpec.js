'use strict';

describe("The aliases plugin", function () {

  describe("The plugin", function () {

    beforeEach(function () {
      loadFixtures('Aliases.html');
    });

    it("should exist as a function on $.fn", function () {
      expect(typeof $.fn.aliases).toEqual('function');
    });

  });

  describe("Before Aliases is applied", function () {

    beforeEach(function () {
      loadFixtures('Aliases.html');
    });

    it("all .form-group elements within .aliases should have 'display: block'", function () {
      $('.aliases .form-group').each(function (e) {
        expect($(this).css('display')).toEqual('block');
      });
    });

    it("should have no element with .add-another present", function () {
      expect($('.aliases .add-another').length).toEqual(0);
    });

  });

  describe("After Aliases is applied", function () {

    beforeEach(function () {
      loadFixtures('Aliases.html');
      $('.aliases').aliases();
    });

    it("any .form-group elements with .shown class should have 'display: block'", function () {
      $('.aliases .form-group').each(function (e) {
        var $form_group = $(this);
        if ($form_group.hasClass('shown')) {
          expect($form_group.css('display')).toEqual('block');
        }
      })
    });

    it("any .form-group elements without .shown class should have 'display: none'", function () {
      $('.aliases .form-group').each(function (e) {
        var $form_group = $(this);
        if ($form_group.hasClass('shown') == false) {
          expect($form_group.css('display')).toEqual('none');
        }
      })
    });

    it("the .add-another-alias button should be present", function () {
      expect($('.aliases .add-another-alias').length).toEqual(1);
    });

    it("any .form-group elements with a .shown class should have a .remove-link present", function () {
      $('.aliases .form-group').each(function () {
        var $form_group = $(this);
        if ($form_group.hasClass('shown') == true) {
          expect($form_group.find('.remove-link').length).toEqual(1);
        }
      })
    })

  })
});