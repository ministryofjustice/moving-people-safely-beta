'use strict';

(function ($) {

    var trueChecked, falseChecked, manageState, displayUnknownLabel, displayOptSection;

    trueChecked = function ($block) {
        return $block.find('[id$=_true]:checked').length == 1;
    };

    falseChecked = function ($block) {
        return $block.find('[id$=_false]:checked').length == 1;
    };

    displayUnknownLabel = function($block) {
        var $unknownLabel = $block.find('label[for$=_unknown]');
        (trueChecked($block) || falseChecked($block)) ? $unknownLabel.show() : $unknownLabel.hide();
    };

    displayOptSection = function ($block) {
        var $optSection = $block.find('.optional-section');
        (trueChecked($block)) ? $optSection.show() : $optSection.hide();
    };

    manageState = function ($block) {
        displayOptSection($block);
        displayUnknownLabel($block);
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