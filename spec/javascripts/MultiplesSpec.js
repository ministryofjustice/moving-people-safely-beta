'use strict';

describe("The multiples plugin", function () {

  describe("The plugin", function () {

    beforeEach(function () {
      loadFixtures('Multiples.html');
    });

    it("should exist as a function on $.fn", function () {
      expect(typeof $.fn.multiples).toEqual('function');
    });

  });

  describe("Before multiples is applied:", function () {

    beforeEach(function () {
      loadFixtures('Multiples.html');
    });

    it("There should not be an 'add-another' in the DOM", function () {
      expect($('.add-another').length).toEqual(0);
    });

    it("All '.item' elements should have 'display: block'", function () {
      $('.item').each(function () {
        expect($(this).css('display')).toEqual('block')
      })
    });

    it("No '.item' elements should have an 'aria-hidden' attribute", function () {
      $('.item').each(function () {
        expect($(this)[0].hasAttribute('aria-hidden')).toEqual(false);
      });
    })

  });

  describe("After multiples is applied:", function () {

    beforeEach(function () {
      loadFixtures('Multiples.html');
      $('.multiples-container').multiples();
    });

    it("There should be one 'add-another' button in the DOM for each 'multiples-container'", function () {
      var numberOfAddAnotherButton = $('.add-another').length;
      var numberOfMultiplesContainers = $('.multiples-container').length;
      expect(numberOfAddAnotherButton).toEqual(numberOfMultiplesContainers);
    });

    it("The 'add-another' link parent should be 'multiples-container' in the DOM", function () {
      expect($('.add-another').parent().hasClass('multiples-container')).toEqual(true);
    });

    it("All '.item' elements which have 'shown' class should be 'display: block'", function () {
      $('.item').each(function () {
        var $this = $(this);
        if ($this.hasClass('shown')) {
          expect($(this).css('display')).toEqual('block');
        } else {
          expect($(this).css('display')).toEqual('none');
        }
      })
    });

    it("All '.item' elements which have a 'shown' class should have the appropriate 'aria-hidden' attirubte'", function () {
      $('.item').each(function () {
        var $this = $(this);
        if ($this.hasClass('shown')) {
          expect($(this).attr('aria-hidden')).toEqual('false');
        } else {
          expect($(this).attr('aria-hidden')).toEqual('true');
        }
      })
    })


  });

  describe("Interacting with 'remove':", function () {

    beforeEach(function () {
      loadFixtures('Multiples.html');
      $('.multiples-container').multiples();
    });

    it("Clicking 'remove' should hide the parent element", function () {
      var $firstShown, $removeLink;
      $firstShown = $('.shown').first();
      $removeLink = $firstShown.find('input[value="_destroy"]');
      expect($firstShown.css('display')).toEqual('block');
      $removeLink.click();
      expect($firstShown.css('display')).toEqual('none');
    });

  });

  describe("Interacting with 'add another':", function () {

    beforeEach(function () {
      loadFixtures('Multiples.html');
      $('.multiples-container').multiples();
    });

    it("Clicking 'add another' should increase the number of elements with 'shown' class by one", function () {
      var $initialNumberShown, $addAnother;
      $initialNumberShown = $('.shown').length;
      $addAnother = $('.multiples-container').find('.add-another');
      $addAnother.click();
      expect($('.shown').length).toEqual($initialNumberShown + 1);
    })

  });

  describe("The visibility of 'add-another' should be linked to visibility of '.item' elements are shown", function () {

    beforeEach(function () {
      loadFixtures('Multiples.html');
      $('.multiples-container').multiples();
    });

    it("Showing all '.item' elements should result in the 'add another' being hidden", function () {
      $('.item:not(.shown)').each(function () {
        $('.add-another').click();
      });
      expect($('.add-another').css('display')).toEqual('none');
    });

    it("Removing an '.item' element should result in the 'add another' link being shown", function () {
      $('.item.shown').first().find('input[value="_destroy"]').click();
      expect($('.add-another').css('display')).toEqual('inline-block');
    })

  });

});
