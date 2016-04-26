'use strict';

(function ($) {

  $.fn.aliases = function (options) {

    var init, hideGroupsWithoutShownClass, showAddAnotherButton,
      appendRemoveLink, manageShowAnotherButton;

    init = function ($el) {
      hideGroupsWithoutShownClass($el);
      showAddAnotherButton($el);
      appendRemoveLink($el);
    };

    manageShowAnotherButton = function () {

      var $addAlias = $('.add-another-alias');
      $addAlias.attr('disabled', false)
      $('.shown').each(function () {
        var $group = $(this);
        $group.each(function () {
          var $input = $group.find('input');
          if($input.val() == '') {
            $addAlias.attr('disabled', 'disabled');
          }
        })
      })

    }

    showAddAnotherButton = function ($el) {
      var button = $('<button>', {
        type: 'button',
        text: 'Add another',
        class: 'add-another-alias'
      }).appendTo($el);
    };

    appendRemoveLink = function ($el) {
      $el.find('.form-group').each(function () {
        var $group = $(this);
        var $removeButton = $('<button>', {
          text: 'Remove',
          class: 'remove-alias'
        });

        $group.find('input').after($removeButton);
      })
    };

    hideGroupsWithoutShownClass = function ($el) {
      $el.find('.form-group').each(function () {
        var $group = $(this);
        $group.hide();
        if ($group.hasClass('shown')) {
          $group.show();
        }
      })
    };

    return this.each(function () {
      var $this = $(this);

      init($this);

      $this.on('click', function (e) {
        e.preventDefault();

        var $target = $(e.target), $this = $(this);

        if ($target.hasClass('remove-alias')) {
          var $form_group = $target.closest('.form-group');
          $form_group.find('input').val('');
          $form_group.removeClass('shown');
          hideGroupsWithoutShownClass($this);
        }

        if ($target.hasClass('add-another-alias')) {
          $this.find('.form-group').not('.shown').first().addClass('shown');
          hideGroupsWithoutShownClass($this);
        }

        manageShowAnotherButton($this);

      })

      $this.on('keyup', function () {

        var $this = $(this);

        manageShowAnotherButton($this);
      })

    })
  };


})(jQuery);

$('.aliases').aliases();

