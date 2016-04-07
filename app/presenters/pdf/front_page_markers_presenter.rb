module Pdf
  class FrontPageMarkersPresenter
    def initialize(model)
      @model = model
    end

    def self.checkbox_group(attribute, on:)
      define_method(attribute) do
        sub_model = on
        value = @model.public_send(sub_model).public_send(attribute)
        Pdf::CoversheetCheckboxGroup.new(attribute, value)
      end
    end

    checkbox_group :allergies,        on: :healthcare
    checkbox_group :disabilities,     on: :healthcare
    checkbox_group :violence,         on: :risks
    checkbox_group :escape,           on: :risks
    checkbox_group :non_association,  on: :risks
    checkbox_group :open_acct,        on: :risks
  end
end
