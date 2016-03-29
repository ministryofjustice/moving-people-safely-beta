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

    checkbox_group :allergies,        on: :health_information
    checkbox_group :disabilities,     on: :health_information
    checkbox_group :violence,         on: :risk_information
    checkbox_group :escape,           on: :risk_information
    checkbox_group :non_association,  on: :risk_information
    checkbox_group :open_acct,        on: :risk_information
  end
end
