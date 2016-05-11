'use strict';

describe("The revealables plugin.", function () {

  describe("The plugin itself", function () {

    beforeEach(function () {
      loadFixtures('revealables.html');
    });

    it("should exist as a function on $.fn", function () {
      expect(typeof $.fn.revealables).toEqual('function');
    });

    it("all required elements should be present in the fixture", function () {
      expect($('.revealables .item').length).not.toEqual(0)
    });

    describe("Before being applied", function () {

      it("no .item elements should be hidden", function () {
        $('.item').each(function () {
          var $this = $(this);
          expect($this.css('display')).not.toEqual('none');
        })
      });

      it("there should be no .add-another button", function () {
        expect($('.add-another').length).toEqual(0);
      });

      it("there should be no .remove items", function () {
        expect($('.remove').length).toEqual(0);
      })

    });

    describe("After being applied", function () {

      beforeEach(function () {
        $('.revealables').revealables();
      });

      it("there should be one .add-another button", function () {
        expect($('.add-another').length).toEqual(1);
      });

      describe("any .item elements without .shown class", function () {

        it("should be hidden", function () {
          $('.item').not('.shown').each(function () {
            var $this = $(this);
            expect($this.css('display')).toEqual('none');
          })
        });

        it("should be aria-hidden='true'", function () {
          $('.item').not('.shown').each(function () {
            var $this = $(this);
            expect($this.attr('aria-hidden')).toEqual('true');
          })
        })
      });

      describe("any .item elements with .shown class", function () {

        it("should be displayed", function () {
          $('.item.shown').each(function () {
            var $this = $(this);
            expect($this.css('display')).toEqual('block');
          })
        });

        it("should be aria-hidden='false'", function () {
          $('.item.shown').each(function () {
            var $this = $(this);
            expect($this.attr('aria-hidden')).toEqual('false');
          })
        });
      })
    });

    describe("User interactions:", function () {

      describe("A click on .add-another", function () {

        beforeEach(function () {
          $('.revealables').revealables();
        });

        it("should increment the number of .item elements that are .shown", function () {
          var shownItems = $('.item.shown').length;

          $('.add-another').trigger('click');

          expect($('.shown').length).toEqual(shownItems + 1);

        });

        it("should result in hiding .add-another if all .item elements have .shown", function () {
          $('.item').each(function () {
            var $this = $(this);
            $this.addClass('shown');
          });

          $('.add-another').trigger('click');

          expect($('.add-another').css('display')).toEqual('none');

        });

      });

      describe("Changing a .destroy checkbox", function () {

        beforeEach(function () {
          $('.revealables').revealables();
        });

        it("should result in '.shown' being removed from the ancestor .item", function () {
          var totalShownItems, $firstShownItem;
          totalShownItems = $('.item.shown').length;
          $firstShownItem = $('.item.shown').first();
          $firstShownItem.find('input[type=checkbox]').trigger('click');
          expect($('.shown').length).toEqual(totalShownItems - 1);
          expect($firstShownItem.hasClass('shown')).toEqual(false);
        });

        it("should result in the ancestor .item being hidden", function () {
          var $firstShownItem;
          $firstShownItem = $('.item.shown').first();
          $firstShownItem.find('input[type=checkbox]').trigger('click');
          expect($firstShownItem.css('display')).toEqual('none');
        });

        it("should result in the ancestor .item having aria-hidden='true'", function () {
          var $firstShownItem;
          $firstShownItem = $('.item.shown').first();
          $firstShownItem.find('input[type=checkbox]').trigger('click');
          expect($firstShownItem.attr('aria-hidden')).toEqual('true');
        });

        it("should result in all input values being cleared", function () {
          var $firstShownItem;
          $firstShownItem = $('.item.shown').first();

          // Populating all text fields with dummy text
          $firstShownItem.find('input[type=text]').each(function () {
            var $this = $(this);
            $this.val('Test population');
          });

          // Checking for the dummy text
          $firstShownItem.find('input[type=text]').each(function () {
            var $this = $(this);
            expect($this.val()).toEqual('Test population')
          });

          // Triggering the user action
          $firstShownItem.find('input[type=checkbox]').trigger('click');

          // Checking for the dummy text
          $firstShownItem.find('input[type=text]').each(function () {
            var $this = $(this);
            expect($this.val()).toEqual('')
          });
        })
      })
    });

    describe("when applied with the 'appendDestroyLinks' option", function () {

      beforeEach(function () {
        loadFixtures('revealables-append-destroy.html');
      });

      describe("before being applied", function () {
        it("there should be no 'input[type=checkbox]' present in the DOM", function () {
          expect($('input[type=checkbox]').length).toEqual(0);
        })
      });

      describe("after being applied", function () {
        beforeEach(function () {
          // Note: this is applied with the appendDestroyLinks option set
          $('.no-destroy-link-revealables').revealables({appendDestroyOption: true});
        });
        describe("the .destroy control should be added", function () {
          it("each .item should contain a checkbox with class .destroy", function () {
            $('.item').each(function () {
              var $this, $destroyCheckbox, checkboxId, labelPointingToCheckbox;
              $this = $(this);
              $destroyCheckbox = $this.find('input[type=checkbox].destroy');
              checkboxId = $destroyCheckbox.attr('id');
              expect($destroyCheckbox.length).toEqual(1);
            })
          })
        })
      });

    })
  });
});