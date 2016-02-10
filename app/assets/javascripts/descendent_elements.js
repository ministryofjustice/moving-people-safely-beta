'use strict';

(function ($) {

    var showOptionalSection, showSection, initialize;

    showOptionalSection = function (value) {
        return (value == 'true');
    };

    showSection = function (id, $element) {
        (showOptionalSection(id)) ? $element.show() : $element.hide();
    };

    initialize = function ($element, $optionalSection) {
        var value = $element.find(':checked').prop('value');
        showSection(value, $optionalSection);
    };

    $.fn.descendentElements = function () {

        return this.each(function () {
            var $this = $(this),
                $optionalSection = $('.optional-section', $this);

            initialize($this, $optionalSection);

            $('input', $this).on('change', function () {
                var $input = $(this),
                    value = $input.prop('value');
                showSection(value, $optionalSection);
            })
        })
    };

}(jQuery));

$('.js_has_optional_section').descendentElements();