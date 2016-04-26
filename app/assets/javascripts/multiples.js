'use strict';

(function ($) {

  var insertShowButton, setUpEvents, showElementsWithShowClass,
    hideItem, showItem, showFirstHiddenItem, manageAddLink, init;

  init = function ($el, settings) {
    insertShowButton($el, settings);

    $el.find('.' + settings.itemClass).each(function () {
      var $this = $(this);
      setUpEvents($this, settings);
      showElementsWithShowClass(settings);
    })
  };

  hideItem = function ($el) {
    $el.removeClass('shown');
    $el.attr('aria-hidden', true);
    $el.hide();
  };

  showItem = function ($el) {
    $el.addClass('shown');
    $el.attr('aria-hidden', false);
    $el.find('[id$="_destroy"]')
      .prop('checked', false)
      .removeAttr('checked');
    $el.show();
  };

  setUpEvents = function ($el) {
    $el.on('change', function (e) {
      e.preventDefault();
      var $item, $input;
      $item = $(e.currentTarget);
      $input = $(e.target);

      if ($input.attr('id').indexOf("_destroy") != -1) {
        hideItem($item);
      }
    })
  };

  manageAddLink = function ($el) {
    var $numberOfItems, $numberOfShownItems;
    $numberOfItems = $el.find('.item').length;
    $numberOfShownItems = $el.find('.item.shown').length;

    if ($numberOfItems == $numberOfShownItems) {
      $('.add-another', $el).hide();
    } else {
      $('.add-another', $el).show();
    }
  };

  insertShowButton = function ($el, settings) {
    var $button = $('<button>', {
      'text' : settings.addAnotherText,
      'class' : settings.addAnotherClass,
      'type' : 'button'
    });
    $el.append($button);
  };

  showElementsWithShowClass = function (settings) {
    $('.' + settings.itemClass).each(function () {
      var $this = $(this);
      if ($this.hasClass(settings.shownClass)) {
        showItem($this);
      } else {
        hideItem($this);
      }
    })
  };

  showFirstHiddenItem = function ($el) {
    var $hiddenItems = $el.find('.item:not(.shown)');
    if ($hiddenItems.length > 0) {
      showItem($hiddenItems.first());
    }
  };

  $.fn.multiples = function (options) {
    var settings = $.extend({}, $.fn.multiples.defaults, options);
    return this.each(function () {
      var $this = $(this);
      init($this, settings);
      showFirstHiddenItem($this);
      $this.on('click', '.add-another', function (e) {
        var $container = $(e.delegateTarget);
        e.preventDefault();
        showFirstHiddenItem($container);
        manageAddLink($container);
      });
      $this.on('change', function () {
        manageAddLink($this);
      });
    })
  };

  $.fn.multiples.defaults = {
    addAnotherText: 'Add',
    addAnotherClass: 'add-another',
    itemClass: 'item',
    shownClass: 'shown'
  };

})(jQuery);


$('.multiples-container').multiples({addAnotherText: 'Add another medication'});