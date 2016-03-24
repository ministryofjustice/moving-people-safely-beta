module Pdf
  CoversheetCheckboxGroup = Struct.new(:attribute, :value) do
    include CheckboxClass

    def yes_checkbox_class
      checked_class_for(value == true)
    end

    def no_checkbox_class
      checked_class_for(value == false)
    end
  end
end
