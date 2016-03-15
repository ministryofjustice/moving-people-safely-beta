'use strict';

(function ($) {

    var trueChecked, falseChecked, manageState, setVisibility;

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

    $.fn.descendentElements = function () {
        return this.each(function () {
            var $this = $(this);
            manageState($this);
            $this.on('change', function (e) {
                manageState($this);
            })
        })
    };

}(jQuery));

$('.js_has_optional_section').descendentElements();
