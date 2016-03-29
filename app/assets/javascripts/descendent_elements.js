'use strict';

(function ($) {

    var trueChecked, falseChecked, manageState, setVisibility, changeIgnoredIds;

    trueChecked = function ($block) {
        return $block.find('[id$=_true]:checked').length == 1;
    };

    falseChecked = function ($block) {
        return $block.find('[id$=_false]:checked').length == 1;
    };

    setVisibility = function (boolean, element) {
        (boolean) ? element.show().attr('aria-hidden', false) : element.hide().attr('aria-hidden', true);
    };

    manageState = function ($block) {
        var $optSection, showOptSection, $unknownLabel, showUnknownLabel;

        $optSection = $block.find('.optional-section');
        showOptSection = trueChecked($block);
        setVisibility(showOptSection, $optSection);

        $unknownLabel = $block.find('label[for$=_unknown]');
        showUnknownLabel = trueChecked($block) || falseChecked($block);
        setVisibility(showUnknownLabel, $unknownLabel);
    };

    changeIgnoredIds = function (ids) {
        var id, newId;
        for (var i = 0; i < ids.length; i++) {
            id = ids[i];
            newId = id + '_no_events';
            $('#' + id).attr('id', newId);
            $('[for=' + id).attr('for', newId);
        }
    };

    $.fn.descendentElements = function (options) {

        var settings = $.extend({}, $.fn.descendentElements.defaults, options);

        changeIgnoredIds(settings.ignored_checkboxes);

        return this.each(function () {
            var $this = $(this);

            manageState($this);

            $this.on('change', function (e) {
                manageState($this);
            })
        })
    };

    $.fn.descendentElements.defaults = {
        ignored_checkboxes: ''
    }

}(jQuery));

$('.js_has_optional_section').descendentElements({ignored_checkboxes: ['risks_open_acct_true', 'risks_open_acct_false', 'risks_open_acct_unknown']});
