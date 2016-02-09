'use strict';

describe("The descendentElements plugin", function () {

  beforeEach(function () {
    loadFixtures('DescendentElements.html');
  });

  it("should exist as a function on $.fn", function () {
    expect(typeof $.fn.descendentElements).toEqual('function');
  });

  describe("Before descendentElements is applied, the HTML:", function () {

    it("should have the 'no' option selected", function () {
      expect($('#risk_no').attr('checked')).toEqual('checked');
    });

    it("should have the optional-section element displayed", function () {
      expect($('.optional-section').css('display')).toEqual('block');
    });
  });

  describe("After descendentElements is applied", function () {

    it("the optional-section is hidden", function () {
      $('.js_has_optional_section').descendentElements();
      expect($('.optional-section').css('display')).toEqual('none');
    });

    it("checking 'yes' should show the optional-section", function () {
      $('.js_has_optional_section').descendentElements();
      $('#risk_yes').change();
      expect($('.optional-section').css('display')).toEqual('block');
    });

    it("checking 'cleared' should hide the optional-section", function () {
      $('.js_has_optional_section').descendentElements();
      $('#risk_cleared').change();
      expect($('.optional-section').css('display')).toEqual('none');
    });

    it("checking 'no' should hide the optional-section", function () {
      $('.js_has_optional_section').descendentElements();
      $('#risk_no').change();
      expect($('.optional-section').css('display')).toEqual('none');
    });
  });
});