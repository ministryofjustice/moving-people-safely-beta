'use strict';

describe("The descendentElements plugin", function () {

  describe("The plugin", function () {

    beforeEach(function () {
      loadFixtures('DescendentElements.html');
    });

    it("should exist as a function on $.fn", function () {
      expect(typeof $.fn.descendentElements).toEqual('function');
    });

  });

  describe("Before descendentElements is applied:", function () {

    beforeEach(function () {
      loadFixtures('DescendentElements.html');
    });

    it("all '.optional-section' elements should be displayed", function () {
      $('.optional-section').each(function () {
        expect($(this).css('display')).toEqual('block');
      });
    });

    it("one of each radio button should be checked", function () {
      expect($('[id$="_true"]:checked').length).toEqual(1);
      expect($('[id$="_false"]:checked').length).toEqual(1);
      expect($('[id$="_unknown"]:checked').length).toEqual(1);
    });

    it("there should be one group where no options are selected", function () {
      expect($('.js_has_optional_section:not(:has(:checked))').length).toEqual(1)
    });

  });

  describe("After descendentElements is applied:", function () {

    beforeEach(function () {
      loadFixtures('DescendentElements.html');
    });

    it("any groups where 'false' is checked should have '.optional-section' hidden", function () {

      $('.js_has_optional_section').descendentElements();

      var $elsWithFalseSelected = $('.js_has_optional_section:has([id$="_false"]:checked)');

      $elsWithFalseSelected.each(function () {
        var $optEl = $(this).find('.optional-section');
        expect($optEl.css('display')).toEqual('none');
        expect($optEl.attr('aria-hidden')).toEqual('true');
      })
    });

    it("any groups where 'unknown' is checked should have '.optional-section' hidden", function () {

      $('.js_has_optional_section').descendentElements();

      var $elsWithUnknownSelected = $('.js_has_optional_section:has([id$="_unknown"]:checked)');

      $elsWithUnknownSelected.each(function () {
        var $optEl = $(this).find('.optional-section');
        expect($optEl.css('display')).toEqual('none');
        expect($optEl.attr('aria-hidden')).toEqual('true');
      })
    });


    it("any groups where 'true' is checked should have '.optional-section' shown", function () {

      $('.js_has_optional_section').descendentElements();

      var $elsWithTrueSelected = $('.js_has_optional_section:has([id$="_true"]:checked)');

      $elsWithTrueSelected.each(function () {
        var $optEl = $(this).find('.optional-section');
        expect($optEl.css('display')).toEqual('block');
        expect($optEl.attr('aria-hidden')).toEqual('false');
      })
    });

    it("any groups where no option is selected should have 'unknown' label hidden", function () {

      $('.js_has_optional_section').descendentElements();

      var $elWithNothingChecked = $('.js_has_optional_section:not(:has(:checked))'),
        $unknownLabel = $elWithNothingChecked.find('label[for$=_unknown]');

      expect($unknownLabel.css('display')).toEqual('none');
      expect($unknownLabel.attr('aria-hidden')).toEqual('true');
    });

    it("any groups where no option is selected should have 'unknown' label hidden", function () {

      $('.js_has_optional_section').descendentElements();

      var $elWithNothingChecked = $('.js_has_optional_section:not(:has(:checked))'),
        $unknownLabel = $elWithNothingChecked.find('label[for$=_unknown]');

      expect($unknownLabel.css('display')).toEqual('none');
      expect($unknownLabel.attr('aria-hidden')).toEqual('true');
    });

    it("any groups where 'unknown' is selected should have 'unknown' label hidden", function () {

      $('.js_has_optional_section').descendentElements();

      var $elsWithUnknownSelected = $('.js_has_optional_section:has([id$="_unknown"]:checked)');

      $elsWithUnknownSelected.each(function () {
        var $unknownLabel = $elsWithUnknownSelected.find('label[for$=_unknown]');
        expect($unknownLabel.css('display')).toEqual('none');
        expect($unknownLabel.attr('aria-hidden')).toEqual('true');
      })
    });

    it("any groups where 'true' is selected should have 'unknown' label shown", function () {

      $('.js_has_optional_section').descendentElements();

      var $elsWithTrueSelected = $('.js_has_optional_section:has([id$="_true"]:checked)');

      $elsWithTrueSelected.each(function () {
        var $unknownLabel = $elsWithTrueSelected.find('label[for$=_unknown]');
        expect($unknownLabel.css('display')).toEqual('inline');
        expect($unknownLabel.attr('aria-hidden')).toEqual('false');
      })
    });

    it("any groups where 'false' is selected should have 'unknown' label shown", function () {

      $('.js_has_optional_section').descendentElements();

      var $elsWithUnknownSelected = $('.js_has_optional_section:has([id$="_false"]:checked)');

      $elsWithUnknownSelected.each(function () {
        var $unknownLabel = $elsWithUnknownSelected.find('label[for$=_unknown]');
        expect($unknownLabel.css('display')).toEqual('inline');
        expect($unknownLabel.attr('aria-hidden')).toEqual('false');
      })
    });
  });

  describe("Interactions should cause a corresponding state change", function () {

    beforeEach(function () {
      loadFixtures('DescendentElements.html');
    });

    it("changing an 'unknown' option to 'true' should update the element state accordingly", function () {

      $('.js_has_optional_section').descendentElements();

      var $block, $optEl, $unknownLabel;

      $block = $('.js_has_optional_section:has([id$="_unknown"]:checked)');

      $block.find('input[id$="_true"]').trigger('click');

      $optEl = $block.find('.optional-section');
      expect($optEl.css('display')).toEqual('block');
      expect($optEl.attr('aria-hidden')).toEqual('false');

      $unknownLabel = $block.find('label[for$=_unknown]');
      expect($unknownLabel.css('display')).toEqual('inline');
      expect($unknownLabel.attr('aria-hidden')).toEqual('false');
    });

    it("changing a 'false' option to 'unknown' should update the element state accordingly", function () {

      $('.js_has_optional_section').descendentElements();

      var $block, $optEl, $unknownLabel;

      $block = $('.js_has_optional_section:has([id$="_false"]:checked)');

      $block.find('input[id$="_unknown"]').trigger('click');

      $optEl = $block.find('.optional-section');
      expect($optEl.css('display')).toEqual('none');
      expect($optEl.attr('aria-hidden')).toEqual('true');

      $unknownLabel = $block.find('label[for$=_unknown]');
      expect($unknownLabel.css('display')).toEqual('none');
      expect($unknownLabel.attr('aria-hidden')).toEqual('true');
    });

    it("changing a 'true' option to 'false' should update the element state accordingly", function () {

      $('.js_has_optional_section').descendentElements();

      var $block, $optEl, $unknownLabel;

      $block = $('.js_has_optional_section:has([id$="_true"]:checked)');

      $block.find('input[id$="_false"]').trigger('click');

      $optEl = $block.find('.optional-section');
      expect($optEl.css('display')).toEqual('none');
      expect($optEl.attr('aria-hidden')).toEqual('true');

      $unknownLabel = $block.find('label[for$=_unknown]');
      expect($unknownLabel.css('display')).toEqual('inline');
      expect($unknownLabel.attr('aria-hidden')).toEqual('false');
    });

  });

});

