'use strict';

(function ($) {

  var traverseItems, updateItemDisplay,
    createAddAnotherButton, setUpEvents,
    hideAddAnotherIfAllElementsAreShown,
    clearInputs, appendDestroyOptions, init;

  traverseItems = function ($el) {
    $el.find('.item').each(function () {
      var $this = $(this);
      updateItemDisplay($this);
      hideAddAnotherIfAllElementsAreShown($el);
      clearInputs($this);
    })
  };

  updateItemDisplay = function ($el) {
    if ($el.hasClass('shown')) {
      $el.show();
      $el.attr('aria-hidden', 'false');
    } else {
      $el.hide();
      $el.attr('aria-hidden', 'true');
    }
  };

  createAddAnotherButton = function ($el, buttonText) {
    var addAnotherButton = $('<button>', {
      'text': buttonText,
      'type': 'button',
      'class': 'add-another'
    });
    $el.append(addAnotherButton);
  };

  setUpEvents = function ($el) {
    $el.on('click', '.add-another', function () {
      $('.item', $el).not('.shown').first().addClass('shown');
      traverseItems($el);
    });
    $el.on('change', '.destroy', function (e) {
      var $item = $(e.currentTarget).closest('.item');
      $item.removeClass('shown');
      traverseItems($el);
    });
  };

  hideAddAnotherIfAllElementsAreShown = function ($el) {
    var numberOfItems = $('.item').length,
      numberOfShownItems = $('.item.shown').length;

    if (numberOfItems === numberOfShownItems) {
      $('.add-another', $el).hide();
    } else {
      $('.add-another', $el).show();
    }
  };

  clearInputs = function ($el) {
    if ($el.hasClass('shown') === false) {
      $el.find('input[type=text]').val('');
      $el.find('input[type=checkbox]').prop('checked', false);
      $el.find('select').val('');
    }
  };

  appendDestroyOptions = function ($el) {
    var $items = $el.find('.item');
    $items.each(function () {
      var $this, $destroyCheckbox, $destroyLabel;
      $this = $(this);
      $destroyCheckbox = $('<input>', {'type': 'checkbox', 'class': 'destroy'});
      $destroyLabel = $('<label>', {'text' : 'Remove', 'class' : 'remove-link'});
      $destroyLabel.append($destroyCheckbox);
      $this.append($destroyLabel);
    })
  };

  init = function ($el, settings) {
    createAddAnotherButton($el, settings.addAnotherText);
    traverseItems($el);
    setUpEvents($el);
    settings.appendDestroyOption && appendDestroyOptions($el);
  };

  $.fn.revealables = function (options) {
    var settings = $.extend({}, $.fn.revealables.defaults, options);
    return this.each(function () {
      var $this = $(this);
      init($this, settings);
    })
  };

  $.fn.revealables.defaults = {
    addAnotherText: 'Add another',
    appendDestroyOption: false
  };

})(jQuery);

$('.medications-container').revealables({addAnotherText: 'Add another medication'});
$('.offences-container').revealables({addAnotherText: 'Add another offence'});
$('.aliases-container').revealables({
  addAnotherText: 'Add another alias',
  appendDestroyOption: true
});