module Pdf
  CoversheetCheckboxGroup = Struct.new(:attribute, :value) do
    include CheckboxClass

    def yes_checkbox_class
      checked_class_for(value == true)
    end

    def no_checkbox_class
      checked_class_for(value == false)
    end

  private

    def checked_class_for(checkbox_type)
      if checkbox_type
        Pdf::HtmlClasses.checked
      end
    end
  end
end
